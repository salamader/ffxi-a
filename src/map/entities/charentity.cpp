﻿/*
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

#include "../../common/showmsg.h"
#include "../../common/utils.h"

#include <string.h>

#include "../packets/basic.h"
#include "../packets/server_ip.h"

#include "charentity.h"
#include "../spell.h"
#include "../utils/charutils.h"
#include "../utils/battleutils.h"
#include "../utils/petutils.h"
#include "../party.h"

CCharEntity::CCharEntity()
{
	objtype		= TYPE_PC;
	m_EcoSystem = SYSTEM_HUMANOID;

	m_event.reset();

	m_GMlevel = 0;
	SetExpRates = 1;
	first_login = 0;
	is_zoning = -1;
	is_returning = 0;
	is_inevent = 0;
	is_being_chased = false;
	is_dead = 0;
	online_status = 0;
	shutdown_status = 0;
    accid = 0;
	godmode = 0;
	eventid = -1;
	Rage_Mode = 0;
	Is_Public_0_Or_Private_1 = 0; // PUBLIC ACCESSS

	Container    = new CTradeContainer();
	UContainer	 = new CUContainer();

	m_Inventory	 = new CItemContainer(LOC_INVENTORY);
	m_Mogsafe	 = new CItemContainer(LOC_MOGSAFE);
	m_Storage	 = new CItemContainer(LOC_STORAGE);
	m_Tempitems	 = new CItemContainer(LOC_TEMPITEMS);
	m_Moglocker	 = new CItemContainer(LOC_MOGLOCKER);
	m_Mogsatchel = new CItemContainer(LOC_MOGSATCHEL);
	m_Mogsack	 = new CItemContainer(LOC_MOGSACK);

    m_AutomatonName = "";

	memset(& jobs,  0, sizeof(jobs));
	memset(& keys,  0, sizeof(keys));
    memset(& equip, 0, sizeof(equip));
	memset(& RealSkills,   0, sizeof(RealSkills));
    memset(& RegionPoints, 0, sizeof(RegionPoints));
    memset(& nationtp,  0, sizeof(nationtp));
    memset(& expChain,  0, sizeof(expChain));
    memset(& nameflags, 0, sizeof(nameflags));

	memset(& m_SpellList, 0, sizeof(m_SpellList));
	memset(& m_LearnedAbilities, 0, sizeof(m_LearnedAbilities));
    memset(& m_TitleList, 0, sizeof(m_TitleList));
	memset(& m_ZonesList, 0, sizeof(m_ZonesList));
	memset(& m_Abilities, 0, sizeof(m_Abilities));
	memset(& m_TraitList, 0, sizeof(m_TraitList));
    memset(& m_PetCommands,  0, sizeof(m_PetCommands));
	memset(& m_WeaponSkills, 0, sizeof(m_WeaponSkills));
	memset(& m_SetBlueSpells, 0, sizeof(m_SetBlueSpells));
	memset(& m_unlockedAttachments, 0, sizeof(m_unlockedAttachments));

	memset(& m_questLog,    0, sizeof(m_questLog));
	memset(& m_missionLog,  0, sizeof(m_missionLog));
	memset(& m_assaultLog,  0, sizeof(m_assaultLog));
	memset(& m_campaignLog, 0, sizeof(m_campaignLog));

	for(uint8 i = 0; i <= 3; ++i)
	{
		m_missionLog[i].current = 0xFFFF;
	}

	m_missionLog[4].current = 0; // MISSION_TOAU
	m_missionLog[5].current = 0; // MISSION_WOTG

	m_rangedDelay = 0;
	m_copCurrent = 0;
	m_acpCurrent = 0;
	m_mkeCurrent = 0;
	m_asaCurrent = 0;

    m_Costum     = 0;
    m_PVPFlag    = 0;
	m_hasTractor = 0;
	m_hasRaise	 = 0;
    m_hasAutoTarget    = 1;
	m_InsideRegionID   = 0;
	m_LevelRestriction = 0;
	m_insideBCNM = false;
	m_lastBcnmTimePrompt = 0;
	m_AHHistoryTimestamp = 0;
	m_DeathTimestamp = 0;

	m_EquipFlag  = 0;
    m_EquipBlock = 0;
	m_EquipSwap = false;

	m_PlayTime = 0;
	m_ZoneTimer = 0;
	MeritMode = false;

	m_isWeaponSkillKill = false;
	m_isMijinGakure = false;

    BazaarID.clean();
    TradePending.clean();
    InvitePending.clean();

    PLinkshell = NULL;
	PTreasurePool = NULL;
	PWideScanTarget = NULL;

    PRecastContainer = new CRecastContainer(this);
	PLatentEffectContainer = new CLatentEffectContainer(this);

	petZoningInfo.respawnPet = false;
	petZoningInfo.petID = 0;
	petZoningInfo.petType = PETTYPE_AVATAR;			// dummy data, the bool tells us to respawn if required
	petZoningInfo.petHP = 0;
	petZoningInfo.petTP = 0;


}

CCharEntity::~CCharEntity()
{
	clearPacketList();

    if(PTreasurePool != NULL)
    {
        // remove myself
        PTreasurePool->DelMember(this);
    }

	delete Container;
	delete UContainer;
    delete PMeritPoints;
    delete PRecastContainer;

	delete m_Inventory;
	delete m_Mogsafe;
	delete m_Storage;
	delete m_Tempitems;
	delete m_Moglocker;
	delete m_Mogsatchel;
	delete m_Mogsack;
}

uint8 CCharEntity::GetGender()
{
    return (look.race)%2 ^ (look.race > 6);
}

int32 CCharEntity::firstPacketSize()
{
	return PacketList.front()->getSize();
}

bool CCharEntity::isPacketListEmpty()
{
	return PacketList.empty();
}

void CCharEntity::clearPacketList()
{
	while(!PacketList.empty())
	{
	   delete popPacket();
	}
}

void CCharEntity::resetPetZoningInfo()
{
	// reset the petZoning info
	petZoningInfo.petHP = 0;
	petZoningInfo.petTP = 0;
	petZoningInfo.respawnPet = false;
	petZoningInfo.petType = PETTYPE_AVATAR;
}

void CCharEntity::pushPacket(CBasicPacket* packet)
{
	if(this != NULL)
	{
	PacketList.push_back(packet);
	}
	else
	{
		ShowNotice(CL_BG_RED"NO MORE PACKETS\n"CL_RESET);
	}
	
}

CBasicPacket* CCharEntity::popPacket()
{
	CBasicPacket* PPacket = PacketList.front();
	PacketList.pop_front();
	return PPacket;
}


/************************************************************************
*																		*
*	has char unlocked this weapon										*
*																		*
************************************************************************/
bool CCharEntity::isWeaponUnlocked(uint16 indexid)
{
	return unlockedWeapons[indexid-1].unlocked;
}


