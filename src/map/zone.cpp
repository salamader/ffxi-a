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
  GNU General Public License for more details.F
  F
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

// TODO:
// нужно разделить класс czone на базовый и наследников. уже нарисовались: Standard, Rezident, Instance и Dinamis
// у каждой из указанных зон особое поведение

#include "../common/showmsg.h"
#include "../common/timer.h"
#include "../common/utils.h"

#include <string.h>

#include "utils/battleutils.h"
#include "utils/charutils.h"
#include "enmity_container.h"
#include "utils/itemutils.h"
#include "map.h"
#include "utils/mobutils.h"
#include "utils/zoneutils.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"
#include "utils/petutils.h"
#include "spell.h"
#include "treasure_pool.h"
#include "vana_time.h"
#include "zone.h"
#include "ai/ai_mob_dummy.h"

#include "lua/luautils.h"

#include "packets/action.h"
#include "packets/char.h"
#include "packets/char_update.h"
#include "packets/entity_update.h"
#include "packets/fade_out.h"
#include "packets/inventory_assign.h"
#include "packets/inventory_finish.h"
#include "packets/inventory_item.h"
#include "packets/lock_on.h"
#include "packets/message_basic.h"
#include "packets/server_ip.h"
#include "packets/wide_scan.h"


/************************************************************************
*																		*
*  Cервер для обработки активности сущностей (по серверу на зону) без	*
*  активных областей													*
*																		*
************************************************************************/

int32 zone_server(uint32 tick, CTaskMgr::CTask* PTask)
{
	((CZone*)PTask->m_data)->ZoneServer(tick);
	return 0;
}

/************************************************************************
*																		*
*  Cервер для обработки активности сущностей (по серверу на зону) c		*
*  активными областями													*
*																		*
************************************************************************/

int32 zone_server_region(uint32 tick, CTaskMgr::CTask* PTask)
{
	CZone* PZone = (CZone*)PTask->m_data;

	if ((tick - PZone->m_RegionCheckTime) < 2000)
	{
		PZone->ZoneServer(tick);
	} else {
		PZone->ZoneServerRegion(tick);
		PZone->m_RegionCheckTime = tick;
	}
	return 0;
}

/************************************************************************
*																		*
*  Класс CZone															*
*																		*
************************************************************************/

CZone::CZone(ZONEID ZoneID, REGIONTYPE RegionID, CONTINENTTYPE ContinentID)
{
  ZoneTimer = NULL;

  m_zoneID = ZoneID;
  m_zoneType = ZONETYPE_NONE;
  m_regionID = RegionID;
  m_continentID = ContinentID;
  m_Transport = 0;
  m_TreasurePool = 0;
  m_RegionCheckTime = 0;
  m_InstanceHandler = NULL;
  m_Weather = WEATHER_NONE;
  m_WeatherChangeTime = 0;
  m_IsWeatherStatic = 0;
  m_useNavMesh = false;
  m_navMesh = NULL;

  // settings should load first
  LoadZoneSettings();

  LoadZoneLines();
  LoadZoneWeather();
  LoadNavMesh();
}

/************************************************************************
*                                                                       *
*  Функции доступа к полям класса                                       *
*                                                                       *
************************************************************************/

ZONEID CZone::GetID()
{
	return m_zoneID;
}

ZONETYPE CZone::GetType()
{
  return m_zoneType;
}

REGIONTYPE CZone::GetRegionID()
{
    return m_regionID;
}

CONTINENTTYPE CZone::GetContinentID()
{
    return m_continentID;
}


uint32 CZone::GetLANIP()
{
	in_addr inaddr;
     inaddr.S_un.S_addr = inet_addr(map_config.NETWORK_Servers_Address);
     if( inaddr.S_un.S_addr == INADDR_NONE)
       {
       hostent* phostent = gethostbyname(map_config.NETWORK_Servers_Address);
      
       inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
       }
	return m_zoneLANIP =inaddr.S_un.S_addr ;
}

uint32 CZone::GetWANIP()
{
	in_addr inaddr;
     inaddr.S_un.S_addr = inet_addr(map_config.DNS_Servers_Address);
     if( inaddr.S_un.S_addr == INADDR_NONE)
       {
       hostent* phostent = gethostbyname(map_config.DNS_Servers_Address);
      
       inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
       }
	return m_zoneWANIP =inaddr.S_un.S_addr;
}

uint16 CZone::GetPort()
{
	return m_zonePort;
}

uint16 CZone::GetTax()
{
	return m_tax;
}

WEATHER CZone::GetWeather()
{
	return m_Weather;
}

uint32 CZone::GetWeatherChangeTime()
{
    return m_WeatherChangeTime;
}

const int8* CZone::GetName()
{
	return m_zoneName.c_str();
}


uint8 CZone::GetSoloBattleMusic()
{
	return m_zoneMusic.m_bSongS;
}

uint8 CZone::GetPartyBattleMusic()
{
	return m_zoneMusic.m_bSongM;
}

uint8 CZone::GetBackgroundMusic()
{
	return m_zoneMusic.m_song;
}

bool CZone::CanUseMisc(uint16 misc)
{
	return (m_miscMask & misc) == misc;
}

bool CZone::IsWeatherStatic()
{
    return m_IsWeatherStatic;
}

zoneLine_t* CZone::GetZoneLine(uint32 zoneLineID)
{
	for(zoneLineList_t::const_iterator  i = m_zoneLineList.begin();
		i != m_zoneLineList.end();
		i++ )
	{
		if(	(*i)->m_zoneLineID == zoneLineID )
		{
			return (*i);
		}
	}
	return NULL;
}

void  CZone::HealAllMobs()
{
  for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
    {
      CMobEntity* PCurrentMob = (CMobEntity*)it->second;

      // keep resting until i'm full
      PCurrentMob->Rest(1);
    }
}

/************************************************************************
*																		*
*  Загружаем ZoneLines, необходимые для правильного перемещения	между	*
*  зонами.																*
*																		*
************************************************************************/

