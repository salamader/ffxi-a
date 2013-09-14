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

#include "mob.h"

#include "../entities/mobentity.h"
#include "../utils/itemutils.h"


CMobPacket::CMobPacket(CMobEntity * PMob, ENTITYUPDATE type)
{
	this->type = 0x0E;
	this->size = 0x1C;
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(1)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(2)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(3)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(4)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(5)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(6)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(7)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(8)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(9)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(10)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(11)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(12)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(13)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(14)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(15)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(16)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(17)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(18)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(19)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(20)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(21)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(22)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(23)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(24)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(25)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(26)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(27)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(28)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(29)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(30)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(31)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(32)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(33)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(34)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(35)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(36)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(37)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(38)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(39)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(40)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(41)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(42)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(43)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(44)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(45)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(46)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(47)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(48)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(49)-4));
	ShowDebug("EXTRA MOB PACKET1 %u\n",WBUFB(data,(50)-4));
	ShowDebug("EXTRA SO I CAN KEEP DARKSTARS WORK \n");

		
	
}

// некоторые манипуляции с пакетом приводят к интересному результату (количество голов в какой-то игре)