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


#include <string.h>




#include "chat_message_string.h"

#include "../entities/charentity.h"


CChatMessageStringPacket::CChatMessageStringPacket(CCharEntity* PChar, CHAT_MESSAGE_STRING_TYPE MessageType, char *string) 
{

  
  

	this->type = 0x17;
	this->size = 32 + strlen(string) + strlen(string)%2;



	
	WBUFB(data,(0x04)-4) = MessageType;
    //WBUFB(data,(0x06)-4) = PChar->getZone();

	//memcpy(data+(0x08)-4, PChar->GetName(), PChar->name.size());
	//const char get = "%s"; 
	memcpy(data+(0x18)-4,("%s",string) , strlen(("%s",string)));
	
		
}