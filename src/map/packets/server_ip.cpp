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

#include "../../common/socket.h"

#include "server_ip.h"
#include "../entities/charentity.h"
#include "../utils/zoneutils.h"

CServerIPPacket::CServerIPPacket(CCharEntity* PChar, uint8 type)
{
	this->type = 0x0B;
	this->size = 0x0E;
	/*Accounts_Table In Database Tells this to do this or that.
	If youa re hosting public for friends off the network the code will run the
	Public IP address for them.
	And for your self if you are local you would set your status to 0
	so the code runs private network. found in accounts table field name
	server_type = 0 is public allow all off network
	server_type = 1 is private allow all on network
	
	*/
	if(PChar->Is_Public_0_Or_Private_1 == 0)
	{
	 in_addr inaddr;
     inaddr.S_un.S_addr = inet_addr(map_config.DNS_Servers_Address);
     if( inaddr.S_un.S_addr == INADDR_NONE)
       {
       hostent* phostent = gethostbyname(map_config.DNS_Servers_Address);
       if( phostent == 0){return;}
       if( sizeof(inaddr) != phostent->h_length){return;}
       inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
       }
	 WBUFB(data,(0x04)-4) = type;
	 WBUFL(data,(0x08)-4) = inaddr.S_un.S_addr;
	 WBUFW(data,(0x0C)-4) = 54230;
    }
	if(PChar->Is_Public_0_Or_Private_1 == 1)
	{
	 in_addr inaddr;
     inaddr.S_un.S_addr = inet_addr(map_config.NETWORK_Servers_Address);
     if( inaddr.S_un.S_addr == INADDR_NONE)
       {
       hostent* phostent = gethostbyname(map_config.NETWORK_Servers_Address);
       if( phostent == 0){return;}
       if( sizeof(inaddr) != phostent->h_length){return;}
       inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
       }
	 WBUFB(data,(0x04)-4) = type;
	 WBUFL(data,(0x08)-4) = inaddr.S_un.S_addr;
	 WBUFW(data,(0x0C)-4) = 54230;
    }
   

	
	
}
