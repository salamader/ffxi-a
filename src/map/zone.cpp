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

uint32 CZone::GetIP()
{
	return m_zoneIP;
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
          "zone.zoneip,"
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

    m_zoneIP   = inaddr.S_un.S_addr;
    m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,2);
    m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,3);   // background music
    m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,4);   // solo battle music
    m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,5);   // party battle music
    m_tax = (uint16)(Sql_GetFloatData(SqlHandle,6) * 100);      // tax for bazaar
    m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,7);
    m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,8);

    m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 9);

        if (Sql_GetData(SqlHandle,10) != NULL) // сейчас нельзя использовать bcnmid, т.к. они начинаются с нуля
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
          "zone.zoneip,"
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

    m_zoneIP   = inaddr.S_un.S_addr;
    m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,2);
    m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,3);   // background music
    m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,4);   // solo battle music
    m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,5);   // party battle music
    m_tax = (uint16)(Sql_GetFloatData(SqlHandle,6) * 100);      // tax for bazaar
    m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,7);
    m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,8);

    m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 9);

        if (Sql_GetData(SqlHandle,10) != NULL) // сейчас нельзя использовать bcnmid, т.к. они начинаются с нуля
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
          "zone.zoneip,"
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

    m_zoneIP   = inaddr.S_un.S_addr;
    m_zonePort = (uint16)Sql_GetUIntData(SqlHandle,2);
    m_zoneMusic.m_song   = (uint8)Sql_GetUIntData(SqlHandle,3);   // background music
    m_zoneMusic.m_bSongS = (uint8)Sql_GetUIntData(SqlHandle,4);   // solo battle music
    m_zoneMusic.m_bSongM = (uint8)Sql_GetUIntData(SqlHandle,5);   // party battle music
    m_tax = (uint16)(Sql_GetFloatData(SqlHandle,6) * 100);      // tax for bazaar
    m_miscMask = (uint16)Sql_GetUIntData(SqlHandle,7);
    m_useNavMesh = (bool)Sql_GetIntData(SqlHandle,8);

    m_zoneType = (ZONETYPE)Sql_GetUIntData(SqlHandle, 9);

        if (Sql_GetData(SqlHandle,10) != NULL) // сейчас нельзя использовать bcnmid, т.к. они начинаются с нуля
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

        for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	    {
            if (targid != it->first)
            {
                break;
            }
		    targid++;
	    }
        if (targid >= 0x800)
        {
            ShowError(CL_RED"CZone::InsertPET : targid is high (03hX)\n" CL_RESET, targid);
            return;
        }
        PPet->id = 0x1000000 + (m_zoneID << 12) + targid;
        PPet->targid = targid;
        PPet->loc.zone = this;
		m_petList[PPet->targid] = PPet;

		for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
		{
			CCharEntity* PCurrentChar = (CCharEntity*)it->second;

			if(distance(PPet->loc.p, PCurrentChar->loc.p) < 50)
			{
				PCurrentChar->SpawnPETList[PPet->id] = PPet;
				PCurrentChar->pushPacket(new CEntityUpdatePacket(PPet, ENTITY_SPAWN));
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
    for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	{
		CCharEntity* PCurrentChar = (CCharEntity*)it->second;

        if (PCurrentChar->loc.boundary == PTransportNPC->loc.boundary)
        {
            luautils::OnTransportEvent(PCurrentChar, PTransportNPC->loc.prevzone);
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
    PCurrentMob->PBattleAI->WeatherChange(weather, Element[weather]);
	}

    m_Weather = weather;
    m_WeatherChangeTime = CVanaTime::getInstance()->getVanaTime();

    PushPacket(NULL, CHAR_INZONE, new CWeatherPacket(m_WeatherChangeTime, m_Weather));
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
			PChar->PPet->PBattleAI->SetCurrentAction(ACTION_NONE);
			DeletePET(PChar->PPet);//remove the TID for this pet

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
	//ShowMessage(CL_YELLOW"DECREASE THIS ZONE ID %u\n"CL_RESET,PChar->loc.destination);
	 
  /*string_t zonename = "noname";
	const char * Query = "SELECT name FROM zonesystem WHERE zone = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,PChar->loc.destination);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						
				   zonename =  Sql_GetData(SqlHandle,0);
				  // snprintf(file, sizeof(file), "scripts/zones/%s/NavMesh.nav", zonename.c_str());
				   ShowMessage(CL_YELLOW"CZone:: %s DecreaseZoneCounter <%u> %s OK \n" CL_RESET, zonename.c_str(), m_charList.size(),PChar->GetName());
				 }
				 else
				 {
					 //snprintf(File, sizeof(File), "scripts/zones/Residential_Area/Zone.lua");
					 return;
				 }*/
	

	if (ZoneTimer && m_charList.empty())
	{
		ZoneTimer->m_type = CTaskMgr::TASK_REMOVE;
		ZoneTimer = NULL;

    HealAllMobs();
	}
	else
	{
		PChar->loc.zone->PushPacket(PChar, CHAR_INRANGE, new CCharPacket(PChar,ENTITY_DESPAWN));
		//PChar->pushPacket(new CCharPacket(PChar,ENTITY_DESPAWN));
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
    for (regionList_t::const_iterator region = m_regionList.begin(); region != m_regionList.end(); ++region)
    {
        if ((*region)->GetRegionID() == PChar->m_InsideRegionID)
        {
            luautils::OnRegionLeave(PChar, *region);
            break;
        }
    }

    PChar->loc.zone = NULL;
    PChar->loc.prevzone = m_zoneID;
	
    PChar->SpawnPCList.clear();
	PChar->SpawnNPCList.clear();
	PChar->SpawnMOBList.clear();
	PChar->SpawnPETList.clear();
	if(PChar->shutdown_status ==1 )
	{
		//ShowMessage(CL_YELLOW"I AM NOW GOING TO FINISH MAP CLEAN UP\n"CL_RESET);
		
		const char *Query = "UPDATE chars SET  online = '0', shutdown = '1', zoning = '-1', returning = '0' WHERE charid = %u";
        Sql_Query(SqlHandle,Query,PChar->id);
		Query = "UPDATE accounts SET  online = '0' WHERE id = %u";
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
    PChar->targid  = 1024;
	PChar->is_zoning = -1;
	uint32 targid = 0;

	                
	
	const char * Query = "SELECT targid FROM accounts_sessions WHERE charid= '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,PChar->id);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						
				   targid =  Sql_GetUIntData(SqlHandle,0);
				  // ShowMessage("MAX TARGETID NEW COUNT %u \n" CL_RESET,targid);
				 
               PChar->targid = targid;

    for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	{
        if (PChar->targid != it->first)
        {
			PChar->targid++;
			//ShowError(CL_RED"%u TARGET ID IS %u\n" CL_RESET,PChar->id, PChar->targid);
			const int8* fmtQuery = "UPDATE accounts_sessions SET targid = %u WHERE charid = %u";
            Sql_Query(SqlHandle,fmtQuery,PChar->targid,PChar->id);
            break;
        }
        PChar->targid++;
		//ShowError(CL_RED"%u TARGET ID IS %u\n" CL_RESET,PChar->id, PChar->targid++);
		const int8* fmtQuery = "UPDATE accounts_sessions SET targid = %u WHERE charid = %u";
        Sql_Query(SqlHandle,fmtQuery,PChar->targid++,PChar->id);
    }
    if (PChar->targid >= 0x700)
    {
        ShowError(CL_RED"CZone::InsertChar : targid is high (03hX)\n" CL_RESET, PChar->targid);
        return;
    }
    PChar->loc.zone = this;
    PChar->loc.zoning = false;
   // PChar->loc.destination = 0;
   // PChar->m_InsideRegionID = 0;

    PChar->m_PVPFlag = CanUseMisc(MISC_PVP);

	m_charList[PChar->targid] = PChar;
	PChar->SpawnPCList[PChar->id] = PChar;
	/*ShowDebug("INCREASE THIS IS %u \n",PChar->loc.destination);
  string_t zonename = "noname";
	const char * Query = "SELECT name FROM zonesystem WHERE zone = '%u';";
	          int32 ret3 = Sql_Query(SqlHandle,Query,PChar->loc.destination);
			

	             if (ret3 != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	                {
						
				   zonename =  Sql_GetData(SqlHandle,0);
				  
				   ShowDebug(CL_CYAN"CZone:: %s IncreaseZoneCounter <%u> %s \n" CL_RESET, zonename.c_str(), m_charList.size(),PChar->GetName());
				 }
				 else
				 {
					 //snprintf(File, sizeof(File), "scripts/zones/Residential_Area/Zone.lua");
					 return;
				 }*/
	

	if (!ZoneTimer && !m_charList.empty())
	{
		ZoneTimer = CTaskMgr::getInstance()->AddTask(
			m_zoneName,
			gettick(),
			this,
			CTaskMgr::TASK_INTERVAL,
			m_regionList.empty() ? zone_server : zone_server_region,
			500);
	}

	//remove status effects that wear on zone
	PChar->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_ON_ZONE);

  if (PChar->animation == ANIMATION_CHOCOBO && !CanUseMisc(MISC_CHOCOBO))
  {
      PChar->animation = ANIMATION_NONE;
      PChar->StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHOCOBO);
  }
  //if (PChar->m_Costum != 0)
  //{
  //    PChar->m_Costum = 0;
   //   PChar->StatusEffectContainer->DelStatusEffect(EFFECT_COSTUME);
  //}

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

void CZone::SpawnMOBs(CCharEntity* PChar)
{
	if(PChar != NULL && PChar->loc.zone != NULL)
	{
	for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
	{
		CMobEntity* PCurrentMob = (CMobEntity*)it->second;
        SpawnIDList_t::iterator MOB = PChar->SpawnMOBList.lower_bound(PCurrentMob->id);

		float CurrentDistance = distance(PChar->loc.p, PCurrentMob->loc.p);

		if (PCurrentMob->status == STATUS_UPDATE &&
			CurrentDistance < 50)
		{
			if( MOB == PChar->SpawnMOBList.end() ||
				PChar->SpawnMOBList.key_comp()(PCurrentMob->id, MOB->first))
			{
				PChar->SpawnMOBList.insert(MOB, SpawnIDList_t::value_type(PCurrentMob->id, PCurrentMob));
				PChar->pushPacket(new CEntityUpdatePacket(PCurrentMob, ENTITY_SPAWN));
			}

			if (PChar->isDead() || PChar->nameflags.flags & FLAG_GM_SUPPORT ||PChar->nameflags.flags & FLAG_GM_SENIOR ||PChar->nameflags.flags & FLAG_GM_LEAD  ||PChar->nameflags.flags & FLAG_GM_PRODUCER|| PCurrentMob->PMaster != NULL)
				continue;

        // проверка ночного/дневного сна монстров уже учтена в проверке CurrentAction, т.к. во сне монстры не ходят ^^

        uint16 expGain = (uint16)charutils::GetRealExp(PChar->GetMLevel(),PCurrentMob->GetMLevel());

        CAIMobDummy* PAIMob = (CAIMobDummy*)PCurrentMob->PBattleAI;

        bool validAggro = expGain > 50 || PChar->animation == ANIMATION_HEALING || PCurrentMob->getMobMod(MOBMOD_ALWAYS_AGGRO);

        if(validAggro && PAIMob->CanAggroTarget(PChar))
        {
          PCurrentMob->PEnmityContainer->AddBaseEnmity(PChar);
        }

  		}
      else
      {
			if( MOB != PChar->SpawnMOBList.end() &&
			  !(PChar->SpawnMOBList.key_comp()(PCurrentMob->id, MOB->first)))
			{
				PChar->SpawnMOBList.erase(MOB);
				PChar->pushPacket(new CEntityUpdatePacket(PCurrentMob,ENTITY_DESPAWN));
			}
		}
	}
	}
	else
	{
     ShowDebug(CL_CYAN"SPAWNING MOBS: WITH NO PLAYER \n" CL_RESET);
	}
}

/************************************************************************
*																		*
*  Проверка видимости питомцев персонажем. Для появления питомцев		*
*  используем UPDATE вместо SPAWN. SPAWN используется лишь при вызове	*
*																		*
************************************************************************/

void CZone::SpawnPETs(CCharEntity* PChar)
{
	if(PChar != NULL && PChar->loc.zone != NULL)
	{
	for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	{
		CPetEntity* PCurrentPet = (CPetEntity*)it->second;
		SpawnIDList_t::iterator PET = PChar->SpawnPETList.lower_bound(PCurrentPet->id);

		if ((PCurrentPet->status == STATUS_NORMAL || PCurrentPet->status == STATUS_UPDATE) &&
			distance(PChar->loc.p, PCurrentPet->loc.p) < 50)
		{
			if( PET == PChar->SpawnPETList.end() ||
				PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first))
			{
				PChar->SpawnPETList.insert(PET, SpawnIDList_t::value_type(PCurrentPet->id, PCurrentPet));
				PChar->pushPacket(new CEntityUpdatePacket(PCurrentPet,ENTITY_UPDATE));
			}
		}else{
			if( PET != PChar->SpawnPETList.end() &&
			  !(PChar->SpawnPETList.key_comp()(PCurrentPet->id, PET->first)))
			{
				PChar->SpawnPETList.erase(PET);
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
			if(distance(PChar->loc.p, PCurrentNpc->loc.p) < 50)
			{
				if( NPC == PChar->SpawnNPCList.end() ||
					PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first))
				{
					PChar->SpawnNPCList.insert(NPC, SpawnIDList_t::value_type(PCurrentNpc->id, PCurrentNpc));
					PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_SPAWN));
				}
			}else{
				if( NPC != PChar->SpawnNPCList.end() &&
				  !(PChar->SpawnNPCList.key_comp()(PCurrentNpc->id, NPC->first)))
				{
					PChar->SpawnNPCList.erase(NPC);
					PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_DESPAWN));
				}
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
*  Проверка видимости персонажей. Смысл действий в том, что персонажи	*
*  сами себя обновляют и добавляются в списки других персонажей.        *
*  В оригинальной версии размер списка ограничен и изменяется в			*
*  пределах 25-50 видимых персонажей.									*
*																		*
************************************************************************/

void CZone::SpawnPCs(CCharEntity* PChar)
{
	for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
	{
	CCharEntity* PCurrentChar = (CCharEntity*)it->second;
		SpawnIDList_t::iterator PC = PChar->SpawnPCList.find(PCurrentChar->id);

		if (PChar != PCurrentChar)
		{
			//ShowDebug(CL_CYAN"SPAWNING PC 1 \n" CL_RESET);
			if(distance(PChar->loc.p, PCurrentChar->loc.p) < 50)
			{
				//ShowDebug(CL_CYAN"SPAWNING PC 2 \n" CL_RESET);
				if( PC == PChar->SpawnPCList.end() )
				{
					//ShowDebug(CL_CYAN"SPAWNING PC THISONE \n" CL_RESET);
					PChar->SpawnPCList[PCurrentChar->id] = PCurrentChar;
					PChar->pushPacket(new CCharPacket(PCurrentChar,ENTITY_SPAWN));

					PCurrentChar->SpawnPCList[PChar->id] = PChar;
					PCurrentChar->pushPacket(new CCharPacket(PChar,ENTITY_SPAWN));
				}else
				{
					//ShowDebug(CL_CYAN"SPAWNING PC THISONE 1 \n" CL_RESET);
					PCurrentChar->pushPacket(new CCharPacket(PChar,ENTITY_UPDATE));
				}
			} 
			else 
			{
				//ShowDebug(CL_CYAN"ELSE SPAWNING PC THISONE \n" CL_RESET);
				if( PC != PChar->SpawnPCList.end() )
				{
					//ShowDebug(CL_CYAN"ELSE SPAWNING PC THISONE ERACE \n" CL_RESET);
					PChar->SpawnPCList.erase(PC);
					PChar->pushPacket(new CCharPacket(PCurrentChar,ENTITY_DESPAWN));

					PCurrentChar->SpawnPCList.erase(PChar->id);
					PCurrentChar->pushPacket(new CCharPacket(PChar,ENTITY_DESPAWN));
				}
			}
		}
	}
}

/************************************************************************
*																		*
*  Отображаем Moogle в MogHouse											*
*																		*
************************************************************************/

int32 CZone::SpawnMoogle(CCharEntity* PChar)
{
	/*
	
	
	
	

	
	

	char buf[110];
	

	uint8 mjob = 0;
	uint8 sjob = 0;
	string_t mobname = "";
	uint32 Model_ID = 0;
	char CharName[15];
	const int8* Query =
        "SELECT mobid, name, respawn_time, spawn_type, dropid, hp_mod, mp_mod, min_level, max_level, \
			look, main_job, sub_job, skill_type, set_delay, behaviour, link, type, immunity, \
			ecosystem, size, speed, \
			str, dex,vit, agi, `itn`, mnd, chr, eva, def, \
			mod_slash, mod_pierce, mod_hth, mod_impact, \
			mod_fire, mod_ice, mod_wind, mod_earth, mod_thunder, mod_water, mod_light, mod_dark, element, \
			family, name_prefix, unk, animationsub, \
			(hp_scale / 100), (mp_scale / 100), spell_script, spell_list, att, acc,modelid \
			FROM mog_list \
			LEFT JOIN npc_models ON mog_list.look = npc_models.lookid \
			WHERE test = '3';";

	

    int32 ret = Sql_Query(SqlHandle, Query);

			 if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
	{
		while(Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
						//IF MOB IS IN DATABASE RUN THIS LINE
						
						CMobEntity* PMob = new CMobEntity;
						 PMob->name=Sql_GetData(SqlHandle,1);
						 PMob->name.insert(0, PMob->name.c_str());
					memcpy(PMob->charname,PMob->name.c_str(),sizeof(PMob->charname));	 
			memset(PMob->charname,0,sizeof(PMob->charname));
				
						memcpy(PMob->charname,PMob->name.c_str(),15);
						
						
			PMob->id = Sql_GetUIntData(SqlHandle,0);
			
			PMob->targid = 1;
			mobname=Sql_GetData(SqlHandle,1);
			ShowDebug("SHOW NAME %s\n",mobname.c_str());
			ShowDebug("SHOW MOG NAME %s\n",PMob->name);
			ShowDebug("SHOW SET MOG NAME %s\n",PMob->charname);
			memcpy(&PMob->name, PMob->name.c_str(),(PMob->name.size() > 15 ? 15 : PMob->name.size()));

			PMob->m_SpawnPoint.rotation = PChar->loc.p.rotation;
			PMob->m_SpawnPoint.x = PChar->loc.p.x;
			PMob->m_SpawnPoint.y = PChar->loc.p.y;
			PMob->m_SpawnPoint.z = PChar->loc.p.z;
			

			Model_ID = Sql_GetIntData(SqlHandle,9);
			
			

			PMob->m_RespawnTime = Sql_GetUIntData(SqlHandle,2) * 1000;
			PMob->m_SpawnType   = (SPAWNTYPE)Sql_GetUIntData(SqlHandle,3);
			PMob->m_DropID		= Sql_GetUIntData(SqlHandle,4);
			PMob->HPmodifier = (uint32)Sql_GetIntData(SqlHandle,5);
			PMob->MPmodifier = (uint32)Sql_GetIntData(SqlHandle,6);
			
			
			
			PMob->m_minLevel = (uint8)Sql_GetIntData(SqlHandle,7);
			PMob->m_maxLevel = (uint8)Sql_GetIntData(SqlHandle,8);
		
			
			PMob->SetMJob(Sql_GetIntData(SqlHandle,10));
			PMob->SetSJob(Sql_GetIntData(SqlHandle,11));

			
			

			PMob->m_Weapons[SLOT_MAIN]->setMaxHit(1);
			PMob->m_Weapons[SLOT_MAIN]->setSkillType(Sql_GetIntData(SqlHandle,12));
			PMob->m_Weapons[SLOT_MAIN]->setDelay((Sql_GetIntData(SqlHandle,13) * 1000)/60);
			PMob->m_Weapons[SLOT_MAIN]->setBaseDelay((Sql_GetIntData(SqlHandle,13) * 1000)/60);

			

			PMob->m_Behaviour  = (uint16)Sql_GetIntData(SqlHandle,14);
            PMob->m_Link       = (uint8)Sql_GetIntData(SqlHandle,15);
			PMob->m_Type       = (uint8)Sql_GetIntData(SqlHandle,16);
			PMob->m_Immunity   = (IMMUNITY)Sql_GetIntData(SqlHandle,17);
			PMob->m_EcoSystem  = (ECOSYSTEM)Sql_GetIntData(SqlHandle,18);
			PMob->m_ModelSize += (uint8)Sql_GetIntData(SqlHandle,19);

			

			PMob->speed    = (uint8)Sql_GetIntData(SqlHandle,20);
			PMob->speedsub = (uint8)Sql_GetIntData(SqlHandle,20);

			PMob->strRank = (uint8)Sql_GetIntData(SqlHandle,21);
            PMob->dexRank = (uint8)Sql_GetIntData(SqlHandle,22);
            PMob->vitRank = (uint8)Sql_GetIntData(SqlHandle,23);
            PMob->agiRank = (uint8)Sql_GetIntData(SqlHandle,24);
            PMob->intRank = (uint8)Sql_GetIntData(SqlHandle,25);
            PMob->mndRank = (uint8)Sql_GetIntData(SqlHandle,26);
            PMob->chrRank = (uint8)Sql_GetIntData(SqlHandle,27);
            PMob->evaRank = (uint8)Sql_GetIntData(SqlHandle,28);
            PMob->defRank = (uint8)Sql_GetIntData(SqlHandle,29);

			PMob->attRank = (uint8)Sql_GetIntData(SqlHandle,51);
            PMob->accRank = (uint8)Sql_GetIntData(SqlHandle,52);
            

			PMob->setModifier(MOD_SLASHRES, (uint16)(Sql_GetFloatData(SqlHandle,30) * 1000));
			PMob->setModifier(MOD_PIERCERES,(uint16)(Sql_GetFloatData(SqlHandle,31) * 1000));
			PMob->setModifier(MOD_HTHRES,   (uint16)(Sql_GetFloatData(SqlHandle,32) * 1000));
			PMob->setModifier(MOD_IMPACTRES,(uint16)(Sql_GetFloatData(SqlHandle,33) * 1000));

            PMob->setModifier(MOD_FIREDEF,    (int16)((Sql_GetFloatData(SqlHandle, 34) - 1) * -1000)); // These are stored as floating percentages
            PMob->setModifier(MOD_ICEDEF,     (int16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -1000)); // and need to be adjusted into modifier units.
            PMob->setModifier(MOD_WINDDEF,    (int16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -1000)); // Higher DEF = lower damage.
            PMob->setModifier(MOD_EARTHDEF,   (int16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -1000)); // Negatives signify increased damage.
            PMob->setModifier(MOD_THUNDERDEF, (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -1000)); // Positives signify reduced damage.
            PMob->setModifier(MOD_WATERDEF,   (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -1000)); // Ex: 125% damage would be 1.25, 50% damage would be 0.50
            PMob->setModifier(MOD_LIGHTDEF,   (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -1000)); // (1.25 - 1) * -1000 = -250 DEF
            PMob->setModifier(MOD_DARKDEF,    (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -1000)); // (0.50 - 1) * -1000 = 500 DEF

            PMob->setModifier(MOD_FIRERES,    (int16)((Sql_GetFloatData(SqlHandle, 34) - 1) * -100)); // These are stored as floating percentages
            PMob->setModifier(MOD_ICERES,     (int16)((Sql_GetFloatData(SqlHandle, 35) - 1) * -100)); // and need to be adjusted into modifier units.
            PMob->setModifier(MOD_WINDRES,    (int16)((Sql_GetFloatData(SqlHandle, 36) - 1) * -100)); // Higher RES = lower damage.
            PMob->setModifier(MOD_EARTHRES,   (int16)((Sql_GetFloatData(SqlHandle, 37) - 1) * -100)); // Negatives signify lower resist chance.
            PMob->setModifier(MOD_THUNDERRES, (int16)((Sql_GetFloatData(SqlHandle, 38) - 1) * -100)); // Positives signify increased resist chance.
            PMob->setModifier(MOD_WATERRES,   (int16)((Sql_GetFloatData(SqlHandle, 39) - 1) * -100));
            PMob->setModifier(MOD_LIGHTRES,   (int16)((Sql_GetFloatData(SqlHandle, 40) - 1) * -100));
            PMob->setModifier(MOD_DARKRES,    (int16)((Sql_GetFloatData(SqlHandle, 41) - 1) * -100));

			PMob->m_Element = (uint8)Sql_GetIntData(SqlHandle,42);
			PMob->m_Family = (uint16)Sql_GetIntData(SqlHandle,43);
			PMob->m_name_prefix = (uint8)Sql_GetIntData(SqlHandle,44);
			PMob->m_unknown = (uint32)Sql_GetIntData(SqlHandle,45);

			
			PMob->animationsub = (uint32)Sql_GetIntData(SqlHandle,46);

     
      PMob->HPscale = Sql_GetFloatData(SqlHandle,47);
      PMob->MPscale = Sql_GetFloatData(SqlHandle,48);

			//PMob->PBattleAI = new CAIMobDummy(PMob);

			
          //5PMob->PBattleAI->SetCurrentAction(ACTION_SPAWN);
    

			
			PMob->m_HasSpellScript = (uint8)Sql_GetIntData(SqlHandle,49);

			PMob->m_SpellListContainer = mobSpellList::GetMobSpellList(Sql_GetIntData(SqlHandle,50));
			

		
    
		
			ShowDebug("MODEL ID %u\n",Model_ID);

			
		memcpy(&PMob->look,Sql_GetData(SqlHandle,53),23);
		PMob->m_NewSkin = true;
		PMob->m_SkinID = Model_ID;
		
		

	PMob->objtype =TYPE_NPC;
    PMob->loc.zone = PChar->loc.zone;

   
		m_npcList[PMob->id] = PMob;
	
	PMob->loc.p = PChar->loc.p;
			PChar->pushPacket(new CEntityUpdatePacket(PMob,ENTITY_SPAWN));
			PChar->pushPacket(new CEntityUpdatePacket(PMob,ENTITY_UPDATE));
		}
			return false;
	}

return false;*/
	//SPAWN MOGGLE IS SEARCHING THE WHOLE LIST OF THE LAST ZONE THE USERS WAS IN FOR THE NPC THAT HAS THE FACE OF 82
	//TO SPAWN IN THE MOGHOUSE ZONE, THE LIST MIGHT BE LARGE IT MIGHT NOT FOR EXAMPLE LAST ZONE IS 230 HAS 300 NPCS 
	//IN THE LIST USING A FOR LOOP TO LOAD ALL 300 NPCS BUT ONLY  LOAD THE ONE FULLY INTO THE MOG ZONE
	//IT HINK IT WOULD BE BETTER TO JUST GET THE MOG ID FOR EACH MOGHOUSE AND LOAD ONL THE ONE OR 10

//NOT TO SELF PMOB IS A GOOD SYSTEM FOR OBJECT AND NPCS AND MOBS HAS ALOT OF POINTERS AND HAS ALOT OF OPTIONS
	/*if(PChar->profile.nation == 0) //WE WANT TO GET THE PLAYERS NATION FOR THE PLAYERS MOGGLE BECASUE THE MOGGLE IS A PERSONAL MOGGLE NOT A PUBLIC 
	{
		//BASTOK
		//THIS MAY BE THE KEY FOR EACH MOGGLE IT MAY NOT 
	}
	if(PChar->profile.nation == 1) //WE WANT TO GET THE PLAYERS NATION FOR THE PLAYERS MOGGLE BECASUE THE MOGGLE IS A PERSONAL MOGGLE NOT A PUBLIC 
	{
		//SANDY
		//THIS MAY BE THE KEY FOR EACH MOGGLE IT MAY NOT 
	}
	if(PChar->profile.nation == 2) //WE WANT TO GET THE PLAYERS NATION FOR THE PLAYERS MOGGLE BECASUE THE MOGGLE IS A PERSONAL MOGGLE NOT A PUBLIC 
	{
		//WINDY
		//WE COULD JUST BUILD THE MOGGLE COMPLEATLY AS A NPC
		//PERSONAL NOTE TO SELF IF LOOKS CAN BEE LOOPED AS I DID THEN CAN NAMES BE LOOPS AS WELL?
		//WERE THE WHOLE SYSTEM READS DUMMY MOBS NPC OBJECTS
		//UNKOWN HAVE TO CHECK THIS IDEA LATER


		//THIS MAY BE THE KEY FOR EACH MOGGLE IT MAY NOT 
	}
	for (EntityList_t::const_iterator it = m_npcList.begin() ; it != m_npcList.end() ; ++it)
	{
		CNpcEntity* PCurrentNpc = (CNpcEntity*)it->second;

		if(PCurrentNpc->look.face == 82)//MOGGLE FACE ID 82 == PChar->m_costume 
		{
			ShowDebug(CL_CYAN"SPAWNING MOGGLE:BY FACE 82 == %u\n" CL_RESET,PCurrentNpc->look.face);
			//PCurrentNpc->status = STATUS_NORMAL;
			PCurrentNpc->loc.p = PChar->loc.p;
			PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_SPAWN));
			PChar->pushPacket(new CEntityUpdatePacket(PCurrentNpc,ENTITY_UPDATE));
			
			//PCurrentNpc->status = STATUS_DISAPPEAR;
			//return;
		}
		
	}*/
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

void CZone::TOTDChange(TIMETYPE TOTD)
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
            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

				if (PMob->m_SpawnType == SPAWNTYPE_FOG)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
                    PMob->PBattleAI->SetCurrentAction(ACTION_SPAWN);
				}
			}
        }
        break;
		case TIME_NEWDAY:
		{
			for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType == SPAWNTYPE_ATNIGHT)
                {
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
                }
			}
		}
		break;
		case TIME_DAWN:
		{
			ScriptType = SCRIPT_TIME_DAWN;

			for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

				if (PMob->m_SpawnType == SPAWNTYPE_ATEVENING)
				{
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
				}
			}
		}
		break;
		case TIME_DAY:
		{
			ScriptType = SCRIPT_TIME_DAY;

            for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

                if (PMob->m_SpawnType ==  SPAWNTYPE_FOG)
                {
                    PMob->SetDespawnTimer(1);
                    PMob->m_AllowRespawn = false;
                }
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

			for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

				if (PMob->m_SpawnType == SPAWNTYPE_ATEVENING)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
					PMob->PBattleAI->SetCurrentAction(ACTION_SPAWN);
				}
			}
		}
		break;
		case TIME_NIGHT:
		{
			for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end(); ++it)
			{
				CMobEntity* PMob = (CMobEntity*)it->second;

				if (PMob->m_SpawnType == SPAWNTYPE_ATNIGHT)
				{
                    PMob->SetDespawnTimer(0);
                    PMob->m_AllowRespawn = true;
					PMob->PBattleAI->SetCurrentAction(ACTION_SPAWN);
				}
			}
		}
		break;
    }
	if (ScriptType != SCRIPT_NONE)
	{
		for (EntityList_t::const_iterator it = m_charList.begin(); it != m_charList.end(); ++it)
		{
			CCharEntity* PCurrentChar = (CCharEntity*)it->second;
			if(PCurrentChar != NULL && PCurrentChar->loc.zone != NULL)
			{
		//	charutils::CheckEquipLogic(PCurrentChar, ScriptType, TOTD);
			}
		}
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
	//ShowDebug(CL_CYAN"PACKETS %u \n" CL_RESET,packet);
	if(PEntity != NULL)
	{
	if (!m_charList.empty())
	{

		for (EntityList_t::const_iterator it = m_charList.begin() ; it != m_charList.end() ; ++it)
				{
					CCharEntity* PCurrentChar = (CCharEntity*)it->second;
					if(PCurrentChar != NULL && PCurrentChar->is_zoning ==-1 )
					{

						if(message_type == CHAR_INRANGE)
						{
                             if (PEntity != PCurrentChar)
					            {
						          if(distance(PEntity->loc.p, PCurrentChar->loc.p) < 50)
						            {
							         PCurrentChar->pushPacket(new CBasicPacket(*packet));
						            }
						        }
						}
						if(message_type == CHAR_INRANGE_SELF)
						{
                             if (PEntity->objtype == TYPE_PC)
				                {
					                 ((CCharEntity*)PEntity)->pushPacket(new CBasicPacket(*packet));
				                }
						}
						if(message_type == CHAR_INSHOUT)
						{
                             if (PEntity != PCurrentChar)
					            {
						          if(distance(PEntity->loc.p, PCurrentChar->loc.p) < 180)
						            {
							         PCurrentChar->pushPacket(new CBasicPacket(*packet));
						            }
						
					            }
						}
						if(message_type == CHAR_INZONE)
						{
                             if (PEntity != PCurrentChar)
					            {
						       PCurrentChar->pushPacket(new CBasicPacket(*packet));
					            }
						}
					}
		}
	
		delete packet;
	
	}
	}
	else
	{
      // ShowDebug(CL_CYAN"A PACKET WAS CALLED WITH NO PENTITY %u\n" CL_RESET,packet);
	  // delete packet;
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
				if(PChar->PBattleAI != NULL)
				{
            PChar->PBattleAI->CheckCurrentAction(tick);
				}
				if(PChar->PTreasurePool != NULL)
				{
            PChar->PTreasurePool->CheckItems(tick);
				}
				if(PChar->StatusEffectContainer != NULL)
				{
			PChar->StatusEffectContainer->CheckRegen(tick);
				}
			}
			
        }
    }
	for (EntityList_t::const_iterator it = m_mobList.begin(); it != m_mobList.end() ; ++it)
	{
		CMobEntity* PMob = (CMobEntity*)it->second;

		PMob->StatusEffectContainer->CheckEffects(tick);
		PMob->PBattleAI->CheckCurrentAction(tick);
		PMob->StatusEffectContainer->CheckRegen(tick);
	}

  for (EntityList_t::const_iterator it = m_npcList.begin(); it != m_npcList.end() ; ++it)
  {
    CNpcEntity* PNpc = (CNpcEntity*)it->second;

    if(PNpc->PBattleAI != NULL)
    {
      PNpc->PBattleAI->CheckCurrentAction(tick);
    }
  }

	EntityList_t::const_iterator pit = m_petList.begin();
	while(pit != m_petList.end())
	{
		CPetEntity* PPet = (CPetEntity*)pit->second;
		PPet->StatusEffectContainer->CheckEffects(tick);
		PPet->PBattleAI->CheckCurrentAction(tick);
		PPet->StatusEffectContainer->CheckRegen(tick);
		if(PPet->status==STATUS_DISAPPEAR){
			m_petList.erase(pit++);
		}
		else{
			++pit;
		}
	}

	if(m_InstanceHandler != NULL)
    {
		m_InstanceHandler->handleInstances(tick);
	}

   
}