void CZone::LoadZoneLines()
{
	static const int8 fmtQuery[] = "SELECT zoneline, tozone, tox, toy, toz, rotation FROM zonelines WHERE fromzone = %u";

	int32 ret = Sql_Query(SqlHandle, fmtQuery, m_zoneID);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			zoneLine_t* zl = new zoneLine_t;

			zl->m_zoneLineID = (uint32)Sql_GetIntData(SqlHandle,0);
			zl->m_toZone  = (uint16)Sql_GetIntData(SqlHandle,1);
			zl->m_toPos.x = Sql_GetFloatData(SqlHandle,2);
			zl->m_toPos.y = Sql_GetFloatData(SqlHandle,3);
			zl->m_toPos.z = Sql_GetFloatData(SqlHandle,4);
			zl->m_toPos.rotation = (uint8)Sql_GetIntData(SqlHandle,5);

			m_zoneLineList.push_back(zl);
		}
	}
}
void CZone::LoadPlayerZoneLines(CCharEntity* PChar)
{
	static const int8 fmtQuery[] = "SELECT zoneline, tozone, tox, toy, toz, rotation FROM zonelines WHERE fromzone = %u";

	int32 ret = Sql_Query(SqlHandle, fmtQuery, m_zoneID);

	if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			zoneLine_t* zl = new zoneLine_t;

			zl->m_zoneLineID = (uint32)Sql_GetIntData(SqlHandle,0);
			zl->m_toZone  = (uint16)Sql_GetIntData(SqlHandle,1);
			zl->m_toPos.x = Sql_GetFloatData(SqlHandle,2);
			zl->m_toPos.y = Sql_GetFloatData(SqlHandle,3);
			zl->m_toPos.z = Sql_GetFloatData(SqlHandle,4);
			zl->m_toPos.rotation = (uint8)Sql_GetIntData(SqlHandle,5);

			m_zoneLineList.push_back(zl);
		}
	}
}

/************************************************************************
*                                                                       *
*  Загружаем параметры погоды                                           *
*                                                                       *
************************************************************************/

void CZone::LoadZoneWeather()
{
    static const int8* Query =
        "SELECT "
          "weather.none,"
          "weather.sunshine,"
          "weather.clouds,"
          "weather.fog,"
          "weather.hot_spell,"
          "weather.heat_wave,"
          "weather.rain,"
          "weather.squall,"
          "weather.dust_storm,"
          "weather.sand_storm,"
          "weather.wind,"
          "weather.gales,"
          "weather.snow,"
          "weather.blizzards,"
          "weather.thunder,"
          "weather.thunder_storms,"
          "weather.auroras,"
          "weather.stellar_glares,"
          "weather.gloom,"
          "weather.darkness "
        "FROM zone_weather as weather "
        "WHERE zoneid = %u "
        "LIMIT 1";

    if (Sql_Query(SqlHandle, Query, m_zoneID) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint16 Frequency = 0;

        for (uint8 weather = 0; weather < MAX_WEATHER_ID; ++weather)
        {
            m_WeatherFrequency[weather] = (uint8)Sql_GetIntData(SqlHandle,weather);

            if (m_WeatherFrequency[weather] == 100)
            {
                m_IsWeatherStatic = true;
                SetWeather((WEATHER)weather);
            }
            Frequency += m_WeatherFrequency[weather];
        }
        if (Frequency != 100)
        {
            //ShowWarning(CL_YELLOW"Total Weather Frequency is %u for zone %u\n" CL_RESET, Frequency, m_zoneID);
        }
    }
    else
    {
        memset(&m_WeatherFrequency, 0, sizeof(m_WeatherFrequency));
        ShowFatalError(CL_RED"CZone::LoadZoneWeather: Cannot load zone weather (%u)\n" CL_RESET, m_zoneID);
    }
}

/************************************************************************
*																		*
*  Загружаем настройки зоны из базы										*
*																		*
************************************************************************/
void CZone::LoadZoneSettings()
{
	//IT WILL AUTOMATICLY SET TO THE NETWORK IP THEN IT WILL SWITCH TO PLAYER COMMAND
	//OFF NETOWRK OR ON NETWORK EITHER WAY SHOULD WORK!
	 in_addr inaddr;
     inaddr.S_un.S_addr = inet_addr(map_config.NETWORK_Servers_Address);
     if( inaddr.S_un.S_addr == INADDR_NONE)
       {
       hostent* phostent = gethostbyname(map_config.NETWORK_Servers_Address);
       if( phostent == 0){return;}
       if( sizeof(inaddr) != phostent->h_length){return;}
       inaddr.S_un.S_addr = *((unsigned long*) phostent->h_addr);
       }
	 static const int8* Query =
        "SELECT "
          "zone.name,"
          "zone.lanip,"
		  "zone.wanip,"
          "zone.zoneport,"
          "zone.music,"
          "zone.battlesolo,"
          "zone.battlemulti,"
          "zone.tax,"
          "zone.misc,"
          "zone.navmesh,"
          "zone.zonetype,"
          "bcnm.name "
        "FROM zone_settings AS zone "
        "LEFT JOIN bcnm_info AS bcnm "
        "USING (zoneid) "
        "WHERE zoneid = %u "
        "LIMIT 1";

    if (Sql_Query(SqlHandle, Query, m_zoneID) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        m_zoneName.insert(0, Sql_GetData(SqlHandle,0));

		m_zoneLANIP   = inaddr.S_un.S_addr;
		m_zoneWANIP   = inaddr.S_un.S_addr;
		m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,3);
		m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,4);		// background music
		m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,5);		// solo battle music
		m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,6);		// party battle music
		m_tax = (uint16)(Sql_GetFloatData(SqlHandle,7) * 100);			// tax for bazaar
		m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,8);
		m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,9);

		m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 10);

        if (Sql_GetData(SqlHandle,11) != NULL) // now we can not use bcnmid, because they start from scratch
        {
            m_InstanceHandler = new CInstanceHandler(m_zoneID);
	    }
        if (m_miscMask & MISC_TREASURE)
		{
            m_TreasurePool = new CTreasurePool(TREASUREPOOL_ZONE);
		}
    }
    else
    {
        ShowFatalError(CL_RED"CZone::LoadZoneSettings: Cannot load zone settings (%u)\n" CL_RESET, m_zoneID);
    }
	
	return;
    
}
void CZone::LoadPlayerZoneSettings(CCharEntity* PChar)
{
	
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
	 static const int8* Query =
        "SELECT "
          "zone.name,"
          "zone.lanip,"
		  "zone.wanip,"
          "zone.zoneport,"
          "zone.music,"
          "zone.battlesolo,"
          "zone.battlemulti,"
          "zone.tax,"
          "zone.misc,"
          "zone.navmesh,"
          "zone.zonetype,"
          "bcnm.name "
        "FROM zone_settings AS zone "
        "LEFT JOIN bcnm_info AS bcnm "
        "USING (zoneid) "
        "WHERE zoneid = %u "
        "LIMIT 1";

    if (Sql_Query(SqlHandle, Query, m_zoneID) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        m_zoneName.insert(0, Sql_GetData(SqlHandle,0));

		m_zoneLANIP   = inaddr.S_un.S_addr;
		m_zoneWANIP   = inaddr.S_un.S_addr;
		m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,3);
		m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,4);		// background music
		m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,5);		// solo battle music
		m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,6);		// party battle music
		m_tax = (uint16)(Sql_GetFloatData(SqlHandle,7) * 100);			// tax for bazaar
		m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,8);
		m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,9);

		m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 10);

        if (Sql_GetData(SqlHandle,11) != NULL) // now we can not use bcnmid, because they start from scratch
        {
            m_InstanceHandler = new CInstanceHandler(m_zoneID);
	    }
        if (m_miscMask & MISC_TREASURE)
		{
            m_TreasurePool = new CTreasurePool(TREASUREPOOL_ZONE);
		}
    }
    else
    {
        ShowFatalError(CL_RED"CZone::LoadZoneSettings: Cannot load zone settings (%u)\n" CL_RESET, m_zoneID);
    }
	 return;
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
	 static const int8* Query =
        "SELECT "
          "zone.name,"
          "zone.lanip,"
		  "zone.wanip,"
          "zone.zoneport,"
          "zone.music,"
          "zone.battlesolo,"
          "zone.battlemulti,"
          "zone.tax,"
          "zone.misc,"
          "zone.navmesh,"
          "zone.zonetype,"
          "bcnm.name "
        "FROM zone_settings AS zone "
        "LEFT JOIN bcnm_info AS bcnm "
        "USING (zoneid) "
        "WHERE zoneid = %u "
        "LIMIT 1";

    if (Sql_Query(SqlHandle, Query, m_zoneID) != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        m_zoneName.insert(0, Sql_GetData(SqlHandle,0));

		m_zoneLANIP   = inaddr.S_un.S_addr;
		m_zoneWANIP   = inaddr.S_un.S_addr;
		m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,3);
		m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,4);		// background music
		m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,5);		// solo battle music
		m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,6);		// party battle music
		m_tax = (uint16)(Sql_GetFloatData(SqlHandle,7) * 100);			// tax for bazaar
		m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,8);
		m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,9);

		m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 10);

        if (Sql_GetData(SqlHandle,11) != NULL) // now we can not use bcnmid, because they start from scratch
        {
            m_InstanceHandler = new CInstanceHandler(m_zoneID);
	    }
        if (m_miscMask & MISC_TREASURE)
		{
            m_TreasurePool = new CTreasurePool(TREASUREPOOL_ZONE);
		}
    }
    else
    {
        ShowFatalError(CL_RED"CZone::LoadZoneSettings: Cannot load zone settings (%u)\n" CL_RESET, m_zoneID);
    }
	 return;
    }
    
}

