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

#include "magic_state.h"
#include "../../entities/mobentity.h"
#include "../../entities/charentity.h"
#include "../../lua/luautils.h"
#include "../../utils/battleutils.h"
#include "../../utils/charutils.h"
#include "../ai_pet_dummy.h"
#include "../../packets/char_update.h"

#include "../../spell.h"

CMagicState::CMagicState(CBattleEntity* PEntity, CTargetFind* PTargetFind, float maxStartDistance, float maxFinishDistance)
: CState(PEntity, PTargetFind)
{
	m_PSpell = NULL;
	m_enableCasting = true;
	m_maxStartDistance = maxStartDistance;
	m_maxFinishDistance = maxFinishDistance;
}

STATESTATUS CMagicState::CastSpell(CSpell* PSpell, CBattleEntity* PTarget, uint8 flags)
{
	if(!CanCastSpell(PSpell, PTarget, flags))
	{
		return STATESTATUS_ERROR;
	}

	Clear();

	m_PSpell = PSpell;
	m_PTarget = PTarget;
	m_flags = flags;
    m_startPosition = m_PEntity->loc.p;

	m_castTime = CalculateCastTime(PSpell);

	apAction_t action;

	action.ActionTarget = m_PTarget;
	action.reaction   = REACTION_NONE;
	action.speceffect = SPECEFFECT_NONE;
	action.animation  = 0;
	action.param	  = m_PSpell->getID();
	action.messageID  = 327; // starts casting

    m_PEntity->m_ActionList.clear();
	m_PEntity->m_ActionList.push_back(action);
	m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(m_PEntity));

	return STATESTATUS_START;
}

bool CMagicState::CanCastSpell(CSpell* PSpell, CBattleEntity* PTarget, uint8 flags)
{
	if(PSpell == NULL) return false;

	if(!ValidCast(PSpell, PTarget))
	{
		return false;
	}

    if(m_PEntity->objtype == TYPE_PC)
    {
        float distanceValue = distance(m_PEntity->loc.p, PTarget->loc.p);
        // pc has special messages
        if(distanceValue > 25*map_config.magic_dist_mod)
        {
            PushError(MSGBASIC_TOO_FAR_AWAY, PSpell->getID());
            return false;
        }
        else if(distanceValue > m_maxStartDistance*map_config.magic_dist_mod)
        {
            PushError(MSGBASIC_OUT_OF_RANGE_UNABLE_CAST, PSpell->getID());
            return false;
        }
    }
    else if(!m_PTargetFind->isWithinRange(&PTarget->loc.p, m_maxStartDistance)){
        return false;
    }

    // player specific
    if(m_PEntity->objtype == TYPE_PC && !ValidCharCast(PSpell))
    {
        return false;
    }


    int32 msgID = luautils::OnMagicCastingCheck(m_PEntity, PTarget, PSpell);
	if(msgID){
        PushError((MSGBASIC_ID)msgID, PSpell->getID());
		return false;
	}

	return true;
}

bool CMagicState::IsInterrupted()
{
	return m_interruptSpell;
}

void CMagicState::ForceInterrupt()
{
	m_interruptSpell = true;
}

CSpell* CMagicState::GetSpell()
{
	return m_PSpell;
}

STATESTATUS CMagicState::Update(uint32 tick)
{
	if(CState::Update(tick) == STATESTATUS_ERROR || !CheckValidTarget(m_PTarget))
	{
		return STATESTATUS_ERROR;
	}

	if(m_startTime == 0) m_startTime = tick;

	if(tick - m_startTime >= m_castTime)
	{
		if(CheckInterrupt())
		{
			return STATESTATUS_INTERRUPT;
		}
		else
		{
			return STATESTATUS_FINISH;
		}
	}

	return STATESTATUS_TICK;
}

void CMagicState::Clear()
{
	CState::Clear();

	m_PSpell = NULL;
	m_interruptSpell = false;
    m_startTime = 0;
}

int8 QuickMagicChance = 0;

