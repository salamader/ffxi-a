/*
===========================================================================

 Awesome

===========================================================================
*/

	
#include "../common/malloc.h"
#include "../common/socket.h"
#include "../common/showmsg.h"
#include "../common/strlib.h"
#include "../common/utils.h"
#include "../common/md52.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "login.h"
#include "login_auth.h"
#include "lobby.h"


int32 login_lobbydata_fd;
int32 login_lobbyview_fd;

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 connect_client_lobbydata(int32 listenfd)
{
	int32 fd = 0;
	struct sockaddr_in client_address;
	if( ( fd = connect_client(listenfd,client_address) ) != -1 )
	{
		create_session(fd, recv_to_fifo, send_from_fifo, lobbydata_parse);
		session[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
		session[fd]->client_port= ntohs(client_address.sin_port);
		ShowMessage(CL_YELLOW"CHECKING CONNECT CLIENT IP %u \n"CL_RESET,session[fd]->client_addr);
		ShowMessage(CL_YELLOW"CHECKING CONNECT CLIENT PORT %u \n"CL_RESET,session[fd]->client_port);// This line is new for the port system
		session[fd]->wdata[0] =1;
		WFIFOSET(fd,5);
	
		return fd;
	}
	return -1;
}

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 lobbydata_parse(int32 fd)
{
   login_session_data_t* sd = (login_session_data_t*)session[fd]->session_data;

   if( sd == NULL )
   {
      if( RFIFOREST(fd) >= 5 && RBUFB(session[fd]->rdata,0) == 161 )
      {
         unsigned char *buff = session[fd]->rdata;

         int32 accid = RBUFL(buff,1);

         sd = find_loginsd_byaccid(accid);
         if( sd == NULL )
         {
			 ShowMessage(CL_YELLOW"CHECKING CLOSE 1 \n"CL_RESET);
            do_close_tcp(fd);
            return -1;
         }

		 

		 uint8 online = 0;
         sd->login_lobbydata_fd    = fd;
         session[fd]->session_data = sd;
		 ShowMessage(CL_YELLOW"GETTING ACCOUNT ID %u CLEAN UP \n"CL_RESET,sd->accid);
		const char * Query = "SELECT online FROM accounts WHERE id = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,sd->accid);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u TO CLEAN UP SHUTING DOWN \n"CL_RESET,sd->accid);
						online =  Sql_GetIntData(SqlHandle,0);
						ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u CHECKING TO SEE IF THEY ARE ONLINE \n"CL_RESET,sd->accid);
						if(online == 0)
						{
						  ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u AND THEY ARE NOT ONLINE \n"CL_RESET,sd->accid);
		                  const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE accid = %u";
                         Sql_Query(SqlHandle,Query,sd->accid);
						 Query = "UPDATE accounts SET  online = '1' WHERE id = %u";
                         Sql_Query(SqlHandle,Query,sd->accid);
						}
						else
						{
							ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u AND THEY ARE ONLINE \n"CL_RESET,sd->accid);
                            do_close_tcp(sd->login_lobbyview_fd);
			                erase_loginsd_byaccid(sd->accid);
							do_close_login(sd,fd);
			                do_close_tcp(fd);
                        return -1;
						}

				    }
				 else
				 {
                   ShowMessage(CL_YELLOW"NO ACCOUNT FOUND IN DATABASE BY THE ID %u \n"CL_RESET,sd->accid);
				 }
         return 0;
      }

	  if( sd == NULL )
        {
            do_close_tcp(fd);
            return -1;
        }

   }

   

   
   if( session[fd]->flag.eof )
   {
	   if(sd != NULL)
	   {
	  	 do_close_lobbydata(sd,fd);
	   }
      return 0;
   }

   if( RFIFOREST(fd) >= 1 )
   {
      unsigned char *buff = session[fd]->rdata;

      int32 code = RBUFB(buff,0); 
      switch(code)
      {
         case 161:
         {
			 
            if( RFIFOREST(fd) < 9 )
            {
              
               do_close_lobbydata(sd,fd);
			   ShowMessage(CL_YELLOW"CHECKING CLOSE 3 \n"CL_RESET);
               return -1;
            }
            char uList[300];
            memset(uList,0,sizeof(uList));

            sd->servip = RBUFL(buff,5);
            unsigned char CharList[2500];
				memset(CharList,0,sizeof(CharList));
				
				CharList[0] = 0xE0;CharList[1] = 0x08;
				CharList[4] = 0x49;CharList[5] = 0x58;CharList[6] = 0x46;CharList[7] = 0x46;CharList[8] = 0x20;

            CharList[28] = 32; // количество ячеек, доступных для создания персонажей (0-16)// THE CHARATERS SLOT COUNT OR MAYBE THE CONTENT IDS INCLUED UNKOWNEn
			/*OK HERE WE ARE GETTING THE CONTENT IDS FROM THE DATABSE WERE THE PLAYERS ACCOUNT ID IS THIS WORKS FINE */
			int32 Content_ID = 1; //DEFAULT TO SEE IF THEY ARE NEW CREATED CHAR OR A RETURNING CHAR
                const char * Query = "SELECT content_ids FROM accounts WHERE id = '%u';";
             int32 ret1 = Sql_Query(SqlHandle,Query,sd->accid);//THIS IS WORKING FIN ITS SELCTEING THE CONTEN IDS FROM ACCOUNTS TABLE 

                if (ret1 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS) //IF TRUE DO THIS ELSE DO THaT
                   {
                  Content_ID =  Sql_GetIntData(SqlHandle,0);
                  ShowMessage(CL_GREEN"GET CONTENT ID AMOUNT %u OF PLAYER %u \n" CL_RESET,Content_ID,sd->accid);
                }
             else
             {
                   ShowMessage(CL_GREEN"SHOULD NEVER SEE THIS PLAYER IS NOT IN DATABASE \n" CL_RESET);
				   do_close_lobbydata(sd,fd);//MOST CASES IF NOT CORRECT CLOSE SOMETHING
				   return -1;
             }
				/*NOW WE ARE GETTING THE BASIC INFO FOR THAT ACCOUNT ALL THAT IS ASSOICATED LOL */

				const char *pfmtQuery =  "SELECT charid, charname, pos_zone, mjob,\
												 race, face, head, body, hands, legs, feet, main, sub,\
												 war, mnk, whm, blm, rdm, thf, pld, drk, bst, brd, rng,\
												 sam, nin, drg, smn, blu, cor, pup, dnc, sch, geo, run \
										  FROM chars \
											INNER JOIN char_stats USING(charid)\
											INNER JOIN char_look  USING(charid) \
											INNER JOIN char_jobs  USING(charid) \
										  WHERE accid = %i \
										  ORDER BY  charid ASC \
										  LIMIT 16;";// SELECTING ALOT OF INFORMATION TO BUILD THE PLAYERS CHARACTER


            int32 ret =  Sql_Query(SqlHandle,pfmtQuery,sd->accid);
            if( ret == SQL_ERROR )// IF WE HAVE A ERRO DO THIS ELSE
            {
				ShowMessage(CL_YELLOW"CHECKING CLOSE 4 \n"CL_RESET);
               do_close_lobbydata(sd,fd);
               return -1;
            }
            // RUN TEH CODE AND KEEP GOING

            LOBBY_A1_RESERVEPACKET(ReservePacket);// ALWASY REVERING THE IMFORMATION UNKOWN WHY 

            
            

                memcpy(ReservePacket+60, "FFXI-A", dsp_cap(strlen("FFXI-A"), 0, 15));//MORE MEMORY HOLDING THE SERVERS NAME 


           

				//IF MORE THEN ONE CONTENT ID WE GET DOWNLOADING ERRORS AGAIN~
            for(int j = 0; j<Content_ID; ++j) 
           {
			   
                
				memcpy(CharList+32+140*j, ReservePacket+32, 140);
					char ContentID[3];
					memcpy(ContentID, CharList+32, sizeof(ContentID));
					ContentID[2] += j;

					memcpy(CharList+32+140*j, &ContentID, 3);
					memcpy(uList+16*(j+1),&ContentID, 3);
              
			   
                    
		   }

            uList[0] = 0x03;// THE HOLDER FOR THE CHARATERS ALLOWED TO HAVE FROM CONTENT IDS


            int i = 0;// THIS IS 0 count
            
			//NOW WE MATCH IT WITH THE DATABASE SO IF CONTENT ID1 get charid 1 from that account
            while(Sql_NextRow(SqlHandle) != SQL_NO_DATA)// WHILE IS RUNNIG A COUNT LOOP SAYING IF THERE IS MORE THEN 1 CHARACTER ON THE SERVER RUN AGAIN FIND THEM ALL
            {
				
			  // BUILDING THE CHARACTER
               char* strCharName = NULL;
               
               Sql_GetData(SqlHandle,1,&strCharName,NULL);
			   ShowMessage(CL_GREEN"GET CHARACTERS NAME: %s  \n"CL_RESET,strCharName );// WE GET THE NAME
               uint32 CharID    = Sql_GetIntData(SqlHandle,0);
			   ShowMessage(CL_GREEN"GET CHAR ID: %u  \n"CL_RESET,CharID );// WE GET THE ID AND OTHER CRAP
               
               uint8 zone       = (uint8)Sql_GetIntData(SqlHandle,2);
			  // ShowNotice(CL_GREEN"GET ZONE ID: %u  \n"CL_RESET,zone );
               
			   

               uint8 MainJob    = (uint8)Sql_GetIntData(SqlHandle,3);
			 //  ShowNotice(CL_GREEN"GET MAIN JOB ID: %u  \n"CL_RESET,MainJob );
               uint8 lvlMainJob = (uint8)Sql_GetIntData(SqlHandle,12+MainJob);
			 //  ShowNotice(CL_GREEN"GET MAIN JOB LEVEL ID: %u  \n"CL_RESET,lvlMainJob );
			  
				   WBUFL(uList,20*(i+1)) = CharID;

               ////////////////////////////////////////////////////
               WBUFL(CharList,4+32+i*140) = CharID;

               memcpy(CharList+12+32+i*140,strCharName, 15);

               WBUFB(CharList,46+32+i*140) = MainJob;
               WBUFB(CharList,73+32+i*140) = lvlMainJob; 

               WBUFB(CharList,44+32+i*140) = (uint8) Sql_GetIntData(SqlHandle, 4); // race;
               WBUFB(CharList,56+32+i*140) = (uint8) Sql_GetIntData(SqlHandle, 5); // face;
               WBUFW(CharList,58+32+i*140) = (uint16)Sql_GetIntData(SqlHandle, 6); // head;
               WBUFW(CharList,60+32+i*140) = (uint16)Sql_GetIntData(SqlHandle, 7); // body;
               WBUFW(CharList,62+32+i*140) = (uint16)Sql_GetIntData(SqlHandle, 8); // hands;
               WBUFW(CharList,64+32+i*140) = (uint16)Sql_GetIntData(SqlHandle,9); // legs;
               WBUFW(CharList,66+32+i*140) = (uint16)Sql_GetIntData(SqlHandle,10); // feet;
               WBUFW(CharList,68+32+i*140) = (uint16)Sql_GetIntData(SqlHandle,11); // main;
               WBUFW(CharList,70+32+i*140) = (uint16)Sql_GetIntData(SqlHandle,12); // sub;

               WBUFB(CharList,72+32+i*140) = zone;//(zone == 0 ? prevzone : zone);      // если персонаж в MogHouse
			  
               
               ///////////////////////////////////////////////////
				
				
				
               ++i;// IF MORE CHARS ARE FOUND RUN AGAIN ELSE
            }

			//COME HERE

            if(session[sd->login_lobbyview_fd]!=NULL)
			{
               uList[1] = 0x10;
					memcpy(session[fd]->wdata,uList,0x110);
					WFIFOSET(fd,0x110);
					RFIFOSKIP(fd,session[fd]->rdata_size);
					RFIFOFLUSH(fd);
					////////////////////////////////////////
				
					unsigned char hash[16];
					md5((unsigned char*)(CharList), hash, 2272);

					memcpy(CharList+12,hash,16);
					// write into lobbyview
					memcpy(session[sd->login_lobbyview_fd]->wdata,CharList,2272);
					WFIFOSET(sd->login_lobbyview_fd,2272);
					RFIFOSKIP(sd->login_lobbyview_fd,session[sd->login_lobbyview_fd]->rdata_size);
					RFIFOFLUSH(sd->login_lobbyview_fd);
			   
            }
            else{ //cleanup
              
				ShowMessage(CL_YELLOW"CHECKING CLOSE 5 \n"CL_RESET);
               do_close_lobbydata(sd,fd);
               return -1;
            }
            /////////////////////////////////////////

            break;
         }
      case 0xA2:
         {
                LOBBY_A2_RESERVEPACKET(ReservePacket);
				uint8 key3[20];
				memset(key3,0,sizeof(key3));
				memcpy(key3,buff+1,sizeof(key3));
				key3[16] -= 2;
				uint8 MainReservePacket[0x48];
				
				RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);

            if(session[sd->login_lobbyview_fd]==NULL){
              ShowMessage(CL_YELLOW"CHECKING CLOSE 6 \n"CL_RESET);
               do_close_lobbydata(sd,fd);
               return -1;
            }

            uint32 charid = RBUFL(session[sd->login_lobbyview_fd]->rdata,32);

            in_addr inaddr;
   inaddr.S_un.S_addr = inet_addr(login_config.DNS_Servers_Address);
   
   
   if( inaddr.S_un.S_addr == INADDR_NONE)
   {
      hostent* phostent = gethostbyname(login_config.DNS_Servers_Address);
      
      if( phostent == 0)
      {
         
         return 0;
      }

      if( sizeof(inaddr) != phostent->h_length)
      {
         
         return 0;; 
      }

      inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
      

      
   }

            const char *fmtQuery = "SELECT zoneid FROM zone_settings , chars  WHERE zoneid = pos_zone AND charid = %u;";
            uint32 ZoneIP   = inaddr.S_un.S_addr;//sd->servip;
                uint16 ZonePort = 54230;

            if( Sql_Query(SqlHandle,fmtQuery,charid) != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 )
            {
               Sql_NextRow(SqlHandle);
               
             if (Sql_GetIntData(SqlHandle,0) == 0)
				 {
					 key3[16] += 6;
			     }

               ZoneIP = inaddr.S_un.S_addr;
               ZonePort = 54230;
               uint8  ZoneID = (uint8)Sql_GetUIntData(SqlHandle,0);
               WBUFL(ReservePacket,(0x38)) = ZoneIP;
               WBUFW(ReservePacket,(0x3C)) = ZonePort;
              
            }else{
              
               WBUFL(ReservePacket,(0x38)) = ZoneIP;
                    
            }

            WBUFL(ReservePacket,(0x40)) = ZoneIP; 
           

            memcpy(MainReservePacket,ReservePacket,RBUFB(ReservePacket,0));

            //SO IN BASIC the port system to get it wrking i think i have it all set right 
			uint32 GetCharID = 0;
			const char * Query = "SELECT charid FROM accounts_sessions WHERE accid = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,sd->accid);
			
			  
	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						
						ShowMessage(CL_YELLOW"CHECKING CONNECT CLIENT PORT %u \n"CL_RESET,session[fd]->client_port);
		 
						GetCharID =  Sql_GetIntData(SqlHandle,0);
					
						int8 session_key[sizeof(key3)*2+1];
                        bin2hex(session_key,key3,sizeof(key3));

						Query = "UPDATE accounts_sessions SET accid = %u, charid = %u, session_key = x'%s', server_addr = %u, server_port = %u, client_addr = %u , client_port = %u WHERE charid = %u";

		Sql_Query(SqlHandle,Query,
			sd->accid,
			charid,
			session_key,
			ZoneIP,
			ZonePort,
			session[fd]->client_addr,
			session[fd]->client_port,
			GetCharID);
		
		

		unsigned char Hash[16];
				uint8 SendBuffSize = RBUFB(MainReservePacket,0);

				memset(MainReservePacket+12,0,sizeof(Hash));
				md5(MainReservePacket, Hash, SendBuffSize);

				memcpy(MainReservePacket+12,Hash,sizeof(Hash));
				memcpy(session[sd->login_lobbyview_fd]->wdata,MainReservePacket,SendBuffSize);
				WFIFOSET(sd->login_lobbyview_fd,SendBuffSize);

				RFIFOSKIP(sd->login_lobbyview_fd,session[sd->login_lobbyview_fd]->rdata_size);
				RFIFOFLUSH(sd->login_lobbyview_fd);
				ShowMessage(CL_GREEN"WE ARE LOGGING INTO THE MAP SERVER WITH ACCOUNT ID %u \n"CL_RESET,sd->accid);
				
            
            if (SendBuffSize == 0x24)
			{
               ShowMessage(CL_YELLOW"CHECKING CLOSE 7 \n"CL_RESET);
               return -1;
            }
			
            do_close_tcp(sd->login_lobbyview_fd);
			
						
				 }
				 else
				 {
					
		
            int8 session_key[sizeof(key3)*2+1];
            bin2hex(session_key,key3,sizeof(key3));
			

			const int8* fmtQuery = "SELECT max(targid) FROM accounts_sessions";

	if( Sql_Query(SqlHandle,fmtQuery) == SQL_ERROR )
	{
		return -1;
	}

	uint32 targid = 0;

	if( Sql_NumRows(SqlHandle) != 0 )
	{
		Sql_NextRow(SqlHandle);
		
		targid = Sql_GetUIntData(SqlHandle,0) + 1;
		ShowMessage("MAX CHAR COUNT %u \n" CL_RESET,targid);
		
		ShowMessage(CL_YELLOW"WE ARE INSERTING OUR SESSION ID ON ACCOUNT %u \n"CL_RESET,sd->accid);

		fmtQuery = "INSERT INTO accounts_sessions(accid,charid,session_key,server_addr,server_port,client_addr,client_port,targid) VALUES(%u,%u,x'%s',%u,%u,%u,%u,%u) ON DUPLICATE KEY UPDATE charid = charid;";

            if( Sql_Query(SqlHandle, fmtQuery, sd->accid, charid, session_key, ZoneIP, ZonePort, sd->client_addr,sd->client_port,targid ) == SQL_ERROR )
            {
               ShowMessage(CL_YELLOW"WE HAVE A BAD INSERT OUR SESSION ID ON ACCOUNT %u \n"CL_RESET,sd->accid);
                   LOBBBY_ERROR_MESSAGE(ReservePacket);
					
					WBUFW(ReservePacket,32) = 305; 
					memcpy(MainReservePacket,ReservePacket,RBUFB(ReservePacket,0));
            }
		
		
	}
			
            
         
            unsigned char Hash[16];
            uint8 SendBuffSize = RBUFB(MainReservePacket,0);

            memset(MainReservePacket+12,0,sizeof(Hash));
            md5(MainReservePacket, Hash, SendBuffSize);

            memcpy(MainReservePacket+12,Hash,sizeof(Hash));
            memcpy(session[sd->login_lobbyview_fd]->wdata,MainReservePacket,SendBuffSize);
            WFIFOSET(sd->login_lobbyview_fd,SendBuffSize);

            RFIFOSKIP(sd->login_lobbyview_fd,session[sd->login_lobbyview_fd]->rdata_size);
            RFIFOFLUSH(sd->login_lobbyview_fd);
            
            if (SendBuffSize == 0x24)
			{
               ShowMessage(CL_YELLOW"CHECKING CLOSE 8 \n"CL_RESET);
               return -1;
            }
			
            do_close_tcp(sd->login_lobbyview_fd);
			}
         
            break;
         }
      default:

         break;
      }
   }
   return 0;
};

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 do_close_lobbydata(login_session_data_t *loginsd,int32 fd)
{
	
			ShowMessage(CL_YELLOW"CLOSEING LOBBY DATA \n"CL_RESET);
	if( loginsd != NULL )
	{ 
		uint8 online = 0;
		ShowMessage(CL_GREEN"GETTING ACCOUNT ID %u TO CLOSE \n"CL_RESET,loginsd->accid);
		const char * Query = "SELECT online FROM accounts WHERE id = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,loginsd->accid);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						ShowMessage(CL_GREEN"FOUND ACCOUNT ID %u TO CLOSE  \n"CL_RESET,loginsd->accid);
						ShowMessage(CL_GREEN"FOUND ACCOUNT ID %u CHECKING IF PLAYER IS ONLINE \n"CL_RESET,loginsd->accid);
						online =  Sql_GetIntData(SqlHandle,0);
						if(online == 1)
						{
							ShowMessage(CL_GREEN"FOUND ACCOUNT ID %u PLAYER IS ONLINE \n"CL_RESET,loginsd->accid);
							const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE accid = %u";
                        Sql_Query(SqlHandle,Query,loginsd->accid);
							Query = "UPDATE accounts SET  online = '0' WHERE id = %u";
                        Sql_Query(SqlHandle,Query,loginsd->accid);
							do_close_tcp(loginsd->login_lobbyview_fd);
			                erase_loginsd_byaccid(loginsd->accid);
							do_close_login(loginsd,fd);
			                do_close_tcp(fd);
							return -1;
						}
						else
						{
							ShowMessage(CL_GREEN"FOUND ACCOUNT ID %u PLAYER IS NOT ONLINE \n"CL_RESET,loginsd->accid);
		                const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE accid = %u";
                        Sql_Query(SqlHandle,Query,loginsd->accid);
						Query = "UPDATE accounts SET  online = '0' WHERE id = %u";
                        Sql_Query(SqlHandle,Query,loginsd->accid);
						do_close_tcp(loginsd->login_lobbyview_fd);
			            erase_loginsd_byaccid(loginsd->accid);
			            do_close_tcp(fd);
						}
		
				    }
				 else
				 {
                   ShowMessage(CL_YELLOW"NO ACCOUNT FOUND IN DATABASE BY THE ID %u \n"CL_RESET,loginsd->accid);
				 }

		

		
		return 0;
	}
	
	return -1;
}

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 connect_client_lobbyview(int32 listenfd)
{
	int32 fd = 0;
	struct sockaddr_in client_address;
	if( ( fd = connect_client(listenfd,client_address) ) != -1 )
	{
		create_session(fd, recv_to_fifo, send_from_fifo, lobbyview_parse);
		session[fd]->client_addr = ntohl(client_address.sin_addr.s_addr);
		session[fd]->client_port = ntohs(client_address.sin_port);
		
		return fd;
	}
	return -1;
}

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 lobbyview_parse(int32 fd)
{
	login_session_data_t* sd = (login_session_data_t*)session[fd]->session_data;

	if( sd == NULL )
	{	
		sd = find_loginsd_by_ip_and_port(session[fd]->client_addr,session[fd]->client_port);
		if( sd == NULL )
		{
			
			do_close_tcp(fd);
			return -1;
		}
		session[fd]->session_data = sd;
		sd->login_lobbyview_fd	  = fd;
	}

	if( session[fd]->flag.eof )
	{
		do_close_lobbyview(sd,fd);
		return 0;
	}

	if( RFIFOREST(fd) >= 9)
	{
		unsigned char *buff = session[fd]->rdata;
		
		uint8 code = RBUFB(buff,8);
		
		switch(code)
		{
		case 38:
			{
				
				uint8 SendBuffSize = 40;

				LOBBY_026_RESERVEPACKET(ReservPacket);
				WBUFW(ReservPacket,32) = 65535;
			
				
				unsigned char Hash[16];
				md5(ReservPacket, Hash, SendBuffSize);
				memcpy(ReservPacket+12,Hash,16);
				
				memcpy(session[fd]->wdata,ReservPacket,SendBuffSize);
                RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);
				WFIFOSET(fd,SendBuffSize);
				
				
			}
			break;
		case 20:
			{
				
				uint32 ContentID = RBUFL(session[fd]->rdata,28);
				//DebugPrint("[LViewServ]Content ID: %.8X (%d)",ContentID,ContentID);
				
				uint32 CharID = RBUFL(session[fd]->rdata,32);

				ShowMessage(CL_YELLOW"GETTING INFORMATION BEFORE DELETE CHARACTER\n"CL_RESET);
				ShowMessage(CL_YELLOW"GETTING ACCOUNT ID %u\n"CL_RESET,sd->accid);
				ShowMessage(CL_YELLOW"GETTING CHARS ID %u\n"CL_RESET,CharID);
				ShowMessage(CL_YELLOW"GETTING IP ADDRESS ID %u\n"CL_RESET,sd->client_addr);
				ShowMessage(CL_YELLOW"GETTING IP PORT ID %u\n"CL_RESET,sd->client_port);


               const char *  Query = "SELECT charid FROM chars WHERE accid = '%u';";
	          int32  ret = Sql_Query(SqlHandle,Query,sd->accid);

	             if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						//ShowNotice(CL_GREEN"DELETEING CHARATER ID: %d FROM IP: %s\n"CL_RESET,CharID,ip2str(sd->client_addr,NULL));
				
						CharID =  Sql_GetIntData(SqlHandle,0);
						ShowMessage(CL_GREEN"CHECKING CHAR ID %u\n"CL_RESET,CharID);
						Query = "DELETE FROM chars WHERE charid = %u";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_weapon_skill_points WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_vars WHERE charid ='%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_storage WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_stats WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_skills WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_profile WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_points WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_pet_name WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_look WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_jobs WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_inventory WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_exp WHERE charid = '%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_equip WHERE charid ='%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM char_effects WHERE charid ='%u'";
				Sql_Query(SqlHandle,Query,CharID);

				Query = "DELETE FROM delivery_box WHERE charid ='%u'";
				Sql_Query(SqlHandle,Query,CharID);
				
				    }
				 else
				 {
                   ShowMessage(CL_RED"SO WHAT IS MY CHAR ID IF NOT FOUND %s \n" CL_RESET,session[fd]->rdata);
				   ShowDebug(CL_RED"WE SHOULD NEVER SEE THIS  \n" CL_RESET);
				  do_close_lobbyview(sd,fd);
				 }
				
				uint8 sendsize = 32;
				
				LOBBY_ACTION_DONE(ReservePacket);
				unsigned char hash[16];

				md5(ReservePacket, hash, sendsize);
				memcpy(ReservePacket+12,hash,16);

				memcpy(session[fd]->wdata,ReservePacket,sendsize);
				WFIFOSET(fd,sendsize);
				RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);
				
				break;
			}
		case 31:
			{
				
				if(session[sd->login_lobbydata_fd]==NULL)
				{
					
					uint32 val = 1337;
					if(sd->login_lobbydata_fd-1>=0 && session[sd->login_lobbydata_fd-1]!=NULL)
					{
						val = session[sd->login_lobbydata_fd-1]->client_addr;
						val = session[sd->login_lobbydata_fd-1]->client_port;
						
					}
					ShowMessage(CL_YELLOW"CHECKING CLOSE 14 \n"CL_RESET);
					do_close_tcp(fd);
					return -1;
				}
				memset(session[sd->login_lobbydata_fd]->wdata,0,5);
				WBUFB(session[sd->login_lobbydata_fd]->wdata,0) = 1;
				WFIFOSET(sd->login_lobbydata_fd,5);
				
			}
			break;
		case 36:
			{
				 LOBBY_024_RESERVEPACKET(ReservePacket);
				uint8 key3[20];
				memset(key3,0,sizeof(key3));
				memcpy(key3,buff+1,sizeof(key3));
				key3[16] -= 2;
				
				memcpy(ReservePacket+36, "FFXI_A", dsp_cap(strlen("FFXI-A"), 0, 15));

				unsigned char Hash[16];

				md5((unsigned char*)(ReservePacket), Hash, 64);

				memcpy(ReservePacket+12,Hash,16);
				uint8 SendBuffSize = 64;
				memcpy(session[fd]->wdata, ReservePacket, SendBuffSize);
				RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);
				WFIFOSET(fd,SendBuffSize);
				

           uint32 GetCharID = 0;
			const char * Query = "SELECT charid FROM accounts_sessions WHERE accid = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,sd->accid);
			
			  ShowMessage(CL_YELLOW"CHECKING CONNECT CLIENT PORT %u \n"CL_RESET,session[fd]->client_port);
	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						ShowMessage(CL_YELLOW"WE ARE UPDATEING OUR SESSION ID FOR ACCOUNT ID %u\n"CL_RESET,sd->accid);
						GetCharID =  Sql_GetIntData(SqlHandle,0);
					
						int8 session_key[sizeof(key3)*2+1];
                        bin2hex(session_key,key3,sizeof(key3));

						Query = "UPDATE accounts_sessions SET charid = %u, session_key = x'%s' WHERE charid = %u";

		Sql_Query(SqlHandle,Query,
			GetCharID,
			session_key,
			sd->accid);
		
		

		

						
				 }
				 else
				 {
					 ShowMessage(CL_YELLOW"NO ACCOUNT FOUND IN THE DATABSE \n"CL_RESET);
				 }
				 
				
				 
        
				

			
				
				

			}
			break;
		case 7:
			{
				
				
				
	
				string_t Characters_Name ="";
				uint32 Char_Id =0;
				
				uint32 CharID = RBUFL(session[fd]->rdata,32);
				const char *Query = "SELECT charid,charname FROM chars WHERE charname= '%s';";

				int32  ret = Sql_Query(SqlHandle,Query,sd->charname);

	             if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						//THIS IS ON CHARATER CREATE WE SEE THIS FINE
						
				       Char_Id =  Sql_GetIntData(SqlHandle,0);
						Characters_Name=  Sql_GetData(SqlHandle,1);
						
						ShowMessage(CL_RED"CHECKING CREATE CHAR SUCCESS ACCOUNT ID %u  \n"CL_RESET,sd->accid);
						ShowMessage(CL_RED"CHECKING CREATE CHAR SUCCESS CHAR NAME %s  \n"CL_RESET,Characters_Name.c_str() );
						ShowMessage(CL_RED"CHECKING CREATE CHAR SUCCESS CHAR ID %u  \n"CL_RESET,Char_Id);
						
				 }
				 else
				 {
					 //THIS IS CLIENT RETURNING TO SERVER
					 Query = "SELECT charid,charname FROM chars WHERE charid= '%u';";

				 ret = Sql_Query(SqlHandle,Query,CharID);
					 if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						//THIS IS ON CHARATER CREATE WE SEE THIS FINE
				       Char_Id =  Sql_GetIntData(SqlHandle,0);
						Characters_Name=  Sql_GetData(SqlHandle,1);
						
						ShowMessage(CL_RED"CHECKING RETURNING CHAR SUCCESS ACCOUNT ID %u  \n"CL_RESET,sd->accid);
						ShowMessage(CL_RED"CHECKING RETURNING CHAR SUCCESS CHAR NAME %s  \n"CL_RESET,Characters_Name.c_str() );
						ShowMessage(CL_RED"CHECKING RETURNING CHAR SUCCESS CHAR ID %u  \n"CL_RESET,Char_Id);
						//NOW WE SHOULD UPDATE ONLINE ???
						const char *Query = "UPDATE chars SET  online = '1', shutdown = '0', zoning ='-1', returning = '1' WHERE charid = %u";
                        Sql_Query(SqlHandle,Query,Char_Id);
					 }
					 else
					 {
					 
					    ShowDebug(CL_YELLOW"CHECKING CLOSE 20 \n"CL_RESET);
						do_close_lobbyview(sd,fd);
					 return -1;
					 }
						
				  
				 }

				
				
	

				
				
				
				if(session[sd->login_lobbydata_fd]==NULL)
				{
					
					uint32 val = 1337;
					if(sd->login_lobbydata_fd-1>=0 && session[sd->login_lobbydata_fd-1]!=NULL)
					{
						val = session[sd->login_lobbydata_fd-1]->client_addr;
						val = session[sd->login_lobbydata_fd-1]->client_port;
					}
					ShowNotice(CL_YELLOW"CHECKING CLOSE 15 \n"CL_RESET);
					do_close_tcp(fd);
					return -1;
				}
				
				memset(session[sd->login_lobbydata_fd]->wdata,0,5);
				WBUFB(session[sd->login_lobbydata_fd]->wdata,0) = 2;
				WFIFOSET(sd->login_lobbydata_fd,5);
				
			}
			break;
		case 33:
			{
				
				//creating new char
				if( lobby_createchar(sd,(char*)session[fd]->rdata) == -1)
				{
					ShowNotice(CL_YELLOW"CHECKING CLOSE 16 \n"CL_RESET);
					do_close_lobbyview(sd,fd);
					return -1;
				}
				char lobbydata_code[] = { 21, 7 };

				
				LOBBY_ACTION_DONE(ReservePacket);
				unsigned char hash[16];

				int32 sendsize = 32;
				//memset(ReservePacket+12,0,sizeof(16));
				md5((unsigned char*)(ReservePacket), hash, sendsize);

				memcpy(ReservePacket+12,hash,sizeof(hash));
				memcpy(session[fd]->wdata, ReservePacket, sendsize);
				WFIFOSET(fd,sendsize);
				RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);

			}
			break;
		case 34:
			{
				
				//creating new char
				char CharName[15];
				memset(CharName,0,sizeof(CharName));
				memcpy(CharName,session[fd]->rdata+32,sizeof(CharName));

				//find assigns
				const char *fmtQuery = "SELECT charname FROM chars WHERE charname LIKE '%s'";

				int32 sendsize=36;
				unsigned char MainReservePacket[36];

				ShowNotice(CL_RED"CHECKING CHAR NAME %s  \n"CL_RESET,CharName );
				if( Sql_Query(SqlHandle,fmtQuery,CharName) == SQL_ERROR )
				{
					ShowNotice(CL_YELLOW"CHECKING CLOSE 17 \n"CL_RESET);
					do_close_lobbyview(sd,fd);
					return -1;
				}

				if( Sql_NumRows(SqlHandle) != 0 )
				{
					
					LOBBBY_ERROR_MESSAGE(ReservePacket);
					
					WBUFW(ReservePacket,32) = 313;
					memcpy(MainReservePacket,ReservePacket,sendsize);
				}else{
					//copy charname
					
					memcpy(sd->charname,CharName,15);
					sendsize = 32;
					LOBBY_ACTION_DONE(ReservePacket);
					memcpy(MainReservePacket,ReservePacket,sendsize);
				}
				unsigned char hash[16];

				md5(MainReservePacket, hash,sendsize);
				memcpy(MainReservePacket+12,hash,16);
				memcpy(session[fd]->wdata, MainReservePacket, sendsize);
				RFIFOSKIP(fd,session[fd]->rdata_size);
				RFIFOFLUSH(fd);

				WFIFOSET(fd,sendsize);
			}
			break;
		default:
			{
				ShowDebug(CL_BG_BLUE"DEFAULT MISSING ONE CASE\n"CL_RESET);

			}
			break;
		}
	}
	return 0;
};

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 do_close_lobbyview(login_session_data_t* sd, int32 fd)
{
		ShowMessage(CL_YELLOW"CLOSEING LOBBY VIEW \n"CL_RESET);
	if( sd != NULL )
	{
		uint8 online = 0;
	ShowMessage(CL_YELLOW"GETTING ACCOUNT ID %u TO CLOSE \n"CL_RESET,sd->accid);
		const char * Query = "SELECT online FROM accounts WHERE id = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,sd->accid);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {

						online = Sql_GetUIntData(SqlHandle,0);
						if(online == 1)
						{
						ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u NOT SURE MIGHT BE BACK WARDS \n"CL_RESET,sd->accid);
						}
						else
						{
							ShowMessage(CL_YELLOW"FOUND ACCOUNT ID %u TO CLOSE SHUTING DOWN \n"CL_RESET,sd->accid);
		const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE accid = %u";
		Sql_Query(SqlHandle,Query,sd->accid);
		Query = "UPDATE accounts SET  online = '0' WHERE id = %u";
		Sql_Query(SqlHandle,Query,sd->accid);
							
						}

		
				    }
				 else
				 {
                   ShowMessage(CL_YELLOW"NO ACCOUNT FOUND IN DATABASE BY THE ID %u \n"CL_RESET,sd->accid);
				 }
	
	do_close_tcp(fd);
	}
	else
	{
     ShowDebug(CL_YELLOW"CHECKING CLOSE UNK 18 \n"CL_RESET);
	}
	return 0;
}