void CZone::LoadNavMesh()
{

  // disable / enable maps navmesh in zone_settings.sql
  if(!m_useNavMesh) return;

  if(m_navMesh == NULL){
    m_navMesh = new CNavMesh();
  }
  
  int8 file[255];
  memset(file,0,sizeof(file));
  
  
  snprintf(file, sizeof(file), "scripts/zones/%s/NavMesh.nav", GetName());

  if(m_navMesh->load(file))
  {
    // lets verify it can find proper paths
    if(!m_navMesh->test((int16)GetID()))
    {
      // test failed, don't use it
      m_useNavMesh = false;
    }

  } else {
    m_useNavMesh = false;
  }

}

/************************************************************************
*                                   *
*  Добавляем в зону MOB                         *
*                                   *
************************************************************************/

void CZone::InsertMOB(CBaseEntity* PMob)
{
  if ((PMob != NULL) && (PMob->objtype == TYPE_MOB))
  {
    PMob->loc.zone = this;

    FindPartyForMob(PMob);
		m_mobList[PMob->targid] = PMob;
	}
}

/************************************************************************
*																		*
*  Добавляем в зону NPC													*
*																		*
************************************************************************/

void CZone::InsertNPC(CBaseEntity* PNpc)
{
	if ((PNpc != NULL) && (PNpc->objtype == TYPE_NPC))
	{
        PNpc->loc.zone = this;

        if (PNpc->look.size == MODEL_SHIP)
        {
            m_Transport = PNpc;
            return;
        }
		m_npcList[PNpc->targid] = PNpc;
	}
}

void CZone::DeletePET(CBaseEntity* PPet)
{
	if(PPet != NULL)
    {
		m_petList.erase(PPet->targid);
	}
}

/************************************************************************
*                                                                       *
*  Добавляем в зону PET (свободные targid 0x700-0x7FF)                  *
*                                                                       *
************************************************************************/

void CZone::InsertPET(CBaseEntity* PPet)
{
	if ((PPet != NULL) && (PPet->objtype == TYPE_PET))
	{
        uint16 targid = 0x700;
		ShowError(CL_RED"CZone::InsertPET : TARGETID %u\n" CL_RESET, targid);
        for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	    {
            if (targid != it->first)
            {
                break;
            }
			ShowError(CL_RED"CZone::InsertPET : COUNT TARGETID %u\n" CL_RESET, targid++);
		    targid++;
	    }
        if (targid >= 0x800)
        {
            ShowError(CL_RED"CZone::InsertPET : targid is high (03hX)\n" CL_RESET, targid);
            return;
        }
        PPet->id = 0x1000000 + (m_zoneID << 12) + targid;
        PPet->targid = targid;
		ShowError(CL_RED"CZone::InsertPET : PET TARGETID %u\n" CL_RESET, PPet->targid);
        PPet->loc.zone = this;
		m_petList[PPet->targid] = PPet;
		if(!m_charList.empty())
		{
		for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
		{
			CCharEntity* PCurrentChar = (CCharEntity*)it->second;

			if(distance(PPet->loc.p, PCurrentChar->loc.p) < 50)
			{
				PCurrentChar->SpawnPETList[PPet->id] = PPet;
				PCurrentChar->pushPacket(new CEntityUpdatePacket(PPet, ENTITY_SPAWN));
			}
		}
		}
		return;
	}
	ShowError(CL_RED"CZone::InsertPET : entity is not pet\n" CL_RESET);
}

/************************************************************************
*																		*
*  Добавляем в зону активную область									*
*																		*
************************************************************************/

void CZone::InsertRegion(CRegion* Region)
{
	if (Region != NULL)
	{
		m_regionList.push_back(Region);
	}
}

/************************************************************************
*                                                                       *
*  Ищем группу для монстра. Для монстров, объединенных в группу         *
*  работает система взаимопомощи (link)                                 *
*                                                                       *
************************************************************************/

