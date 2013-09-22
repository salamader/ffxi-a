/*
===========================================================================

  Copyright (c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "../common/mmo.h"
#include "../common/malloc.h"
#include "../common/showmsg.h"
#include "../common/timer.h"
#include "../common/version.h"
#include "../common/strlib.h"
#include "../common/utils.h"
#include "../common/blowfish.h"
#include "../common/malloc.h"
#include "../common/md52.h"



#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "login.h"
#include "login_auth.h"
#include "lobby.h"


const char *LOGIN_CONF_FILENAME = NULL;

//lan_config_t   lan_config;		// lan settings
login_config_t login_config;	//main settings



Sql_t *SqlHandle = NULL;



int32 do_init(int32 argc,char** argv)
{
	int32 i;
	LOGIN_CONF_FILENAME = "conf/login_darkstar.conf";

	const char *lan_cfgName = LAN_CONFIG_NAME;
	//srand(gettick());

	for (i = 1; i < argc ; i++) {
		if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "--h") == 0 || strcmp(argv[i], "--?") == 0 || strcmp(argv[i], "/?") == 0)
			login_helpscreen(1);
		else if (strcmp(argv[i], "--version") == 0 || strcmp(argv[i], "--v") == 0 || strcmp(argv[i], "-v") == 0 || strcmp(argv[i], "/v") == 0)
			login_versionscreen(1);
		else if (strcmp(argv[i], "--login_config") == 0 || strcmp(argv[i], "--login-config") == 0)
			LOGIN_CONF_FILENAME=argv[i+1];
		else if (strcmp(argv[i], "--lan_config") == 0 || strcmp(argv[i], "--lan-config") == 0 )
			lan_cfgName = argv[i+1];
		else if (strcmp(argv[i],"--run_once") == 0)	// close the map-server as soon as its done.. for testing [Celest]
			runflag = 0;
	}

	//lan_config_default(&lan_config);
	//lan_config_read(lan_cfgName,&lan_config);


	login_config_default();
	login_config_read(LOGIN_CONF_FILENAME);


	login_fd		   = makeListenBind_tcp(login_config.uiLoginAuthIp,login_config.usLoginAuthPort,connect_client_login);
	ShowStatus("The login-server-auth is " CL_GREEN"ready" CL_RESET" (Server is listening on the port %u).\n\n", login_config.usLoginAuthPort);

	login_lobbydata_fd = makeListenBind_tcp(login_config.uiLobbyDataIp,login_config.usLobbyDataPort,connect_client_lobbydata);
	ShowStatus("The login-server-lobbydata is " CL_GREEN"ready" CL_RESET" (Server is listening on the port %u).\n\n", login_config.usLobbyDataPort);

	login_lobbyview_fd = makeListenBind_tcp(login_config.uiLobbyViewIp,login_config.usLobbyViewPort,connect_client_lobbyview);
	ShowStatus("The login-server-lobbyview is " CL_GREEN"ready" CL_RESET" (Server is listening on the port %u).\n\n", login_config.usLobbyViewPort);

	SqlHandle = Sql_Malloc();
	if( Sql_Connect(SqlHandle,login_config.mysql_login,
							  login_config.mysql_password,
							  login_config.mysql_host,
							  login_config.mysql_port,
							  login_config.mysql_database) == SQL_ERROR )
	{
		exit(EXIT_FAILURE);
	}
    Sql_Keepalive(SqlHandle);

	const char *fmtQuery = "OPTIMIZE TABLE `accounts`,`accounts_banned`, `accounts_sessions`, `chars`,`char_equip`, \
						   `char_inventory`, `char_jobs`,`char_look`,`char_stats`, `char_vars`, `char_bazaar_msg`, \
						   `char_skills`, `char_titles`, `char_effects`, `char_exp`;";
	
	if( Sql_Query(SqlHandle,fmtQuery) == SQL_ERROR ) 
    {
		ShowError("do_init: Impossible to optimise tables\n");
	}
	
	ShowStatus("The login-server is " CL_GREEN"ready" CL_RESET" to work...\n");
	CTaskMgr::getInstance()->AddTask("Check_Lobby_For_Player_Cleanup", gettick(), NULL, CTaskMgr::TASK_INTERVAL, Check_Login_For_Player_Cleanup, 700);
	return 0;
}
uint32 getSysSecond()
{
	time_t now = time(0);
	tm *ltm = localtime(&now);

	return ltm->tm_sec;
}
int32 Check_Login_For_Player_Cleanup(uint32 tick, CTaskMgr::CTask* PTask)
{
 if(!login_sd_list.size() != NULL)
 {
	 //ShowMessage("login_sd_list IS EMPTY\n");
	 return false;
 }
uint32 lobby_time = getSysSecond()+3;


login_sd_list_t::iterator it = login_sd_list.begin(); 
while(it != login_sd_list.end())
{
	uint32 on_map = 0; /// 0 means no they are not on the map and 1 say they are on map
	uint32 map_time = 0;
	uint32 online = 0;
	//ShowMessage("LOBBY_TIME %u LOGIN LIST %u\n",lobby_time,(*it)->accid);
	const char * Query = "SELECT map_time,on_map,online FROM accounts WHERE id= '%u';";
	           int32 ret3 = Sql_Query(SqlHandle,Query,(*it)->accid);
			   if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)//START DATABASE SELECTION
	            {
				map_time =  Sql_GetUIntData(SqlHandle,0);
				on_map =  Sql_GetUIntData(SqlHandle,1);
				online =  Sql_GetUIntData(SqlHandle,2);
				//ShowMessage("LOBBY_TIME %u MAP_TIME %u\n",lobby_time,map_time);
				//ShowMessage("THIS PLAYER IS IN LOBBY SESSIONS ID %u\n",it);
				//const char* Query = "UPDATE accounts SET  lobby_time = '%u' WHERE id = %u";
                //Sql_Query(SqlHandle,Query,lobby_time,(*it)->accid);
				if(online == 0)
				{
                // ShowMessage("ONLINE STATUS MIGHT NEED LOGOUT_CORRECT %u\n",online);
				}
				if(on_map == 1)
				{
					//lobby_session  accounts_sessions accid
                //ShowMessage(CL_BG_YELLOW"THIS PLAYER IS ON MAP SO LETS COUNT OUT ACCOUNT ID %u\n"CL_RESET,(*it)->accid);
				/*
				orderby lobby session list and update targetid by 1 for each user.
				const char* Query = "UPDATE accounts_sessions SET lobby_session ='%u' WHERE accid = %u";
                Sql_Query(SqlHandle,Query,map_time ,(*it)->accid);
				const int8* fmtQuery = "SELECT max(targid) FROM accounts_sessions";

	                  if( Sql_Query(SqlHandle,fmtQuery) == SQL_ERROR )
	                    {
		                 return;
	                    }

	                  uint32 targid = 0;

	                  if( Sql_NumRows(SqlHandle) != 0 )
	                    {
		                Sql_NextRow(SqlHandle);
		
		                targid = Sql_GetUIntData(SqlHandle,0) + 1;
						ShowMessage("MAX TARGETID COUNT %u \n" CL_RESET,targid);
						if(targid == 1)
						{
							targid = 1024;
							ShowMessage("MAX TARGETID NEW COUNT %u \n" CL_RESET,targid);
						}
                         PChar->targid = targid;
					  }

				*/
				}
				if(map_time == 0 
					|| map_time == 1 
					|| map_time == 2 
					|| map_time == 3
					|| map_time == 4
					|| map_time == 5
					|| map_time == 6
					|| map_time == 7)
					
				{ 
					map_time = lobby_time -7;
					//ShowMessage("MAP_TIME %u IS LESS THEN LOBBY COUNTER\n",map_time);
                 const char* Query = "UPDATE accounts SET map_time ='%u' WHERE id = %u";
                Sql_Query(SqlHandle,Query,map_time ,(*it)->accid);
				}
				if(lobby_time==map_time)
				{
                 //ShowMessage("LOBBY_TIME %u == MAP_TIME %u\n",lobby_time,map_time);
				//OK PLAYER IS FULLY LOGIN LETS UPDATE THE ACCOUTNS TABLE TO SAY ON MAP
				if(on_map == 1)
				{
				//lobby_time +=2;	
                ShowMessage("CLEAN UP PLAYER LEFT ON MAP SERVER NOW %u\n",on_map);
				const char* Query = "UPDATE accounts SET online ='0',on_map ='0' WHERE id = %u";
                Sql_Query(SqlHandle,Query,(*it)->accid);
				  Query = "UPDATE chars SET online = '0',shutdown='1' WHERE accid = %u";
                Sql_Query(SqlHandle,Query,(*it)->accid);
				ShowMessage("ERASE THE ACCOUNT FROM LOBBY SERVER NOW %u\n",(*it)->accid);
				do_close_lobbydata((*it),(*it)->login_fd);
				//login_sd_list.erase(it);
				
				}
				return false;
				}
				
			   }
	++it;
}
		