/************************************************************************
*																		*
*																		*
*																		*
************************************************************************/

int32 lobby_createchar(login_session_data_t *loginsd, char *buf)
{
	
	ShowMessage(CL_GREEN"CHECKING CHARACTERS NAME: %s  \n"CL_RESET,loginsd->charname );
	srand(clock());
	char_mini createchar;

	memcpy(createchar.m_name,loginsd->charname,16);
	memset(&createchar.m_look,0,sizeof(look_t));

	
	createchar.m_look.race = RBUFB(buf,48);
	createchar.m_look.size = RBUFB(buf,57);
	createchar.m_look.face = RBUFB(buf,60);
	createchar.m_mjob      = RBUFB(buf,50);
	createchar.m_nation    = RBUFB(buf,54);

	switch(createchar.m_nation) 
	{
		case 0x02: 
			{ //windy start
			createchar.m_zone = 240;
			break;
			}
		case 0x01:
			{// bastok start
			createchar.m_zone = 234;
			break;
			}
		case 0x00:
			{// sandy start
			createchar.m_zone = 230;
			break;
			}
	}

	

	const int8* fmtQuery = "SELECT max(charid) FROM chars";

	if( Sql_Query(SqlHandle,fmtQuery) == SQL_ERROR )
	{
		return -1;
	}

	uint32 CharID = 0;

	if( Sql_NumRows(SqlHandle) != 0 )
	{
		Sql_NextRow(SqlHandle);
		
		CharID = Sql_GetUIntData(SqlHandle,0) + 1;
		ShowMessage("MAX CHAR COUNT %u \n" CL_RESET,CharID);
		lobby_createchar_save(loginsd->accid, CharID, &createchar);
		
	}

	
		
	

	
	return 0;
};