void CZone::FindPartyForMob(CBaseEntity* PEntity)
{
    DSP_DEBUG_BREAK_IF(PEntity == NULL);
    DSP_DEBUG_BREAK_IF(PEntity->objtype != TYPE_MOB);

    CMobEntity* PMob = (CMobEntity*)PEntity;

    // force all mobs in a burning circle to link
    bool forceLink = GetType() == ZONETYPE_BATTLEFIELD || GetType() == ZONETYPE_DYNAMIS || PMob->getMobMod(MOBMOD_SUPERLINK);

    if ((forceLink || PMob->m_Link) && PMob->PParty == NULL)
    {
        for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
        {
            CMobEntity* PCurrentMob = (CMobEntity*)it->second;

            if(!forceLink && !PCurrentMob->m_Link) continue;

            int16 sublink = PMob->getMobMod(MOBMOD_SUBLINK);

            if (forceLink ||
                PCurrentMob->m_Family == PMob->m_Family ||
                sublink && sublink == PCurrentMob->getMobMod(MOBMOD_SUBLINK))
            {

              if(PCurrentMob->PMaster == NULL || PCurrentMob->PMaster->objtype == TYPE_MOB)
              {
                PCurrentMob->PParty->AddMember(PMob);
                return;
              }
            }
        }
        PMob->PParty = new CParty(PMob);
    }
}

/************************************************************************
*                                                                       *
*  Транспотр отправляется, необходимо собрать пассажиров                *
*                                                                       *
************************************************************************/

