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
#include "../common/malloc.h"
#include "../common/showmsg.h"
#include "../common/socket.h"
#include "login_session.h"

login_sd_list_t login_sd_list;

login_session_data_t *find_loginsd_byaccid(int32 accid)
{
	for(login_sd_list_t::iterator i = login_sd_list.begin(); i != login_sd_list.end(); ++i )
	{
		if( (*i)->accid == accid)
		{
			return (*i);
		}
	}
	return NULL;
}



void erase_loginsd_byaccid(uint32 accid)
{
	for(login_sd_list_t::iterator i = login_sd_list.begin(); 
		i != login_sd_list.end();
		++i )
	{
		if( (*i)->accid == accid)
		{
			login_sd_list.erase(i);
			return ;
		}
	}
	return;
}