/************************************************************************
*																		*
*  Cервер для обработки активности и статус-эффектов сущностей в зоне.	*
*  Дополнительно обрабатывается проверка на вход и выход персонажей из	*
*  активных областей (пока реализован только вход в область).			*
*  При любом раскладе последними должны обрабатываться персонажи		*
*																		*
************************************************************************/

void CZone::ZoneServerRegion(uint32 tick)
{
	for (EntityList_t::const_iterator it = m_mobList.begin() ; it != m_mobList.end() ; ++it)
	{
		CMobEntity* PMob = (CMobEntity*)it->second;

		PMob->StatusEffectContainer->CheckEffects(tick);
		PMob->PBattleAI->CheckCurrentAction(tick);
	}

	for (EntityList_t::const_iterator it = m_petList.begin() ; it != m_petList.end() ; ++it)
	{
		CPetEntity* PPet = (CPetEntity*)it->second;

		PPet->StatusEffectContainer->CheckEffects(tick);
		PPet->PBattleAI->CheckCurrentAction(tick);
	}

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
				if( PChar->PBattleAI != NULL)
				{
            PChar->PBattleAI->CheckCurrentAction(tick);
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
                        luautils::OnRegionEnter(PChar, *region);
                    }
                    if (PChar->m_InsideRegionID == 0) break;
                }
                else if ((*region)->GetRegionID() == PChar->m_InsideRegionID)
                {
                    luautils::OnRegionLeave(PChar, *region);
                }
            }
            PChar->m_InsideRegionID = RegionID;
        }
	  }
	}
}

EntityList_t CZone::GetCharList()
{
	return m_charList;
}

//===========================================================

/*
id				CBaseEntity
name			CBaseEntity
pos_rot			CBaseEntity
pos_x			CBaseEntity
pos_y			CBaseEntity
pos_z			CBaseEntity
speed			CBaseEntity
speedsub		CBaseEntity
animation		CBaseEntity
animationsub	CBaseEntity
namevis			npc+mob
status			CBaseEntity
unknown
look			CBaseEntity
name_prefix
*/