void CZone::TransportDepart(CBaseEntity* PTransportNPC)
{
	if(!m_charList.empty())
	{
    for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	{
		CCharEntity* PCurrentChar = (CCharEntity*)it->second;

        if (PCurrentChar->loc.boundary == PTransportNPC->loc.boundary)
        {
            luautils::OnTransportEvent(PCurrentChar, PTransportNPC->loc.prevzone);
        }
    }
	}
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CZone::SetWeather(WEATHER weather)
{
    if(weather >= MAX_WEATHER_ID)
	{
		return;
	}

	if (m_Weather == weather)
		return;

    static uint8 Element[] =
    {
        0,  //WEATHER_NONE
	    0,  //WEATHER_SUNSHINE
	    0,  //WEATHER_CLOUDS
	    0,  //WEATHER_FOG
	    1,  //WEATHER_HOT_SPELL
	    1,  //WEATHER_HEAT_WAVE
	    6,  //WEATHER_RAIN
	    6,  //WEATHER_SQUALL
	    4,  //WEATHER_DUST_STORM
	    4,  //WEATHER_SAND_STORM
	    3,  //WEATHER_WIND
	    3,  //WEATHER_GALES
	    2,  //WEATHER_SNOW
	    2,  //WEATHER_BLIZZARDS
	    5,  //WEATHER_THUNDER
	    5,  //WEATHER_THUNDERSTORMS
	    7,  //WEATHER_AURORAS
	    7,  //WEATHER_STELLAR_GLARE
	    8,  //WEATHER_GLOOM
	    8,  //WEATHER_DARKNESS
    };

	for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
	{
		CMobEntity* PCurrentMob = (CMobEntity*)it->second;
    PCurrentMob->Check_Engagment->WeatherChange(weather, Element[weather]);
	}

    m_Weather = weather;
    m_WeatherChangeTime = CVanaTime::getInstance()->getVanaTime();

    PushPacket(NULL, CHAR_INZONE, new CWeatherPacket(m_WeatherChangeTime, m_Weather));
}
void CZone::SetZoneWeather(WEATHER weather,CCharEntity* PChar)
{
    if(weather >= MAX_WEATHER_ID)
	{
		return;
	}

	if (m_Weather == weather)
		return;

    static uint8 Element[] =
    {
        WEATHER_NONE,
	    WEATHER_SUNSHINE,
	    WEATHER_CLOUDS,
	    WEATHER_FOG,
	    WEATHER_HOT_SPELL,
	    WEATHER_HEAT_WAVE,
	    WEATHER_RAIN,
	    WEATHER_SQUALL,
	    WEATHER_DUST_STORM,
	    WEATHER_SAND_STORM,
	    WEATHER_WIND,
	    WEATHER_GALES,
	    WEATHER_SNOW,
	    WEATHER_BLIZZARDS,
	    WEATHER_THUNDER,
	    WEATHER_THUNDERSTORMS,
	    WEATHER_AURORAS,
	    WEATHER_STELLAR_GLARE,
	    WEATHER_GLOOM,
	    WEATHER_DARKNESS,
    };

	for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
	{
		CMobEntity* PCurrentMob = (CMobEntity*)it->second;
    PCurrentMob->Check_Engagment->WeatherChange(weather, Element[weather]);
	}

    m_Weather = weather;
    m_WeatherChangeTime = CVanaTime::getInstance()->getVanaTime();

    PushPacket(PChar, CHAR_INZONE, new CWeatherPacket(m_WeatherChangeTime, m_Weather));
}

/************************************************************************
*																		*
*  Удаляем персонажа из зоны. Если запущен ZoneServer и персонажей		*
*  в зоне больше не осталось, то останавливаем ZoneServer				*
*																		*
************************************************************************/

void CZone::DecreaseZoneCounter(CCharEntity* PChar)
{
	//ShowMessage(CL_YELLOW"I AM STILL CLEANING MAP AND DECREASING ZONE\n"CL_RESET);
    DSP_DEBUG_BREAK_IF(PChar == NULL);
    if(PChar->loc.zone != this)
	{
		
    ShowDebug("THE ZONE %u is not this %u %s .\n",PChar->loc.zone, this,PChar->GetName());
	
	
	return;
	//PChar->loc.zone = this;
	}
	PChar->is_zoning = 1;
	PChar->status = STATUS_DISAPPEAR;

	
			
	
	//remove pets
	if(PChar->PPet != NULL)
    {
		charutils::BuildingCharPetAbilityTable(PChar,(CPetEntity*)PChar->PPet,0);//blank the pet commands
		if(PChar->PPet->isCharmed) {
			petutils::DespawnPet(PChar);
		}
		else {
			PChar->PPet->status = STATUS_DISAPPEAR;
			if( ((CPetEntity*)(PChar->PPet))->getPetType() == PETTYPE_AVATAR )
				PChar->setModifier(MOD_AVATAR_PERPETUATION, 0);
		}
		// It may have been nulled by DespawnPet
		if(PChar->PPet != NULL) {
			PChar->PPet->Check_Engagment->SetCurrentAction(ACTION_NONE);
			DeletePET(PChar->PPet);//remove the TID for this pet
			if(!m_charList.empty())
		    {
			for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
			{
				//inform other players of the pets removal
				CCharEntity* PCurrentChar = (CCharEntity*)it->second;
				SpawnIDList_t::iterator PET = PCurrentChar->SpawnPETList.find(PChar->PPet->id);

				if( PET != PCurrentChar->SpawnPETList.end() )
				{
					PCurrentChar->SpawnPETList.erase(PET);
					PCurrentChar->pushPacket(new CEntityUpdatePacket(PChar->PPet, ENTITY_DESPAWN));
				}
			}
			}
			PChar->PPet = NULL;
		}
	}

	//remove bcnm status
	if(m_InstanceHandler != NULL && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
    {
		if(m_InstanceHandler->disconnectFromBcnm(PChar)){
			ShowDebug("Removed %s from the BCNM they were in as they have left the zone.\n",PChar->GetName());
		}

		if(PChar->loc.destination==0){ //this player is disconnecting/logged out, so move them to the entrance
			//move depending on zone
			int pos[4] = {0,0,0,0};
			instanceutils::getStartPosition(m_zoneID,pos);
			if(pos!=NULL){
				PChar->loc.p.x = pos[0];
				PChar->loc.p.y = pos[1];
				PChar->loc.p.z = pos[2];
				PChar->loc.p.rotation = pos[3];
				//charutils::SaveCharPosition(PChar);
			}
			else{
				ShowWarning("%s has disconnected from the BCNM but cannot move them to the lobby as the lobby position is unknown!\n",PChar->GetName());
			}
		}
	}
	else if(m_InstanceHandler != NULL && PChar->StatusEffectContainer->HasStatusEffect(EFFECT_DYNAMIS, 0))
    {
		if(m_InstanceHandler->disconnectFromDynamis(PChar)){
			ShowDebug("Removed %s from the BCNM they were in as they have left the zone.\n",PChar->GetName());
		}

		if(PChar->loc.destination==0){ //this player is disconnecting/logged out, so move them to the entrance
			//move depending on zone
			int pos[4] = {0,0,0,0};
			instanceutils::getStartPosition(m_zoneID,pos);
			if(pos!=NULL){
				PChar->loc.p.x = pos[0];
				PChar->loc.p.y = pos[1];
				PChar->loc.p.z = pos[2];
				PChar->loc.p.rotation = pos[3];
				//charutils::SaveCharPosition(PChar);
			}
			else{
				ShowWarning("%s has disconnected from the BCNM but cannot move them to the lobby as the lobby position is unknown!\n",PChar->GetName());
			}
		}
	}
	
	for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
	{
		CMobEntity* PCurrentMob = (CMobEntity*)it->second;
		PCurrentMob->PEnmityContainer->Clear(PChar->id);
		if(PCurrentMob->m_OwnerID.id == PChar->id){
			PCurrentMob->m_OwnerID.clean();
		}
	}
	

    // TODO: могут возникать проблемы с переходом между одной и той же зоной (zone == prevzone)

	m_charList.erase(PChar->targid);
	PChar->SpawnPCList.erase(PChar->id);
	
	

	if (ZoneTimer && m_charList.empty())
	{
		ZoneTimer->m_type = CTaskMgr::TASK_REMOVE;
		ZoneTimer = NULL;

    HealAllMobs();
	}
	else
	{
		if(!m_charList.empty())
		{
		for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	    {
	    CCharEntity* PCurrentChar = (CCharEntity*)it->second;
		PCurrentChar->loc.zone->PushPacket(PCurrentChar , CHAR_INRANGE, new CCharPacket(PChar,ENTITY_DESPAWN));
		}
		}
		else
		{
			PChar->loc.zone->PushPacket(PChar , CHAR_INRANGE, new CCharPacket(PChar,ENTITY_DESPAWN));
		}
		
	}
	if (PChar->m_LevelRestriction != 0)
	{
		PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_SYNC);
		PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_LEVEL_RESTRICTION);
	}
	if (PChar->PTreasurePool != NULL) // TODO: условие для устранения проблем с MobHouse, надо блин решить ее раз и навсегда
	{
		PChar->PTreasurePool->DelMember(PChar);
	}
    //for (regionList_t::const_iterator region = m_regionList.begin(); region != m_regionList.end(); ++region)
   // {
       // if ((*region)->GetRegionID() == PChar->m_InsideRegionID)
       // {
       //     luautils::OnRegionLeave(PChar, *region);
       //     break;
       // }
  //  }

    PChar->loc.zone = NULL;
    PChar->loc.prevzone = m_zoneID;
	
    PChar->SpawnPCList.clear();
	PChar->SpawnNPCList.clear();
	PChar->SpawnMOBList.clear();
	PChar->SpawnPETList.clear();
	if(PChar->shutdown_status ==1 )
	{
		//ShowMessage(CL_YELLOW"I AM NOW GOING TO FINISH MAP CLEAN UP\n"CL_RESET);
		
		const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE accid = %u";
                Sql_Query(SqlHandle,Query,PChar->accid);
		        Query = "UPDATE accounts SET  online = '0', sessions ='0', on_map ='0', map_time = '0', launcher = '0' WHERE id = %u";
                Sql_Query(SqlHandle,Query,PChar->accid);
		
	}
}

/************************************************************************
*																		*
*  Добавляем персонажа в зону. Если ZoneServer не запущен то запускам.	*
*  Обязательно проверяем количество персонажей в зоне.					*
*  Максимальное число персонажей в одной зоне - 768                     *
*																		*
************************************************************************/

