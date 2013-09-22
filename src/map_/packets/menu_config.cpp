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

#include "menu_config.h"

#include "../entities/charentity.h"


CMenuConfigPacket::CMenuConfigPacket(CCharEntity* PChar) 
{
    this->type = 0xB4;
    this->size = 0x0C;
	ShowDebug("DATA0 %u\n",WBUFB(data,(0)-4));
	ShowDebug("DATA1 %u\n",WBUFB(data,(1)-4));
	ShowDebug("DATA2 %u\n",WBUFB(data,(2)-4));
	ShowDebug("DATA3 %u\n",WBUFB(data,(3)-4));
	ShowDebug("DATA4 %u\n",WBUFB(data,(4)-4));
	ShowDebug("DATA5 %u\n",WBUFB(data,(5)-4));
	ShowDebug("DATA6 %u\n",WBUFB(data,(6)-4));
	ShowDebug("DATA7 %u\n",WBUFB(data,(7)-4));
	ShowDebug("DATA8 %u\n",WBUFB(data,(8)-4));
	ShowDebug("DATA9 %u\n",WBUFB(data,(9)-4));
	ShowDebug("DATA10 %u\n",WBUFB(data,(10)-4));
	ShowDebug("DATA11 %u\n",WBUFB(data,(11)-4));
	ShowDebug("DATA12 %u\n",WBUFB(data,(12)-4));
	ShowDebug("DATA13 %u\n",WBUFB(data,(13)-4));
	ShowDebug("DATA14 %u\n",WBUFB(data,(14)-4));
	ShowDebug("DATA15 %u\n",WBUFB(data,(15)-4));
	ShowDebug("DATA16 %u\n",WBUFB(data,(16)-4));
	ShowDebug("DATA17 %u\n",WBUFB(data,(17)-4));
	ShowDebug("DATA18 %u\n",WBUFB(data,(18)-4));
	ShowDebug("DATA19 %u\n",WBUFB(data,(19)-4));
	ShowDebug("DATA20 %u\n",WBUFB(data,(20)-4));
    WBUFB(data,(0x04)-4) = 0x18 + (PChar->nameflags.flags == FLAG_INVITE ? 1 : 0);
    WBUFB(data,(0x05)-4)|= PChar->m_hasAutoTarget ? 0 : 0x40;
    WBUFB(data,(0x05)-4)|= PChar->nameflags.flags == FLAG_AUTOGROUP ? 0x80 : 0;  
    WBUFB(data,(0x07)-4) = 0x04; 

    WBUFB(data,(0x12)-4) = 0x02;
    WBUFB(data,(0x14)-4) = 0x02;
}

// активные поля data[0x07-4]
//
// 0 - cancel new adventurer status
// 1 - enable mentor, cancel new
// 2 - cancel new
// 3 - disable, cancel new
// 4 - нет активных
// 5 - enable mentor status
// 6 - нет активных
// 7 - disable mentor status