int32 lobby_createchar_save(uint32 accid, uint32 charid, char_mini* createchar )
{
	
	ShowDebug("PRINT CHARACTERS CHARID %u \n" CL_RESET,charid);
	uint32 pos_zone = createchar->m_zone;
	ShowDebug("PRINT CHARACTERS ZONE %u \n" CL_RESET,pos_zone );
	string_t charname = createchar->m_name;
	ShowDebug("PRINT CHARACTERS NAME %s \n" CL_RESET,charname );
	uint32 nation = createchar->m_nation;
	ShowDebug("PRINT CHARACTERS NATION %u \n" CL_RESET,nation );
	uint8 face = createchar->m_look.face;
	ShowDebug("PRINT CHARACTERS FACE %u \n" CL_RESET,face );
	uint8 race = createchar->m_look.race;
	ShowDebug("PRINT CHARACTERS RACE %u \n" CL_RESET,race );
	uint16 size = createchar->m_look.size;
	ShowDebug("PRINT CHARACTERS SIZE %u \n" CL_RESET,size );
	uint8 mjob = createchar->m_mjob;
	ShowDebug("PRINT CHARACTERS MJOB %u \n" CL_RESET,mjob );

	uint32 GetCharID = 0;
			const char * Query = "SELECT * FROM chars WHERE charid = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,charid);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						//IF THE ID IS IN THE DATABSE  LETS UPDATE THAT CHARATER
						ShowDebug("ERROR WE HAVE A UPDATE CALL ON CREATIONS FOR CHAR ID %u \n" CL_RESET,charid);
						return false;
				 }
				 else
				 {


				 const char* Query = "INSERT INTO chars(charid,accid,charname,pos_zone,nation) VALUES(%u,%u,'%s',%u,%u)ON DUPLICATE KEY UPDATE charid = charid;";

	if( Sql_Query(SqlHandle,Query,charid,accid,createchar->m_name,createchar->m_zone,createchar->m_nation) == SQL_ERROR )
	{
		ShowDebug("ERROR 1 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
		return -1;
	}

	 if(createchar->m_nation==0)
					  {
                      ShowNotice(CL_RED"TRACER: SANDY %u\n" CL_RESET,createchar->m_nation);
					  ShowNotice(CL_RED"TRACER: SANDY GETZONE %u\n" CL_RESET,createchar->m_zone);
					   if(createchar->m_zone==230 )
					  {
						  //SANDY
						  

						 Query = "UPDATE chars \
                            SET home_zone = '230', home_rot = '224', pos_rot = '224', home_x = '-96', pos_x = '-96', home_y = '-1', pos_y = '-1', home_z = '-40'  ,pos_z = '-40'  , pos_prevzone = '234',pos_zone ='0',first_login ='0',returning ='1',inevent='1',eventid='503' \
							WHERE charid = %u;";
                         Sql_Query(SqlHandle, Query, charid);
						//return;
					  }
                      // return;
			           
					  }
					  if(createchar->m_nation==1)
					  {
					  ShowNotice(CL_RED"TRACER: BASTOCK %u\n" CL_RESET,createchar->m_nation);
					  ShowNotice(CL_RED"TRACER: BASTOCK GETZONE %u\n" CL_RESET,createchar->m_zone);
					  if(createchar->m_zone==234)
					  {
						  //BASTOK
						
						 Query = "UPDATE chars \
                            SET home_zone = '234', home_rot = '213', pos_rot = '213', home_x = '-45', pos_x = '-45', home_y = '-0', pos_y = '-0', home_z = '26' ,pos_z = '26' ,pos_prevzone = '234',pos_zone = '0',first_login ='0',returning ='1',inevent='1',eventid='1' \
							WHERE charid = %u;";
                       Sql_Query(SqlHandle, Query,charid);
					// return;
					  }
					 // return;
					  
					  }
					  if(createchar->m_nation==2)
					  {//2
					  ShowNotice(CL_RED"TRACER: WINDY %u\n" CL_RESET,createchar->m_nation);
					  ShowNotice(CL_RED"TRACER: WINDY GETZONE %u\n" CL_RESET,createchar->m_zone);
					 if(createchar->m_zone==240)
					  {//1
						  //WINDY
						  
						Query = "UPDATE chars \
                            SET home_zone = '240', home_rot = '48', pos_rot = '48', home_x = '-120', pos_x = '-120', home_y = '-6', pos_y = '-6', home_z = '175'  , pos_z = '175'  ,pos_prevzone = '240',pos_zone = '0',first_login ='0',returning ='1',inevent='1',eventid='305'\
							WHERE charid = %u;";
                        Sql_Query(SqlHandle, Query, charid);
						//return;
					  }//1
					 // return;
					  }

	Query = "INSERT INTO char_look(charid,face,race,size) VALUES(%u,%u,%u,%u)ON DUPLICATE KEY UPDATE charid = charid;";

	if( Sql_Query(SqlHandle,Query,charid,createchar->m_look.face,createchar->m_look.race,createchar->m_look.size) == SQL_ERROR )
	{
		ShowDebug("ERROR 2 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
		return -1;
	}

	Query = "INSERT INTO char_stats(charid,mjob) VALUES(%u,%u) ON DUPLICATE KEY UPDATE charid = charid;";
	
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
	{
		ShowDebug("ERROR 3 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
		return -1;
	}



	
	// people reported char creation errors, here is a fix.

	Query = "INSERT INTO char_equip(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{
			ShowDebug("ERROR 4 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	Query = "INSERT INTO char_exp(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{
			ShowDebug("ERROR 5 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	Query = "INSERT INTO char_jobs(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{
			ShowDebug("ERROR 6 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	Query = "INSERT INTO char_points(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{
			ShowDebug("ERROR 7 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	Query = "INSERT INTO char_profile(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{ShowDebug("ERROR 8 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	Query = "INSERT INTO char_storage(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR )
		{
			ShowDebug("ERROR 9 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}


	Query = "INSERT INTO char_inventory(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;";
	if( Sql_Query(SqlHandle, Query, charid, createchar->m_mjob) == SQL_ERROR ) 
		{
			ShowDebug("ERROR 10 PRINT CHARACTERS NAME %s \n" CL_RESET,createchar);
			return -1;
	}

	ShowDebug("WE ARE A NEW CHARACTER SO LETS INSERT \n" CL_RESET);
				 }
	




	return 0;
}