void CZone::IncreaseZoneCounter(CCharEntity* PChar)
{
	DSP_DEBUG_BREAK_IF(PChar == NULL);
    if(PChar->loc.zone != NULL)
	{
		return;
	}
	DSP_DEBUG_BREAK_IF(PChar->PTreasurePool != NULL);

    // ищем свободный targid для входящего в зону персонажа
   // PChar->targid  = 1024;
	PChar->is_zoning = -1;
	uint32 targid = 0;
	uint32 charid = 0;
	                
	
	const char * Query = "SELECT charid, targid FROM accounts_sessions WHERE charid= '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,PChar->id);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						charid =  Sql_GetUIntData(SqlHandle,0);
				        targid =  Sql_GetUIntData(SqlHandle,1);
				  
				 
               PChar->targid = targid;
			   PChar->id = charid;
    
			ShowMessage(CL_BG_RED"PLAYERS NAME %s PLAYERS TARGET ID = %u \n" CL_RESET,PChar->GetName(), PChar->targid);
			ShowMessage(CL_BG_RED"PLAYER NAME %s PLAYERS ID = %u \n" CL_RESET,PChar->GetName(), PChar->id);
			
    if (PChar->targid >= 0x700)
    {
        ShowError(CL_RED"CZone::InsertChar : targid is high (03hX)\n" CL_RESET, PChar->targid);
        return;
    }
    PChar->loc.zone = this;
    PChar->loc.zoning = false;
  

    PChar->m_PVPFlag = CanUseMisc(MISC_PVP);

	
	m_charList[PChar->targid] = PChar;
	PChar->SpawnPCList[PChar->id] = PChar;
	

	if (!ZoneTimer && !m_charList.empty())
	{
		ZoneTimer = CTaskMgr::getInstance()->AddTask(m_zoneName,gettick(),this,CTaskMgr::TASK_INTERVAL,m_regionList.empty() ? zone_server : zone_server_region,500);
	}

	
	PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ON_ZONE);

  if (PChar->animation == ANIMATION_CHOCOBO && !CanUseMisc(MISC_CHOCOBO))
  {
      PChar->animation = ANIMATION_NONE;
      PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHOCOBO);
  }
  

	if (m_TreasurePool != NULL)
	{
		PChar->PTreasurePool = m_TreasurePool;
		PChar->PTreasurePool->AddMember(PChar);
	}
	else if (PChar->PParty != NULL)
	{
		PChar->PParty->ReloadTreasurePool(PChar);
	}
	else
	{
		PChar->PTreasurePool = new CTreasurePool(TREASUREPOOL_SOLO);
		PChar->PTreasurePool->AddMember(PChar);
	}
	PChar->PLatentEffectContainer->CheckLatentsZone();
	PChar->status = STATUS_NORMAL;
	}
	
}

/************************************************************************
*																		*
*  Проверка видимости монстров персонажем. Дистанцию лучше вынести в	*
*  глобальную переменную (настройки сервера)							*
*  Именно в этой функции будем проверять агрессию мостров, чтобы не		*
*  вычислять distance несколько раз (например в ZoneServer)				*
*																		*
************************************************************************/





/************************************************************************
*																		*
*  Проверка видимости питомцев персонажем. Для появления питомцев		*
*  используем UPDATE вместо SPAWN. SPAWN используется лишь при вызове	*
*																		*
************************************************************************/

void CZone::SpawnPETs(CCharEntity* PChar)
{
	if(m_petList.empty())
	{
		//ShowDebug(CL_RED" THE PET LIST EMPTY??\n"CL_RESET);
		return;
	}
	if(!m_petList.size() != NULL)
	{
		//ShowDebug(CL_RED"IS THE PLAYER LIST SIZE NULL??\n"CL_RESET);
		return;
	}
	if(PChar != NULL && PChar->loc.zone != NULL)
	{
	for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	{
		CPetEntity* PCurrentPet = (CPetEntity*)it->second;
		SpawnIDList_t::iterator PET = PChar->SpawnPETList.lower_bound(PCurrentPet->id);
		//CPetEntity* PPet = (CPetEntity*)PChar->loc.zone->GetEntity(PCurrentPet->targid, TYPE_PET);

		float CurrentDistance = distance(PChar->loc.p, PCurrentPet->loc.p);

		//if (CurrentDistance < 50 && PChar->loc.destination == PCurrentPet->loc.destination )
		//{
       // ShowDebug(CL_CYAN"UPDATING MOBS: TARGET ID %u \n" CL_RESET,PCurrentMob->targid);
		//PChar->pushPacket(new CEntityUpdatePacket(PPet,ENTITY_UPDATE));
		//}

		if ((PCurrentPet->status == STATUS_NORMAL || PCurrentPet->status == STATUS_UPDATE) &&
			distance(PChar->loc.p, PCurrentPet->loc.p) < 50)
		{
			if( PET == PChar->SpawnPETList.end() ||
				PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first))
			{
				PChar->SpawnPETList.insert(PET, SpawnIDList_t::value_type(PCurrentPet->id, PCurrentPet));
				PChar->pushPacket(new CEntityUpdatePacket(PCurrentPet,ENTITY_UPDATE));
			}
		}
		else
		{
			if( PET != PChar->SpawnPETList.end() &&
			  !(PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first)))
			{
				//PChar->SpawnPETList.erase(PET);
				PChar->pushPacket(new CEntityUpdatePacket(PCurrentPet,ENTITY_DESPAWN));
			}
		}
	}
	}
	else
	{
     ShowDebug(CL_CYAN"SPAWNING PETS: WITH NO PLAYER \n" CL_RESET);
	}
}

/************************************************************************
*																		*
*  Проверка видимости NPCs персонажем.									*
*																		*
************************************************************************/

void CZone::SpawnNPCs(CCharEntity* PChar)
{
	
	if(PChar != NULL && PChar->loc.zone != NULL)
	{
	for (EntityList_t::const_iterator it = m_npcList.begin() ; it != m_npcList.end() ; ++it)
	{
		CNpcEntity* PCurrentNpc = (CNpcEntity*)it->second;
		SpawnIDList_t::iterator NPC = PChar->SpawnNPCList.lower_bound(PCurrentNpc->id);

		if (PCurrentNpc->status == STATUS_NORMAL)
		{
			if(PChar->loc.destination == PCurrentNpc->loc.destination)
			{
				if( NPC == PChar->SpawnNPCList.end() || PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first))
				{
					ShowDebug("SPAWNING NPC NOW\n");
					PChar->SpawnNPCList.insert(NPC, SpawnIDList_t::value_type(PCurrentNpc->id, PCurrentNpc));
					PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_SPAWN));
				}
			}
			else
			{
				//if( NPC != PChar->SpawnNPCList.end() &&
				//  !(PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first)))
				//{
					//PChar->SpawnNPCList.erase(NPC);
					//PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_DESPAWN));
				//}
			}
		}
	}
	}
	else
	{
     ShowDebug(CL_CYAN"SPAWNING NPCS: WITH NO PLAYER \n" CL_RESET);
	}
}



/************************************************************************
*																		*
*  Отображаем Moogle в MogHouse											*
*																		*
************************************************************************/

