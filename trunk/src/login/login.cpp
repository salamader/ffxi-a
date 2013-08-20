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
		
		
		 if (strcmp(argv[i], "--login_config") == 0 || strcmp(argv[i], "--login-config") == 0)
			LOGIN_CONF_FILENAME=argv[i+1];
		else if (strcmp(argv[i], "--lan_config") == 0 || strcmp(argv[i], "--lan-config") == 0 )
			lan_cfgName = argv[i+1];
		
	}

	
	login_config.uiLobbyDataIp   = INADDR_ANY;
	login_config.usLobbyDataPort = 54230;
	login_config.uiLobbyViewIp   = INADDR_ANY;
	login_config.usLobbyViewPort = 54001;
	login_config.uiLoginAuthIp   = INADDR_ANY;
	login_config.usLoginAuthPort = 54231;

	
	login_config_read(LOGIN_CONF_FILENAME);


	login_fd		   = makeListenBind_tcp(login_config.uiLoginAuthIp,login_config.usLoginAuthPort,connect_client_login);
	

	login_lobbydata_fd = makeListenBind_tcp(login_config.uiLobbyDataIp,login_config.usLobbyDataPort,connect_client_lobbydata);
	

	login_lobbyview_fd = makeListenBind_tcp(login_config.uiLobbyViewIp,login_config.usLobbyViewPort,connect_client_lobbyview);
	
SqlHandle = Sql_Malloc();
			 if( Sql_Connect(SqlHandle,login_config.mysql_login,
                              login_config.mysql_password,
                              login_config.mysql_host,
                              login_config.mysql_port,
                              login_config.mysql_database) == SQL_ERROR )
	{
		ShowError("cant connect\n");
	}
	
	Sql_Keepalive(SqlHandle);
	return 0;
}

void do_final(void)
{
	aFree((void*)login_config.mysql_login);
	aFree((void*)login_config.mysql_password);
	aFree((void*)login_config.mysql_host);
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
			//ShowFatalError("do_sockets: select() failed, error code %d!\n", sErrno);
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

	
	for (i = 1; i < fd_max; i++)
	{
		if(!session[i])
			continue;

		if(session[i]->wdata_size)
			session[i]->func_send(i);
	}
	Sql_Keepalive(SqlHandle);
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
		//ShowError("login configuration file not found at: %s\n", cfgName);
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
		else if (strcmp(w1, "DNS_Servers_Addess" ) == 0)
        {
			login_config.DNS_Servers_Address = aStrdup(w2);
        }
		else if (strcmp(w1,"mysql_host") == 0)
		{
			login_config.mysql_host = aStrdup(w2);
		}
		else if (strcmp(w1,"mysql_login") == 0)
		{
			login_config.mysql_login = aStrdup(w2);
		}
		else if (strcmp(w1,"mysql_password") == 0)
		{
			login_config.mysql_password = aStrdup(w2);
		}
		else if (strcmp(w1,"mysql_port") == 0)
		{
			login_config.mysql_port = atoi(w2);
		}
		else if (strcmp(w1,"mysql_database") == 0)
		{
			login_config.mysql_database = aStrdup(w2);
		}
       
        else if (strcmpi(w1, "import") == 0)
        {
			login_config_read(w2);
        }
		else
        {
			//ShowWarning("Unknown setting '%s' in file %s\n", w1, cfgName);
        }
	}

	fclose(fp);
	
	return 0;
}