uint32 CMagicState::CalculateCastTime(CSpell* PSpell)
{
    if(PSpell == NULL)
    {
        return 0;
    }

    bool applyArts = true;
    uint32 base = PSpell->getCastTime();
    uint32 cast = base;

    if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
        {
            uint16 bonus = m_PEntity->getMod(MOD_ALACRITY_CELERITY_EFFECT);
            cast -= base * ((100 - (50 + bonus)) / 100.0f);
            applyArts = false;
        }
        else if (applyArts)
        {
            cast = cast * (1.0f + m_PEntity->getMod(MOD_BLACK_MAGIC_CAST)/100.0f);
        }
		if(m_PEntity->objtype == TYPE_PC)
    	{
			int16 BlackCastMod = m_PEntity->getMod(MOD_BLACK_CAST);
			cast = cast * ((float)(100-BlackCastMod)/100);
			if (cast < 1000)
			{
				cast = 1000;
			}
		}
    }
    else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
    {
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CELERITY))
        {
            uint16 bonus = m_PEntity->getMod(MOD_ALACRITY_CELERITY_EFFECT);
            cast -= base * ((100 - (50 + bonus)) / 100.0f);
            applyArts = false;
        }
        else if (applyArts)
        {
            cast = cast * (1.0f + m_PEntity->getMod(MOD_WHITE_MAGIC_CAST)/100.0f);
        }
		if(m_PEntity->objtype == TYPE_PC)
    	{
			if ((PSpell->getID() >= 1 && PSpell->getID() <= 11) || (PSpell->getID() == 93 || PSpell->getID() == 474 || PSpell->getID() == 475))
			{
				int16 CureCastMod = m_PEntity->getMod(MOD_CURE_CAST);
				if (PSpell->getID() >= 1 && PSpell->getID() <= 11) // Cure - Curaga Magic Cast Modifier
				{
					cast = cast * ((float)(100-CureCastMod)/100);
					if (cast < 1000)
					{
						cast = 1000;
					}
				}
				else if (PSpell->getID() == 93 || PSpell->getID() == 474 || PSpell->getID() == 475) // Cura Magic Cast Modifier
				{
					cast = cast * ((float)(100-CureCastMod)/100);
					if (cast < 1000)
					{
						cast = 1000;
					}
				}
			}
			else if ((PSpell->getID() >= 14 && PSpell->getID() <= 20) || PSpell->getID() == 94 || PSpell->getID() == 95 || PSpell->getID() == 143) // Status Ailment Recovery Spells (Divine Benison)
			{
				int16 DivineBenisonCastMod = m_PEntity->getMod(MOD_DIVINE_BENISON_FASTCAST);
				cast = cast * ((float)(100-DivineBenisonCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getID() == 54) // Stoneskin Cast Modifier
			{
				int16 StoneskinCastMod = m_PEntity->getMod(MOD_STONESKIN_CAST);
				cast = cast * ((float)(100-StoneskinCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
		}
		if(m_PEntity->objtype == TYPE_PC)
    	{
			if (PSpell->getSpellGroup() == SPELLGROUP_SUMMONING) // Summoning Magic Cast Modifiers
			{
				int16 SummoningCastMod = m_PEntity->getMod(MOD_SUMMON_CAST);
				cast = cast * ((float)(100-SummoningCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSpellGroup() == SPELLGROUP_BLUE) // Blue Magic Cast Modifiers
			{
				int16 BlueCastMod = m_PEntity->getMod(MOD_BLUE_CAST);
				cast = cast * ((float)(100-BlueCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU) // Ninjutsu Cast Modifiers
			{
				if (PSpell->getID() >= 338 && PSpell->getID() <= 340) // Utsusemi Cast Modifier
				{
					int16 UtsusemiCastMod = m_PEntity->getMod(MOD_UTSUSEMI_CAST);
					cast = cast * ((float)(100-UtsusemiCastMod)/100);
					if (cast < 1000)
					{
						cast = 1000;
					}
				}
			}
			else if (PSpell->getSpellGroup() == SPELLGROUP_SONG) // Song Cast Modifiers
			{
				int16 SongCastMod = m_PEntity->getMod(MOD_SONG_CAST);
				cast = cast * ((float)(100-SongCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
				if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TROUBADOUR) && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
				{
					cast = cast * .75;
				}
				else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
				{
					
					cast = cast * .5;
					int16 NightingaleMerit = (((CCharEntity*)m_PEntity)->PMeritPoints->GetMeritValue(MERIT_NIGHTINGALE,((CCharEntity*)m_PEntity))) - 25;
					int8 NightingaleChance = (rand() % 99) + 1;
					if (NightingaleChance <= NightingaleMerit)
					{
						cast = 0;
					}
				}
				else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TROUBADOUR))
				{
					cast = cast * 1.5;
				}
			}
	
			// Grimoire Cast Modifier
			if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_LIGHT_ARTS) || m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_DARK_ARTS))
			{
				if (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY) || !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
				{
					int16 GrimoireCastMod = m_PEntity->getMod(MOD_GRIMOIRE_CAST);
					cast = cast * ((float)(100-GrimoireCastMod)/100);
					if (cast < 1000)
					{
						cast = 1000;
					}
				}
			}
	
			// Magic Skill Type Casting Modifiers	
			if (PSpell->getSkillType() == 34) // Enhancing Magic Cast Modifier
			{
				int16 EnhancingCastMod = m_PEntity->getMod(MOD_ENHANCING_CAST);
				cast = cast * ((float)(100-EnhancingCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSkillType() == 37) // Dark Magic Cast Modifier
			{
				int16 DarkCastMod = m_PEntity->getMod(MOD_DARK_MAG_CAST);
				cast = cast * ((float)(100-DarkCastMod)/100);
				if (cast	< 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSkillType() == 33) // Healing Magic Cast Modifier
			{
				int16 HealingCastMod = m_PEntity->getMod(MOD_HEALING_CAST);
				cast = cast * ((float)(100-HealingCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSkillType() == 36) // Elemental Magic Cast Modifier
			{
				int16 ElementalCastMod = m_PEntity->getMod(MOD_ELEMENTAL_CAST);
				cast = cast * ((float)(100-ElementalCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
			else if (PSpell->getSkillType() == 35) // Enfeebling Magic Cast Modifier
			{
				int16 EnfeeblingCastMod = m_PEntity->getMod(MOD_ENFEEBLING_CAST);
				cast = cast * ((float)(100-EnfeeblingCastMod)/100);
				if (cast < 1000)
				{
					cast = 1000;
				}
			}
	
			// Quick Magic
			if (m_PEntity->getMod(MOD_QUICK_MAGIC) > 0)
			{
				QuickMagicChance = (rand() % 99) + 1;
				if (QuickMagicChance < m_PEntity->getMod(MOD_QUICK_MAGIC))
				{
					cast = 0;
					return cast;
				}
			}
		}
	}

    int8 fastCast = dsp_cap(m_PEntity->getMod(MOD_FASTCAST),-100,50);
    int8 uncappedFastCast = dsp_cap(m_PEntity->getMod(MOD_UFASTCAST),-100,100);
    float sumFastCast = dsp_cap(fastCast + uncappedFastCast, -100, 100);

    return cast * ((100.0f - sumFastCast)/100.0f);
}

int16 CMagicState::CalculateMPCost(CSpell* PSpell)
{
    if(PSpell == NULL)
    {
        ShowWarning("CMagicState::CalculateMPCost Spell is NULL\n");
        return 0;
    }

    // ninja tools or bard song
    if(!PSpell->hasMPCost())
    {
        return 0;
    }

    bool applyArts = true;
    uint16 base = PSpell->getMPCost();
    if (PSpell->getID() == 478 || PSpell->getID() == 502) //Embrava/Kaustra
    {
        base = m_PEntity->health.maxmp * 0.2;
    }

    int16 cost = base;

    if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
        {
            cost *= 2;
            applyArts = false;
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PARSIMONY))
        {
            cost /= 2;
            applyArts = false;
        }
        else if (applyArts)
        {
            cost += base * (m_PEntity->getMod(MOD_BLACK_MAGIC_COST)/100.0f);
        }
    }
    else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
    {
        if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION))
        {
            cost *= 2;
            applyArts = false;
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_PENURY))
        {
            cost /= 2;
            applyArts = false;
        }
        else if (applyArts)
        {
            cost += base * (m_PEntity->getMod(MOD_WHITE_MAGIC_COST)/100.0f);
        }
    }
    return dsp_cap(cost, 0, 9999);
}

uint32 CMagicState::CalculateRecastTime(CSpell* PSpell)
{
    if(PSpell == NULL)
    {
        return 0;
    }

    bool applyArts = true;
    uint32 base = PSpell->getRecastTime();
    uint32 recast = base;

    //apply Fast Cast
    recast *= ((100.0f-dsp_cap((float)m_PEntity->getMod(MOD_FASTCAST)/2.0f,0.0f,25.0f))/100.0f);

    int16 haste = m_PEntity->getMod(MOD_HASTE_MAGIC) + m_PEntity->getMod(MOD_HASTE_GEAR);

    recast *= ((float)(1024-haste)/1024);

    recast = dsp_max(recast, base * 0.2f);

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_COMPOSURE))
    {
        recast *= 1.25;
    }

    if (PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        if (PSpell->getAOE() == SPELLAOE_RADIAL_MANI && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
        {
            if (m_PEntity->GetMJob() == JOB_SCH)
            {
                recast *= 2;
            }
            else
            {
                recast *= 3;
            }
            applyArts = false;
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY))
        {
            uint16 bonus = m_PEntity->getMod(MOD_ALACRITY_CELERITY_EFFECT);
            recast *=  ((50 - bonus) / 100.0f);

            applyArts = false;
        }
        if (applyArts)
        {
            recast *= (1.0f + m_PEntity->getMod(MOD_BLACK_MAGIC_RECAST)/100.0f);
        }
    }
    else if (PSpell->getSpellGroup() == SPELLGROUP_WHITE)
    {
        if (PSpell->getAOE() == SPELLAOE_RADIAL_ACCE && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ACCESSION))
        {
            if (m_PEntity->GetMJob() == JOB_SCH)
            {
                recast *= 2;
            }
            else
            {
                recast *= 3;
            }
            applyArts = false;
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CELERITY))
        {
            uint16 bonus = m_PEntity->getMod(MOD_ALACRITY_CELERITY_EFFECT);
            recast *=  ((50 - bonus) / 100.0f);

            applyArts = false;
        }
        if (applyArts)
        {
            recast *= (1.0f + m_PEntity->getMod(MOD_WHITE_MAGIC_RECAST)/100.0f);
        }
		if(m_PEntity->objtype == TYPE_PC)
    	{
			if ((PSpell->getID() >= 1 && PSpell->getID() <= 11) || (PSpell->getID() == 93 || PSpell->getID() == 474 || PSpell->getID() == 475))
			{
				int16 CureCastMod = m_PEntity->getMod(MOD_CURE_CAST);
				if (PSpell->getID() >= 1 && PSpell->getID() <= 11) // Cure - Curaga Magic Cast Modifier
				{
					recast = recast * ((float)(100-CureCastMod)/100);
					if (recast < 1000)
					{
						recast = 1000;
					}
				}
				else if (PSpell->getID() == 93 || PSpell->getID() == 474 || PSpell->getID() == 475) // Cura Magic Cast Modifier
				{
					recast = recast * ((float)(100-CureCastMod)/100);
					if (recast < 1000)
					{
						recast = 1000;
					}
				}
			}
			else if ((PSpell->getID() >= 14 && PSpell->getID() <= 20) || PSpell->getID() == 94 || PSpell->getID() == 95 || PSpell->getID() == 143) // Status Ailment Recovery Spells (Divine Benison)
			{
				int16 DivineBenisonCastMod = m_PEntity->getMod(MOD_DIVINE_BENISON_FASTCAST);
				recast = recast * ((float)(100-DivineBenisonCastMod)/100);
				if (recast < 1000)
				{
					recast = 1000;
				}
			}
			else if (PSpell->getID() == 54) // Stoneskin Cast Modifier
			{
				int16 StoneskinCastMod = m_PEntity->getMod(MOD_STONESKIN_CAST);
				recast = recast * ((float)(100-StoneskinCastMod)/100);
				if (recast < 1000)
				{
					recast = 1000;
				}
			}
		}
		if (PSpell->getSpellGroup() == SPELLGROUP_SUMMONING) // Summoning Magic Cast Modifiers
		{
			int16 SummoningCastMod = m_PEntity->getMod(MOD_SUMMON_CAST);
			recast = recast * ((float)(100-SummoningCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSpellGroup() == SPELLGROUP_BLUE) // Blue Magic Cast Modifiers
		{
			int16 BlueCastMod = m_PEntity->getMod(MOD_BLUE_CAST);
			recast = recast * ((float)(100-BlueCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU) // Ninjutsu Cast Modifiers
		{
			if (PSpell->getID() >= 338 && PSpell->getID() <= 340) // Utsusemi Cast Modifier
			{
				int16 UtsusemiCastMod = m_PEntity->getMod(MOD_UTSUSEMI_CAST);
				recast = recast * ((float)(100-UtsusemiCastMod)/100);
				if (recast < 1000)
				{
					recast = 1000;
				}
			}
		}
		else if (PSpell->getSpellGroup() == SPELLGROUP_SONG) // Song Cast Modifiers
		{
			int16 SongCastMod = m_PEntity->getMod(MOD_SONG_CAST);
			recast = recast * ((float)(100-SongCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
			if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TROUBADOUR) && m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
			{
				recast = recast * .75;
			}
			else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_NIGHTINGALE))
			{
				recast = recast * .5;
				int16 NightingaleMerit = (((CCharEntity*)m_PEntity)->PMeritPoints->GetMeritValue(MERIT_NIGHTINGALE,((CCharEntity*)m_PEntity))) - 25;
				int8 NightingaleChance = (rand() % 99) + 1;
				if (NightingaleChance <= NightingaleMerit)
				{
					recast = 0;
				}
			}
			else if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TROUBADOUR))
			{
				recast = recast * 1.5;
			}
		}
	
		// Grimoire Cast Modifier
		if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_LIGHT_ARTS) || m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_DARK_ARTS))
		{
			if (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_ALACRITY) || !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANIFESTATION))
			{
				int16 GrimoireCastMod = m_PEntity->getMod(MOD_GRIMOIRE_CAST);
				recast = recast * ((float)(100-GrimoireCastMod)/100);
				if (recast < 1000)
				{
					recast = 1000;
				}
			}
		}
	
		// Magic Skill Type Casting Modifiers	
		if (PSpell->getSkillType() == 34) // Enhancing Magic Cast Modifier
		{
			int16 EnhancingCastMod = m_PEntity->getMod(MOD_ENHANCING_CAST);
			recast = recast * ((float)(100-EnhancingCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSkillType() == 37) // Dark Magic Cast Modifier
		{
			int16 DarkCastMod = m_PEntity->getMod(MOD_DARK_MAG_CAST);
			recast = recast * ((float)(100-DarkCastMod)/100);
			if (recast	< 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSkillType() == 33) // Healing Magic Cast Modifier
		{
			int16 HealingCastMod = m_PEntity->getMod(MOD_HEALING_CAST);
			recast = recast * ((float)(100-HealingCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSkillType() == 36) // Elemental Magic Cast Modifier
		{
			int16 ElementalCastMod = m_PEntity->getMod(MOD_ELEMENTAL_CAST);
			recast = recast * ((float)(100-ElementalCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
		else if (PSpell->getSkillType() == 35) // Enfeebling Magic Cast Modifier
		{
			int16 EnfeeblingCastMod = m_PEntity->getMod(MOD_ENFEEBLING_CAST);
			recast = recast * ((float)(100-EnfeeblingCastMod)/100);
			if (recast < 1000)
			{
				recast = 1000;
			}
		}
	
		// Quick Magic
		if (m_PEntity->getMod(MOD_QUICK_MAGIC) > 0)
		{
			QuickMagicChance = (rand() % 99) + 1;
			if (QuickMagicChance < m_PEntity->getMod(MOD_QUICK_MAGIC))
			{
				recast = 0;
				return recast;
			}
		}
    }

    return recast;
}

bool CMagicState::CheckInterrupt()
{
	if(m_interruptSpell)
	{
		PushMessage(MSGBASIC_IS_INTERRUPTED);
		return true;
	}

	if(!m_PTargetFind->isWithinRange(&m_PTarget->loc.p, m_maxFinishDistance))
    {
        PushError(MSGBASIC_OUT_OF_RANGE_UNABLE_CAST, m_PSpell->getID());
         return true;
    }

    // check if in same place
    if((m_PEntity->objtype == TYPE_PC && HasMoved()) && map_config.magic_movement == 0)
    {
        PushError(MSGBASIC_IS_INTERRUPTED, m_PSpell->getID());
        return true;
    }

	if(!ValidCast(m_PSpell, m_PTarget))
	{
		return true;
	}

	if(battleutils::IsIntimidated(m_PEntity, m_PTarget))
	{
		PushMessage(MSGBASIC_IS_INTIMIDATED);
		return true;
	}

	if(battleutils::IsParalyzed(m_PEntity))
	{
		PushMessage(MSGBASIC_IS_PARALYZED);
		return true;
	}

	return false;
}

bool CMagicState::ValidCast(CSpell* PSpell, CBattleEntity* PTarget)
{
    if(!CheckValidTarget(PTarget)) return false;

	if(!m_enableCasting ||
		m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE) ||
		m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MUTE))
	{
        PushError(MSGBASIC_UNABLE_TO_CAST_SPELLS, PSpell->getID());
		return false;
	}

    if (PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU)
    {
        if(m_PEntity->objtype == TYPE_PC && !(m_flags & MAGICFLAGS_IGNORE_TOOLS) && !battleutils::HasNinjaTool(m_PEntity, PSpell, false))
        {
            PushError(MSGBASIC_NO_NINJA_TOOLS, PSpell->getID());
            return false;
        }
    }
    // check has mp available
    else if((!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT) || !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAWELL)) && 
	!(m_flags & MAGICFLAGS_IGNORE_MP) && CalculateMPCost(PSpell) > m_PEntity->health.mp)
    {
        if(m_PEntity->objtype == TYPE_MOB && m_PEntity->health.maxmp == 0)
        {
            ShowWarning("CMagicState::ValidCast Mob (%u) tried to cast magic with no mp!\n", m_PEntity->id);
        }
        PushError(MSGBASIC_NOT_ENOUGH_MP, PSpell->getID());
        return false;
    }

    if(PTarget->isDead() && !(PSpell->getValidTarget() & TARGET_PLAYER_DEAD))
    {
        return false;
    }

    if(!PTarget->isDead() && (PSpell->getValidTarget() & TARGET_PLAYER_DEAD))
    {
        return false;
    }

	return true;
}

void CMagicState::InterruptSpell()
{
    DSP_DEBUG_BREAK_IF(m_PSpell == NULL);
    DSP_DEBUG_BREAK_IF(m_PEntity->Check_Engagment->GetCurrentAction() != ACTION_MAGIC_INTERRUPT);

    apAction_t action;
    action.ActionTarget = m_PEntity;
    action.reaction   = REACTION_NONE;
    action.speceffect = SPECEFFECT_NONE;
    action.animation  = m_PSpell->getAnimationID();
    action.param      = 0;
    action.messageID  = 0;

    m_PEntity->m_ActionList.clear();
    m_PEntity->m_ActionList.push_back(action);

    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(m_PEntity));
    Clear();
}

void CMagicState::FinishSpell()
{
    DSP_DEBUG_BREAK_IF(m_PSpell == NULL);
	DSP_DEBUG_BREAK_IF(m_PEntity->Check_Engagment->GetCurrentAction() != ACTION_MAGIC_FINISH);

    SpendCost(m_PSpell);
    SetRecast(m_PSpell);

	// remove effects based on spell cast first
    int16 effectFlags = EFFECTFLAG_INVISIBLE | EFFECTFLAG_MAGIC_BEGIN;

    if(m_PSpell->canTargetEnemy())
    {
    	effectFlags |= EFFECTFLAG_DETECTABLE;
    }

    m_PEntity->StatusEffectContainer->DelStatusEffectsByFlag(effectFlags);

    m_PTargetFind->reset();
    m_PEntity->m_ActionList.clear();

    // setup special targeting flags
    // can this spell target the dead?

    uint8 flags = FINDFLAGS_NONE;
    if(m_PSpell->getValidTarget() & TARGET_PLAYER_DEAD)
    {
        flags |= FINDFLAGS_DEAD;
    }

    uint8 aoeType = battleutils::GetSpellAoEType(m_PEntity, m_PSpell);

	if (aoeType == SPELLAOE_RADIAL) {
		float distance = spell::GetSpellRadius(m_PSpell, m_PEntity);

        m_PTargetFind->findWithinArea(m_PTarget, AOERADIUS_TARGET, distance, flags);

    }
    else if (aoeType == SPELLAOE_CONAL)
    {
        //TODO: actual radius calculation
        float radius = spell::GetSpellRadius(m_PSpell, m_PEntity);

        m_PTargetFind->findWithinCone(m_PTarget, radius, 45, flags);
	}
	else
	{
		// only add target
		m_PTargetFind->findSingleTarget(m_PTarget, flags);
	}

    uint16 totalTargets = m_PTargetFind->m_targets.size();

	m_PSpell->setTotalTargets(totalTargets);

	apAction_t action;
	action.ActionTarget = m_PTarget;
	action.reaction   = REACTION_NONE;
	action.speceffect = SPECEFFECT_NONE;
	action.animation  = m_PSpell->getAnimationID();
	action.param      = 0;
	action.messageID  = 0;

	uint16 msg = 0;
    int16 ce = 0;
    int16 ve = 0;

	for (std::vector<CBattleEntity*>::iterator it = m_PTargetFind->m_targets.begin() ; it != m_PTargetFind->m_targets.end(); ++it)
	{

        CBattleEntity* PTarget = *it;

        action.ActionTarget = PTarget;

		m_PSpell->resetMessage();
        ce = m_PSpell->getCE();
        ve = m_PSpell->getVE();

		if(m_PEntity->objtype == TYPE_PC)
    	{
			if ((m_PSpell->getID() >= 14 && m_PSpell->getID() <= 20) || m_PSpell->getID() == 94 || m_PSpell->getID() == 95 || m_PSpell->getID() == 143) // Status Ailment Recovery Spells (Divine Benison)
			{
				int16 DivineBenisonEnmityMod = m_PEntity->getMod(MOD_DIVINE_BENISON_ENMITY);
				if(DivineBenisonEnmityMod > 0)
				{
					ce = ce * ((float)(100+DivineBenisonEnmityMod)/100);
					ve = ve * ((float)(100+DivineBenisonEnmityMod)/100);
					// ShowDebug(CL_CYAN"Divine Benison Proc \n");
				}
			}
		}

        // take all shadows
        if(m_PSpell->canTargetEnemy() && aoeType > 0)
        {
        	PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_BLINK);
        	PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_COPY_IMAGE);
        }

        // TODO: this is really hacky and should eventually be moved into lua
        if(m_PSpell->canHitShadow() && aoeType == SPELLAOE_NONE && battleutils::IsAbsorbByShadow(PTarget))
        {
        	// take shadow
        	msg = 31;
        	action.param = 1;
            ve = 0;
            ce = 0;
        }
        else
        {
            action.param = luautils::OnSpellCast(m_PEntity, PTarget, m_PSpell);

            // remove effects from damage
            if (m_PSpell->canTargetEnemy() && action.param > 0 && m_PSpell->dealsDamage())
            {
                PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);
            }

            if(msg == 0)
            {
                msg = m_PSpell->getMessage();
            }
            else
            {
                msg = m_PSpell->getAoEMessage();
            }

            if(!m_PSpell->tookEffect())
            {
                ve = 0;
                ce = 0;
            }

        }

        action.messageID = msg;

        CharOnTarget(&action, ce, ve);

        m_PEntity->m_ActionList.push_back(action);
    }

    CharAfterFinish();

    m_PEntity->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_MAGIC_END);

    DSP_DEBUG_BREAK_IF(m_PEntity->Check_Engagment->GetCurrentAction() != ACTION_MAGIC_FINISH);
	m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(m_PEntity));

	Clear();
}