int32 CZone::SpawnMoogle(CCharEntity* PChar)
{
	
	for (EntityList_t::const_iterator it = m_npcList.begin() ; it != m_npcList.end() ; ++it)
	{
		CNpcEntity* PCurrentNpc = (CNpcEntity*)it->second;

		if( PCurrentNpc->loc.p.z == 1.5 &&
			PCurrentNpc->look.face == 0x52)
		{
			PCurrentNpc->status = STATUS_NORMAL;
			PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_SPAWN));
			PCurrentNpc->status = STATUS_DISAPPEAR;
			return false;
		}
	}
	return false;
}

/************************************************************************
*                                                                       *
*  Отображаем транспотр в зоне (не хранится в основном списке)          *
*                                                                       *
************************************************************************/

void CZone::SpawnTransport(CCharEntity* PChar)
{
	if(PChar != NULL && PChar->loc.zone != NULL)
	{
	if (m_Transport != NULL)
    {
		PChar->pushPacket(new CEntityUpdatePacket(m_Transport, ENTITY_SPAWN));
	    return;
    }
	}
	else
	{
     ShowDebug(CL_CYAN"SPAWNING TRANSPORT: WITH NO PLAYER \n" CL_RESET);
	}
}

/************************************************************************
*																		*
*  Получаем указатель на любую сущность в зоне по ее targid				*
*																		*
************************************************************************/

CBaseEntity* CZone::GetEntity(uint16 targid, uint8 filter)
{
	CBaseEntity* PEntity = NULL;

	if (targid < 0x400)
	{
		if (filter & TYPE_MOB)
		{
			EntityList_t::const_iterator it = m_mobList.find(targid);
			if (it != m_mobList.end())
			{
				PEntity = it->second;
			}
		}
		if (filter & TYPE_NPC)
		{
			EntityList_t::const_iterator it = m_npcList.find(targid);
			if (it != m_npcList.end())
			{
				PEntity = it->second;
			}
		}
        if (filter & TYPE_SHIP)
        {
            if (m_Transport != NULL && m_Transport->targid == targid)
            {
                PEntity = m_Transport;
            }
        }
	}
	else if (targid < 0x700)
	{
		if (filter & TYPE_PC)
		{
			EntityList_t::const_iterator it = m_charList.find(targid);
			if (it != m_charList.end())
			{
				PEntity = it->second;
			}
		}
	}
	else if (targid < 0x800)
	{
		if (filter & TYPE_PET)
		{
			EntityList_t::const_iterator it = m_petList.find(targid);
			if (it != m_petList.end())
			{
				PEntity = it->second;
			}
		}
	}
	return PEntity;
}

/************************************************************************
*																		*
*  Oбработка реакции мира на смену времени суток						*
*																		*
************************************************************************/

void CZone::TOTDZoneChange(TIMETYPE TOTD,CCharEntity* PChar,CMobEntity* PMob)
{
	SCRIPTTYPE ScriptType = SCRIPT_NONE;

	switch (TOTD)
	{
        case TIME_MIDNIGHT:
        {

        }
        break;
        case TIME_FOG:
        {
            

				if (PMob->m_SpawnType == SPAWNTYPE_FOG)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
                    PMob->Check_Engagment->SetCurrentAction(ACTION_SPAWN);
				}
			
        }
        break;
		case TIME_NEWDAY:
		{
			

                if (PMob->m_SpawnType == SPAWNTYPE_ATNIGHT)
                {
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
                }
			
		}
		break;
		case TIME_DAWN:
		{
			ScriptType = SCRIPT_TIME_DAWN;

			

				if (PMob->m_SpawnType == SPAWNTYPE_ATEVENING)
				{
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
				}
			
		}
		break;
		case TIME_DAY:
		{
			ScriptType = SCRIPT_TIME_DAY;

            

                if (PMob->m_SpawnType ==  SPAWNTYPE_FOG)
                {
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
                }
		
		}
		break;
		case TIME_DUSK:
		{
			ScriptType = SCRIPT_TIME_DUSK;
		}
		break;
		case TIME_EVENING:
		{
			ScriptType = SCRIPT_TIME_EVENING;

			

				if (PMob->m_SpawnType == SPAWNTYPE_ATEVENING)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
					PMob->Check_Engagment->SetCurrentAction(ACTION_SPAWN);
				}
			
		}
		break;
		case TIME_NIGHT:
		{
			

				if (PMob->m_SpawnType == SPAWNTYPE_ATNIGHT)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
					PMob->Check_Engagment->SetCurrentAction(ACTION_SPAWN);
				}
			
		}
		break;
    }
	
    luautils::OnTOTDChange(m_zoneID, TOTD);
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CCharEntity* CZone::GetCharByName(int8* name)
{
	if(!m_charList.empty())
    {
	    for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	    {
		    CCharEntity* PCurrentChar = (CCharEntity*)it->second;
		    if(strcmp(PCurrentChar->GetName(),name)==0)
            {
			    return PCurrentChar;
		    }
	    }
    }
	return NULL;
}

/************************************************************************
*																		*
*  Отправляем глобальные пакеты											*
*																		*
************************************************************************/

void CZone::PushPacket(CBaseEntity* PEntity, GLOBAL_MESSAGE_TYPE message_type, CBasicPacket* packet)
{
	if (m_charList.empty())
	{
		//ShowDebug(CL_CYAN"EMPTY PLAYER PACKETS %u \n" CL_RESET,packet);
		return;
	}
	if (!m_charList.size() != NULL)
	{
		//ShowDebug(CL_CYAN"SIZE PLAYER PACKETS %u \n" CL_RESET,packet);
		return;
	}
	
	
	if(PEntity != NULL)
	{
	if (!m_charList.empty())
	{

		for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
				{
					CCharEntity* PCurrentChar = (CCharEntity*)it->second;
					
					if(PCurrentChar !=NULL)
					{
						PCurrentChar->pushPacket(new CBasicPacket(*packet));
						
					}
		
		       }
	

		return;
	
	}
	}
	else
	{
      // ShowDebug(CL_CYAN"A PACKET WAS CALLED WITH NO PENTITY %u\n" CL_RESET,packet);
	   delete packet;
	   return;
	}
}

/************************************************************************
*																		*
*  Wide Scan															*
*																		*
************************************************************************/

