/*
===========================================================================

  Copyright (c) 2010-2013 Darkstar Dev Teams

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
#include "../entities/battleentity.h"
#include "../utils/charutils.h"
#include "../utils/itemutils.h"

#include "item_weapon.h"


/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CItemWeapon::CItemWeapon(uint16 id) : CItemArmor(id)
{
	setType(ITEM_WEAPON);

	m_skillType		= SKILL_NON;
	m_subSkillType	= SUBSKILL_XBO;
	m_damage		= 0;
    m_effect		= 0;
	m_dmgType		= DAMAGE_NONE;
	m_delay			= 8000;
	m_baseDelay		= 8000;		//this should only be needed for mobs (specifically mnks)
    m_maxHit		= 0;
    m_ranged		= false;
    m_twoHanded		= false;
	m_unlockId		= 0;
}

CItemWeapon::~CItemWeapon() {}

void CItemWeapon::resetDelay()
{
    setDelay(getBaseDelay());
}

/************************************************************************
*                                                                       *
*  Weapons to attack from a distance (Range)                            *
*                                                                       *
************************************************************************/

bool CItemWeapon::isThrowing()
{
    return m_ranged && getSkillType() == SKILL_THR;
}

bool CItemWeapon::isRanged()
{
    return m_ranged;
}

/************************************************************************
*                                                                       *
*  Two-Handed Weapon                                                    *
*                                                                       *
************************************************************************/

bool CItemWeapon::isTwoHanded()
{
    return m_twoHanded;
}


/************************************************************************
*                                                                       *
*  get unlockable property                                              *
*                                                                       *
************************************************************************/

bool CItemWeapon::isUnlockable()
{
    if(m_skillType == SKILL_NON) return false;

	return ( m_unlockId > 0 ? true : false );
}


/************************************************************************
*                                                                       *
*   Set the type of weapon and the flag isTwoHanded                     *
*                                                                       *
************************************************************************/

void CItemWeapon::setSkillType(uint8 skillType)
{
    switch (skillType)
    {
	    case SKILL_GSD:
	    case SKILL_GAX:
	    case SKILL_SYH:
	    case SKILL_POL:
	    case SKILL_GKT:
	    case SKILL_STF:
            m_twoHanded = true;
		break;
        case SKILL_ARC:
        case SKILL_MRK:
        case SKILL_THR:
            m_ranged = true;
        break;
	}
	m_skillType = skillType;
}

uint8 CItemWeapon::getSkillType()
{
	return m_skillType;
}

/************************************************************************
*                                                                       *
*   Set/get sub skillType.  Used for guns vs crossbows and other		*
*	exclusives									                        *
*                                                                       *
************************************************************************/

void CItemWeapon::setSubSkillType(uint8 subSkillType)
{
	m_subSkillType = subSkillType;
}

uint8 CItemWeapon::getSubSkillType()
{
	return m_subSkillType;
}

/************************************************************************
*																		*
*  Set the time delay weapons. Immediately translate the value in the 	*
*  MLS. All mathematical operations are on integers, it is for this 	*
*  procedure is very important not to lose the data.					*
*																		*
************************************************************************/

void CItemWeapon::setDelay(uint16 delay)
{
	m_delay = delay;
}

int16 CItemWeapon::getDelay()
{
	return m_delay;
}

/************************************************************************
*																		*
*  Set/get the un-adjusted delay of the weapon							*
*  This is to fix delay adjustments of mobs and is not intended for		*
*  use outside of zoneutils/mobutils									*
*																		*
************************************************************************/

void CItemWeapon::setBaseDelay(uint16 delay)
{
	m_baseDelay = delay;
}

int16 CItemWeapon::getBaseDelay()
{
	return m_baseDelay;
}
/************************************************************************
*                                                                       *
*  get unlock id		                                                *
*                                                                       *
************************************************************************/