void CMagicState::CharOnTarget(apAction_t* action, int16 ce, int16 ve)
{
    if(m_PEntity->objtype != TYPE_PC)
    {
        return;
    }

    CBattleEntity* PTarget = action->ActionTarget;

    if (PTarget->objtype == TYPE_MOB)
    {
        if (PTarget->isDead())
        {
            ((CMobEntity*)PTarget)->m_DropItemTime = m_PSpell->getAnimationTime();
        }

        ((CMobEntity*)PTarget)->m_OwnerID.id = m_PEntity->id;
        ((CMobEntity*)PTarget)->m_OwnerID.targid = m_PEntity->targid;

        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TRANQUILITY) && m_PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            m_PEntity->addModifier(MOD_ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_TRANQUILITY)->GetPower());
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_EQUANIMITY) && m_PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            m_PEntity->addModifier(MOD_ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_EQUANIMITY)->GetPower());
        }
        ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity(m_PEntity, ce, ve);
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TRANQUILITY) && m_PSpell->getSpellGroup() == SPELLGROUP_WHITE)
        {
            m_PEntity->delModifier(MOD_ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_TRANQUILITY)->GetPower());
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_TRANQUILITY);
        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_EQUANIMITY) && m_PSpell->getSpellGroup() == SPELLGROUP_BLACK)
        {
            m_PEntity->delModifier(MOD_ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_EQUANIMITY)->GetPower());
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_EQUANIMITY);
        }
    }

    if(action->param > 0 && m_PSpell->dealsDamage() && m_PSpell->getSpellGroup() == SPELLGROUP_BLUE &&
        m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CHAIN_AFFINITY) && ((CBlueSpell*)m_PSpell)->getPrimarySkillchain() != 0)
    {

        SUBEFFECT effect = battleutils::GetSkillChainEffect(PTarget, (CBlueSpell*)m_PSpell);
        if (effect != SUBEFFECT_NONE)
        {
            uint16 skillChainDamage = battleutils::TakeSkillchainDamage(m_PEntity, PTarget, action->param);


            action->addEffectParam = skillChainDamage;
            action->addEffectMessage = 287 + effect;
            action->additionalEffect = effect;

        }
        if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SEKKANOKI) || m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI))
        {
            m_PEntity->health.tp = (m_PEntity->health.tp > 100 ? m_PEntity->health.tp - 100 : 0);
        }
        else
        {
            m_PEntity->health.tp = 0;
        }

        m_PEntity->StatusEffectContainer->DelStatusEffectSilent(EFFECT_CHAIN_AFFINITY);
    }
}

