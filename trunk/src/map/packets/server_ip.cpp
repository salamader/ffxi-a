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

	in_addr inaddr;
   inaddr.S_un.S_addr = inet_addr(map_config.NETWORK_Servers_Address);
   //ShowFatalError(CL_RED"CZone:GET HOST NAME2(%u)\n" CL_RESET, inaddr);
   
   if( inaddr.S_un.S_addr == INADDR_NONE)
   {
      hostent* phostent = gethostbyname(map_config.NETWORK_Servers_Address);
      //ShowFatalError(CL_RED"CZone:GET HOST NAME3(%u)\n" CL_RESET, phostent);
      if( phostent == 0)
      {
         //ShowFatalError(CL_RED"CZone:GET HOST NAME4(%u)\n" CL_RESET, phostent);
         return;
      }

      if( sizeof(inaddr) != phostent->h_length)
      {
         //ShowFatalError(CL_RED"CZone:GET HOST NAME5(%u)\n" CL_RESET, phostent);
         return; 
      }

      inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
      

      
   }
   

	WBUFB(data,(0x04)-4) = type;
	WBUFL(data,(0x08)-4) = inaddr.S_un.S_addr;
	WBUFW(data,(0x0C)-4) = 54230;
}