return false;
}

void do_final(void)
{
	aFree((void*)login_config.mysql_host);
	aFree((void*)login_config.mysql_login);
	aFree((void*)login_config.mysql_password);
	aFree((void*)login_config.mysql_database);


	Sql_Free(SqlHandle);
}

void do_abort(void)
{
	do_final();
}
void set_server_type()
{
	SERVER_TYPE = DARKSTAR_SERVER_LOGIN;
}

int do_sockets(int next)
{
	
	fd_set rfd;
	struct timeval timeout;
	int ret,i;


	// can timeout until the next tick
	timeout.tv_sec  = next/1000;
	timeout.tv_usec = next%1000*1000;


	memcpy(&rfd, &readfds, sizeof(rfd));
	ret = sSelect(fd_max, &rfd, NULL, NULL, &timeout);

	if( ret == SOCKET_ERROR )
	{
		if( sErrno != S_EINTR )
		{
			ShowFatalError("do_sockets: select() failed, error code %d!\n", sErrno);
			exit(EXIT_FAILURE);
		}
		return 0; // interrupted by a signal, just loop and try again
	}

	last_tick = time(NULL);

#if defined(WIN32)
	// on windows, enumerating all members of the fd_set is way faster if we access the internals
	for( i = 0; i < (int)rfd.fd_count; ++i )
	{
		int fd = sock2fd(rfd.fd_array[i]);
		if( session[fd] )
		{
			session[fd]->func_recv(fd);

			if( fd != login_fd &&
				fd != login_lobbydata_fd &&
				fd != login_lobbyview_fd  )
			{
				session[fd]->func_parse(fd);

				if(!session[fd])
					continue;
				
//				RFIFOFLUSH(fd);
			}
		}
	}
#else
	// otherwise assume that the fd_set is a bit-array and enumerate it in a standard way
	for( i = 1; ret && i < fd_max; ++i )
	{
		if(sFD_ISSET(i,&rfd) && session[i])
		{
			session[i]->func_recv(i);

			if( session[i] )
			{

					if(     i != login_fd &&
						i != login_lobbydata_fd &&
						i != login_lobbyview_fd  )
						{
							session[i]->func_parse(i);

							if(!session[i])
							continue;

//							RFIFOFLUSH(fd);
						}
					--ret;
				}
		}
	}
#endif

	/*
		// parse input data on each socket
	for(i = 1; i < fd_max; i++)
	{
		if(!session[i])
			continue;

		if (session[i]->rdata_tick && DIFF_TICK(last_tick, session[i]->rdata_tick) > stall_time) {
			ShowInfo("Session #%d timed out\n", i);
			set_eof(i);
		}

		session[i]->func_parse(i);

		if(!session[i])
			continue;

		// after parse, check client's RFIFO size to know if there is an invalid packet (too big and not parsed)
		if (session[i]->rdata_size == RFIFO_SIZE && session[i]->max_rdata == RFIFO_SIZE) {
			set_eof(i);
			continue;
		}
		RFIFOFLUSH(i);
	}*/


	for (i = 1; i < fd_max; i++)
	{
		if(!session[i])
			continue;

		if(session[i]->wdata_size)
			session[i]->func_send(i);
	}
	return 0;
}