void CMagicState::CharAfterFinish()
{
    if(m_PEntity->objtype != TYPE_PC)
    {
        return;
    }

    CCharEntity* PChar = (CCharEntity*)m_PEntity;

    charutils::RemoveStratagems(PChar, m_PSpell);

    charutils::UpdateHealth(PChar);

    // only skill up if the effect landed
    if(m_PSpell->tookEffect()){
        charutils::TrySkillUP(PChar, (SKILLTYPE)m_PSpell->getSkillType(), m_PTarget->GetMLevel());
    }

    PChar->pushPacket(new CCharUpdatePacket(PChar));

    // make wyvern use breath
    if(PChar->PPet!=NULL && ((CPetEntity*)PChar->PPet)->getPetType() == PETTYPE_WYVERN)
    {
        ((CAIPetDummy*)PChar->PPet->Check_Engagment)->m_MasterCommand = MASTERCOMMAND_HEALING_BREATH;
        PChar->PPet->Check_Engagment->SetCurrentAction(ACTION_MOBABILITY_START);
    }

    SetHiPCLvl(m_PTarget, PChar->GetMLevel());
}

bool CMagicState::TryHitInterrupt(CBattleEntity* PAttacker)
{

    if (!IsCasting() || IsInterrupted() || m_PSpell->getSpellGroup() == SPELLGROUP_SONG)
    {
    	return false;
    }

    if(battleutils::TryInterruptSpell(PAttacker, m_PEntity))
    {
        ForceInterrupt();
        return true;
    }

    return false;
}