void CZone::WideScan(CCharEntity* PChar, uint16 radius)
{
	PChar->pushPacket(new CWideScanPacket(WIDESCAN_BEGIN));
	for (EntityList_t::const_iterator it = m_npcList.begin() ; it != m_npcList.end() ; ++it)
	{
        CNpcEntity* PNpc = (CNpcEntity*)it->second;
        if(PNpc->status == STATUS_NORMAL && PNpc->namevis == 0)
        {
		    if(distance(PChar->loc.p, PNpc->loc.p) < radius)
		    {
			    PChar->pushPacket(new CWideScanPacket(PChar, PNpc));
		    }
        }
	}
	for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
	{
        CMobEntity* PMob = (CMobEntity*)it->second;
        if(PMob->status != STATUS_DISAPPEAR)
        {
		    if(distance(PChar->loc.p, PMob->loc.p) < radius)
		    {
			    PChar->pushPacket(new CWideScanPacket(PChar, PMob));
		    }
        }
	}
	PChar->pushPacket(new CWideScanPacket(WIDESCAN_END));
}

/************************************************************************
*																		*
*  Cервер для обработки активности и статус-эффектов сущностей в зоне.	*
*  При любом раскладе последними должны обрабатываться персонажи		*
*																		*
************************************************************************/

void CZone::ZoneServer(uint32 tick)
{
	
	if(!m_charList.empty())
    {
	 for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
    {
        CCharEntity* PChar = (CCharEntity*)it->second;

        if (PChar->shutdown_status == 0)
        {
			if(PChar->is_zoning == 1)
			{
				//ShowDebug(CL_CYAN"DIFFERNT ZONING STRANGE HAPPENINGs\n" CL_RESET);
				return;
			}
			else
			{
				if(PChar->PRecastContainer != NULL)
				{
            PChar->PRecastContainer->Check(tick);
				}
				if(PChar->StatusEffectContainer != NULL)
				{
            PChar->StatusEffectContainer->CheckEffects(tick);
				}
				if(PChar->Check_Engagment != NULL)
				{
            PChar->Check_Engagment->CheckCurrentAction(tick);
				}
				if(PChar->PTreasurePool != NULL)
				{
            PChar->PTreasurePool->CheckItems(tick);
				}
				if(PChar->StatusEffectContainer != NULL)
				{
			PChar->StatusEffectContainer->CheckRegen(tick);
				}
				SpawnPETs(PChar);
				SpawnNPCs(PChar);
				SpawnTransport(PChar);
			}
			
        }
    }
	}
	for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end() ; ++it)
	{
		CMobEntity* PMob = (CMobEntity*)it->second;
		if(!m_charList.size() !=NULL)
        {


		//ShowMessage("THE CHAR LIST IS EMPTY MOB\n");
	    }
		else
		{
		
		PMob->StatusEffectContainer->CheckEffects(tick);
		PMob->Check_Engagment->CheckCurrentAction(tick);
		PMob->StatusEffectContainer->CheckRegen(tick);
		}
		
		
	}

  for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end() ; ++it)
  {
    CNpcEntity* PNpc = (CNpcEntity*)it->second;
	if(!m_charList.size() !=NULL)
        {


		//ShowMessage("THE CHAR LIST IS EMPTY NPC\n");
	    }
		else
		{
    if(PNpc->Check_Engagment != NULL)
    {
      PNpc->Check_Engagment->CheckCurrentAction(tick);
    }
	}
  }

	EntityList_t::const_iterator pit = m_petList.begin();
	while(pit != m_petList.end())
	{
		CPetEntity* PPet = (CPetEntity*)pit->second;
		if(!m_charList.size() !=NULL)
        {


		//ShowMessage("THE CHAR LIST IS EMPTY PET\n");
	    }
		else
		{
		PPet->StatusEffectContainer->CheckEffects(tick);
		PPet->Check_Engagment->CheckCurrentAction(tick);
		PPet->StatusEffectContainer->CheckRegen(tick);
		if(PPet->status==STATUS_DISAPPEAR){
			m_petList.erase(pit++);
		}
		else{
			++pit;
		}
		}
	}

	if(m_InstanceHandler != NULL)
    {
		m_InstanceHandler->handleInstances(tick);
	}

   
}



void CZone::ZoneServerRegion(uint32 tick)
{
	if(!m_charList.empty())
    {
    for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
    {
        CCharEntity* PChar = (CCharEntity*)it->second;

        if (PChar->shutdown_status == 0)
        {
			if(PChar->is_zoning == 1)
			{
				ShowDebug(CL_CYAN"DIFFERNT ZONING STRANGE HAPPENINGs\n" CL_RESET);
				return;
			}
			else
			{
				if(PChar->PRecastContainer != NULL)
				{
            PChar->PRecastContainer->Check(tick);
				}
				if( PChar->StatusEffectContainer != NULL)
				{
            PChar->StatusEffectContainer->CheckEffects(tick);
				}
				if( PChar->Check_Engagment != NULL)
				{
            PChar->Check_Engagment->CheckCurrentAction(tick);
				}
				if( PChar->PTreasurePool != NULL)
				{
            PChar->PTreasurePool->CheckItems(tick);
				}

            uint32 RegionID = 0;

            for (regionList_t::const_iterator region = m_regionList.begin(); region != m_regionList.end(); ++region)
            {
                if ((*region)->isPointInside(PChar->loc.p))
                {
                    RegionID = (*region)->GetRegionID();

                    if ((*region)->GetRegionID() != PChar->m_InsideRegionID)
                    {
						ShowDebug("REEGION ENTER %s %u\n",PChar->GetName(),PChar->m_InsideRegionID );
                      // luautils::OnRegionEnter(PChar, *region);
                    }
                    if (PChar->m_InsideRegionID == 0) break;
                }
                else if ((*region)->GetRegionID() == PChar->m_InsideRegionID)
                {
					ShowDebug("REEGION LEAVE %s %u\n",PChar->GetName(),PChar->m_InsideRegionID );
                 // luautils::OnRegionLeave(PChar, *region);
                }
            }
            PChar->m_InsideRegionID = RegionID;
        }
	  }
	}
  }
	for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
	{
		CMobEntity* PMob = (CMobEntity*)it->second;
		if(!m_charList.size() !=NULL)
        {


		//ShowMessage("THE CHAR LIST IS EMPTY MOB\n");
	    }
		else
		{
		PMob->StatusEffectContainer->CheckEffects(tick);
		PMob->Check_Engagment->CheckCurrentAction(tick);
		}
	}

	for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	{
		CPetEntity* PPet = (CPetEntity*)it->second;
		if(!m_charList.size() !=NULL)
        {


		//ShowMessage("THE CHAR LIST IS EMPTY MOB\n");
	    }
		else
		{
		PPet->StatusEffectContainer->CheckEffects(tick);
		PPet->Check_Engagment->CheckCurrentAction(tick);
		}
	}
	
}

EntityList_t CZone::GetCharList()
{
	return m_charList;
}