/************************************************************************
*																		*
*	add WS points to a weapon											*
*																		*
************************************************************************/
bool CCharEntity::addWsPoints(uint8 points, uint16 WeaponIndex)
{
	this->unlockedWeapons[WeaponIndex].points += points;

	if (unlockedWeapons[WeaponIndex].points >= unlockedWeapons[WeaponIndex].required)
	{
		// char has unlocked weapon
		unlockedWeapons[WeaponIndex].unlocked = true;					// unlock the weapon

		charutils::saveCharWsPoints(this, WeaponIndex, 0);				// remove the temp points count, we are done with it
		//charutils::SaveCharUnlockedWeapons(this);						// save chars unlocked status's
		this->unlockedWeapons[WeaponIndex].points = 0;
		return true;
	}
	else
	{
		// char has not unlocked weapon, add points
		charutils::saveCharWsPoints(this, WeaponIndex, unlockedWeapons[WeaponIndex].points);			// update temp points count variable
		return false;
	}
}

/************************************************************************
*																		*
*  Возвращаем контейнер с указанным ID. Если ID выходит за рамки, то	*
*  защищаем сервер от падения использованием контейнера временных		*
*  предметов в качестве заглушки (из этого контейнера предметы нельзя	*
*  перемещать, надевать, передавать, продавать и т.д.). Отображаем		*
*  сообщение о фатальной ошибке.										*
*																		*
************************************************************************/

CItemContainer* CCharEntity::getStorage(uint8 LocationID)
{
	switch(LocationID)
	{
		case LOC_INVENTORY:	 return m_Inventory;
		case LOC_MOGSAFE:	 return m_Mogsafe;
		case LOC_STORAGE:	 return m_Storage;
		case LOC_TEMPITEMS:	 return m_Tempitems;
		case LOC_MOGLOCKER:	 return m_Moglocker;
		case LOC_MOGSATCHEL: return m_Mogsatchel;
		case LOC_MOGSACK:	 return m_Mogsack;
	}

	DSP_DEBUG_BREAK_IF(LocationID >= MAX_CONTAINER_ID);	// неразрешенный ID хранилища
	return 0;
}

int8 CCharEntity::getShieldSize()
{
	CItemArmor* PItem = (CItemArmor*)(getStorage(LOC_INVENTORY)->GetItem(equip[SLOT_SUB]));

    if(PItem == NULL){
        return 0;
    }

    if(!PItem->IsShield()){
        return 0;
    }

    return PItem->getShieldSize();
}

void CCharEntity::SetName(int8* name)
{
	this->name.insert(0, name, dsp_cap(strlen((const int8*)name), 0, 15));
}

uint16 CCharEntity::addTP(float tp)
{
	float oldtp = health.tp;
	tp = CBattleEntity::addTP(tp);
	if ((oldtp < 100 && health.tp >= 100 ) || (oldtp >= 100 && health.tp < 100))
	{
		PLatentEffectContainer->CheckLatentsTP(health.tp);
	}
	return abs(tp);
}

int32 CCharEntity::addHP(int32 hp)
{
	hp = CBattleEntity::addHP(hp);
	PLatentEffectContainer->CheckLatentsHP(health.hp);

	return abs(hp);
}

int32 CCharEntity::addMP(int32 mp)
{
	mp = CBattleEntity::addMP(mp);
	//PLatentEffectContainer->CheckLatentsHP(health.mp);

	return abs(mp);
}

bool CCharEntity::getWeaponSkillKill()
{
	return m_isWeaponSkillKill;
}

void CCharEntity::setWeaponSkillKill(bool isWeaponSkillKill)
{
	m_isWeaponSkillKill = isWeaponSkillKill;
}

bool CCharEntity::getMijinGakure()
{
	return m_isMijinGakure;
}

void CCharEntity::setMijinGakure(bool isMijinGakure)
{
	m_isMijinGakure = isMijinGakure;
}

void CCharEntity::SetPlayTime(uint32 setTime)
{
	m_PlayTime = setTime;
}

void CCharEntity::AddPlayTime()
{
	m_ZoneTimer++;
	if((m_ZoneTimer % 2) == 0)
		m_PlayTime++;
}

int32 CCharEntity::leavegame()
{
	
	//ShowMessage(CL_YELLOW"I AM LEAVEING GAME %s\n"CL_RESET,this->GetName());
	this->is_zoning = 1;
	this->shutdown_status =1;
	this->status = STATUS_SHUTDOWN;
	this->clearPacketList();
	this->pushPacket(new CServerIPPacket(this,1));
   
	return false;
}