bool CMagicState::IsCasting()
{
	return m_PSpell != NULL;
}

bool CMagicState::ValidCharCast(CSpell* PSpell)
{
    CCharEntity* PChar = (CCharEntity*)m_PEntity;

    // has spell and can use it
    int16 spellID = PSpell->getID();

    if (!charutils::hasSpell(PChar, spellID) || !spell::CanUseSpell(PChar, spellID))
    {
        PushError(MSGBASIC_CANNOT_CAST_SPELL, spellID);
        return false;
    }

    // check recast
    if (PChar->PRecastContainer->Has(RECAST_MAGIC, spellID))
    {
        PushError(MSGBASIC_UNABLE_TO_CAST, spellID);
        return false;
    }

    // can use msic
    if (!m_PEntity->loc.zone->CanUseMisc(PSpell->getZoneMisc()))
    {
        PushError(MSGBASIC_CANNOT_USE_IN_AREA, spellID);
        return false;
    }

    // check summoning
    if (PSpell->getSpellGroup() == SPELLGROUP_SUMMONING && PChar->PPet != NULL)
    {
        PushError(MSGBASIC_ALREADY_HAS_A_PET, spellID);
        return false;
    }

    return true;
}

void CMagicState::SpendCost(CSpell* PSpell)
{
    if(m_PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU)
    {
        if(!(m_flags & MAGICFLAGS_IGNORE_TOOLS))
        {
            // handle ninja tools
            battleutils::HasNinjaTool(m_PEntity, PSpell, true);
        }
    }
    else if (PSpell->hasMPCost() && (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT) ||
	!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT)) && !(m_flags & MAGICFLAGS_IGNORE_MP))
    {
        int16 cost = CalculateMPCost(PSpell);

        // conserve mp
        int16 rate = m_PEntity->getMod(MOD_CONSERVE_MP);

        if(rand()%100 < rate)
        {
            cost = ConserveMP(cost);
        }

        m_PEntity->addMP(-cost);
    }

}

int16 CMagicState::ConserveMP(int16 cost)
{
    return cost * ( (float)(rand()%8 + 8.0f) / 16.0f );
}

void CMagicState::SetRecast(CSpell* PSpell)
{

    // only applies to pcs
    if(m_PEntity->objtype != TYPE_PC)
    {
        return;
    }

    CCharEntity* PChar = (CCharEntity*)m_PEntity;

    uint32 RecastTime = 3000;

    if (!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL) ||
	!PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SPONTANEITY))
    {
        RecastTime = CalculateRecastTime(PSpell);
    }

    //needed so the client knows of the reduced recast time!
    PSpell->setModifiedRecast(RecastTime);
    PChar->PRecastContainer->Add(RECAST_MAGIC, PSpell->getID(), RecastTime);
}