int parse_console(char *buf)
{
	return 0;
}

int32 login_config_read(const char *cfgName)
{
	char line[1024], w1[1024], w2[1024];
	FILE *fp;

	fp = fopen(cfgName,"r");
	if( fp == NULL )
	{
		ShowError("login configuration file not found at: %s\n", cfgName);
		return 1;
	}

	while( fgets(line, sizeof(line), fp) )
	{
		char* ptr;

        if( line[0] == '#')
			continue;
		if( sscanf(line, "%[^:]: %[^\t\r\n]", w1, w2) < 2 )
			continue;

		//Strip trailing spaces
		ptr = w2 + strlen(w2);
		while (--ptr >= w2 && *ptr == ' ');
		ptr++;
		*ptr = '\0';
			
		if(strcmpi(w1,"timestamp_format") == 0)
        {
			strncpy(timestamp_format, w2, 20);
        }
		else if(strcmpi(w1,"stdout_with_ansisequence") == 0 )
        {
			stdout_with_ansisequence = config_switch(w2);
        }
		else if(strcmpi(w1,"console_silent") == 0 ) 
        {
			ShowInfo("Console Silent Setting: %d\n", atoi(w2));
			msg_silent = atoi(w2);
		} 
		else if (strcmp(w1, "DNS_Servers_Address" ) == 0)
        {
			login_config.DNS_Servers_Address = aStrdup(w2);
        }
		else if (strcmp(w1, "NETWORK_Servers_Address" ) == 0)
        {
			login_config.NETWORK_Servers_Address = aStrdup(w2);
        }
		
        else if (strcmp(w1, "mysql_host" ) == 0)
        {
			login_config.mysql_host = aStrdup(w2);
        }
        else if (strcmp(w1, "mysql_login" ) == 0)
        {
			login_config.mysql_login = aStrdup(w2);
        }
		else if (strcmp(w1, "mysql_password") == 0)
        {
			login_config.mysql_password = aStrdup(w2);
		}
		else if (strcmp(w1, "mysql_port") == 0)
        {
			login_config.mysql_port = atoi(w2);
		}
		else if (strcmp(w1,"mysql_database") == 0)
        {
			login_config.mysql_database = aStrdup(w2);
		}
        else if (strcmp(w1,"expansions") == 0)
        {
            login_config.expansions = atoi(w2);
		}
        else if (strcmp(w1,"servername") == 0)
        {
            login_config.servername = aStrdup(w2);
		}
        else if (strcmpi(w1, "import") == 0)
        {
			login_config_read(w2);
        }
		else
        {
			ShowWarning("Unknown setting '%s' in file %s\n", w1, cfgName);
        }
	}

	fclose(fp);
	return 0;
}
int32 login_config_default()
{
	login_config.uiLobbyDataIp   = INADDR_ANY;
	login_config.usLobbyDataPort = 54230;
	login_config.uiLobbyViewIp   = INADDR_ANY;
	login_config.usLobbyViewPort = 54001;
	login_config.uiLoginAuthIp   = INADDR_ANY;
	login_config.usLoginAuthPort = 54231;

    login_config.expansions = 0xFFFF;
    login_config.servername = "DarkStar";

	login_config.mysql_host     = "";
	login_config.mysql_login    = "";
	login_config.mysql_password = "";
	login_config.mysql_database = "";
	login_config.mysql_port     =  3306;
	return 0;
}