uint16 CItemWeapon::getUnlockId()
{
	return m_unlockId;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CItemWeapon::setDamage(uint16 damage)
{
	m_damage = damage;
}

uint16 CItemWeapon::getDamage()
{
	return m_damage;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CItemWeapon::setDmgType(uint16 dmgType)
{
	m_dmgType = dmgType;
}

uint16 CItemWeapon::getDmgType()
{
	return m_dmgType;
}

/************************************************************************
*                                                                       *
*  Additional weapon damage (fire, water, etc.)			                *
*                                                                       *
************************************************************************/

void CItemWeapon::setAdditionalEffect(uint8 effect)
{
    m_effect = effect;
}

uint8 CItemWeapon::getAdditionalEffect()
{
    return m_effect;
}


/************************************************************************
*                                                                       *
*  set unlockable property of weapon			                        *
*                                                                       *
************************************************************************/

void CItemWeapon::setUnlockable(uint16 unlockId)
{
    m_unlockId = unlockId;
}

/************************************************************************
*                                                                       *
*  The maximum number of weapon attacks				                    *
*                                                                       *
************************************************************************/

void CItemWeapon::setMaxHit(uint8 hit)
{
    m_maxHit = dsp_min(hit, 8);
}

/************************************************************************
*                                                                       *
*  Calculating the number of hits                                       *
*                                                                       *
************************************************************************/

uint8 CItemWeapon::getHitCount(uint8 checkMobHits)
{
    int num = 1;
    int distribution = rand()%100;

	uint8 hits = m_maxHit;
	if (checkMobHits != 0) hits = checkMobHits;

    switch (hits)
    {
        case 0: break;
        case 1: break;
        case 2: // cdf = 55,100
		    if(distribution < 55){ break; }
		    else{ num+=1; break;}
		    break;
        case 3: // cdf = 30,80,100
		    if(distribution < 30){ break; }
		    else if(distribution < 80){ num+=1; break; }
		    else{ num+=2; break; }
		    break;
        case 4: // cdf = 20,50,80,100
		    if(distribution < 20){ break; }
		    else if(distribution < 50){ num+=1; break; }
		    else if(distribution < 80){ num+=2; break; }
		    else{ num+=3; break; }
		    break;
        case 5: // cdf = 10,30,60,90,100
		    if(distribution < 10){ break; }
		    else if(distribution < 30){ num+=1; break; }
		    else if(distribution < 60){ num+=2; break; }
		    else if(distribution < 90){ num+=3; break; }
		    else{ num+=4; break; }
		    break;
        case 6: // cdf = 10,30,50,70,90,100
            if(distribution < 10){ break; }
		    else if(distribution < 30){num+=1; break; }
		    else if(distribution < 50){num+=2; break; }
		    else if(distribution < 70){num+=3; break; }
		    else if(distribution < 90){num+=4; break; }
		    else{ num+=5; break; }
            break;
        case 7: // cdf = 5,20,45,70,85,95,100
            if(distribution < 5){ break; }
		    else if(distribution < 20){num+=1; break; }
		    else if(distribution < 45){num+=2; break; }
		    else if(distribution < 70){num+=3; break; }
		    else if(distribution < 85){num+=4; break; }
		    else if(distribution < 95){num+=5; break; }
		    else{ num+=6; break; }
            break;
        case 8: // cdf = 5,20,45,70,85,95,98,100
		    if(distribution < 5){ break; }
		    else if(distribution < 20){num+=1; break; }
		    else if(distribution < 45){num+=2; break; }
		    else if(distribution < 70){num+=3; break; }
		    else if(distribution < 85){num+=4; break; }
		    else if(distribution < 95){num+=5; break; }
		    else if(distribution < 98){num+=6; break; }
		    else{ num+=7; break; }
            break;
	}
    return dsp_min(num,8); // no more than eight times in one single attack
}


//Blunt = MOD_HANDTOHAND, MOD_CLUB, MOD_STAFF
//Slashing = MOD_AXE, MOD_GREATAXE, MOD_GREATSWORD, MOD_SWORD, MOD_SCYTHE, MOD_KATANA, MOD_GREATKATANA
//Piercing = MOD_DAGGER, MOD_POLEARM, MOD_ARCHERY, MOD_MARKSMANSHIP

// Hand-to-Hand is a type of Blunt, which is why MNK is effective against the Undead (Skeleton and Corsica).
// I do not know what you mean by impact and Range? MOD_THROWING could go in any of them because there are different types of weapons.
// For example, Boomerangs are Blunt, chakrams are slashing and piercing are Shurikens.