void login_versionscreen(int32 flag)
{
	ShowInfo(CL_WHITE "Darkstar version %d.%02d.%02d" CL_RESET"\n",
		DARKSTAR_MAJOR_VERSION, DARKSTAR_MINOR_VERSION, DARKSTAR_REVISION);
	ShowInfo(CL_GREEN "Website/Forum:" CL_RESET "\thttp://darkstarproject.ru/\n");
	ShowInfo("\nOpen " CL_WHITE "readme.html" CL_RESET " for more information.");
	if (flag) exit(EXIT_FAILURE);
}

void login_helpscreen(int32 flag)
{
	ShowMessage("Usage: login-server [options]\n");
	ShowMessage("Options:\n");
	ShowMessage(CL_WHITE"  Commands\t\t\tDescription\n" CL_RESET);
	ShowMessage("-----------------------------------------------------------------------------\n");
	ShowMessage("  --help, --h, --?, /?		Displays this help screen\n");
	ShowMessage("  --login-config <file>	Load login-server configuration from <file>\n");
	ShowMessage("  --lan-config	  <file>	Load lan configuration from <file>\n");
	ShowMessage("  --version, --v, -v, /v	Displays the server's version\n");
	ShowMessage("\n");
	if (flag) exit(EXIT_FAILURE);
}

///////////////////////////////////////////////////////
////////////////////////////////////////////////////////
