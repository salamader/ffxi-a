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

#include "state.h"
#include "../../entities/battleentity.h"
#include "../../entities/mobentity.h"
#include "../../entities/charentity.h"
#include "../helpers/targetfind.h"

#include "../../packets/action.h"

CState::CState(CBattleEntity* PEntity, CTargetFind* PTargetFind)
{
	DSP_DEBUG_BREAK_IF(PEntity == NULL);
	DSP_DEBUG_BREAK_IF(PTargetFind == NULL);
	m_PEntity = PEntity;
	m_PTargetFind = PTargetFind;
	m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE);

	m_coolTime = COOL_DOWN_TIME;
	m_lastCoolTime = 0;

	Clear();
}

CState::~CState()
{

}

void CState::PushMessage(MSGBASIC_ID msgID, int32 param, int32 value)
{

	CBattleEntity* PTarget = m_PTarget;
	// always need an entity sent
	if(PTarget == NULL)
	{
		PTarget = m_PEntity;
	}

	m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CMessageBasicPacket(m_PEntity,PTarget,param,value,msgID));
	m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE, new CMessageBasicPacket(m_PEntity,PTarget,param,value,msgID));
}

void CState::PushError(MSGBASIC_ID msgID, int32 param, int32 value)
{
	if(m_PEntity->objtype == TYPE_PC)
	{
		CCharEntity* PChar = (CCharEntity*)m_PEntity;

		CBattleEntity* PTarget = m_PTarget;

		// always need an entity sent
		if(PTarget == NULL)
		{
			PTarget = m_PEntity;
		}

		PChar->pushPacket(new CMessageBasicPacket(PChar,PTarget,param,value,msgID));
	}
}

STATESTATUS CState::Update(uint32 tick)
{
	if(m_PEntity->isDead())
	{
		return STATESTATUS_ERROR;
	}

	return STATESTATUS_TICK;
}

bool CState::CheckValidTarget(CBattleEntity* PTarget)
{
	if(PTarget == NULL)
	{
		return false;
	}

    // is owner
    if(!m_PTargetFind->isMobOwner(PTarget))
    {
    	PushError(MSGBASIC_ALREADY_CLAIMED);
    	return false;
    }

    // pc only checks
    if(m_PEntity->objtype == TYPE_PC)
    {
        // assert you cannot target pets for anything
        if(PTarget->PMaster != NULL && PTarget->PMaster->objtype == TYPE_PC)
        {
            // this is someones pet. cannot target
            PushError(MSGBASIC_THAT_SOMEONES_PET);
            return false;
        }

        // act on battlefield targets unless I have it too
        if(PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD) && !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_BATTLEFIELD))
        {
            PushError(MSGBASIC_CANNOT_ON_THAT_TARG);
            return false;
        }
    }


	return !(m_PEntity->loc.zone == NULL || PTarget->getZone() != m_PEntity->getZone() || PTarget->IsNameHidden());
}

void CState::Clear()
{
	m_flags = 0;
	m_PTarget = NULL;
}

CBattleEntity* CState::GetTarget()
{
	return m_PTarget;
}

bool CState::HasMoved()
{
	return floorf(m_startPosition.x * 10 + 0.5) / 10 != floorf(m_PEntity->loc.p.x * 10 + 0.5) / 10 ||
	floorf(m_startPosition.z * 10 + 0.5) / 10 != floorf(m_PEntity->loc.p.z * 10 + 0.5) / 10;
}

bool CState::IsOnCoolDown(uint32 tick)
{
	if(tick - m_lastCoolTime < m_coolTime)
	{
		PushError(MSGBASIC_WAIT_LONGER);
		return true;
	}

	return false;
}

void CState::SetLastCoolTime(uint32 tick)
{
	m_lastCoolTime = tick;
}

void CState::SetCoolDown(uint32 coolDown)
{
	m_coolTime = coolDown;
}

void CState::SetHiPCLvl(CBattleEntity* PTarget, uint8 lvl)
{
    if(PTarget->objtype == TYPE_MOB)
    {
        CMobEntity* Monster = (CMobEntity*)PTarget;
        if (Monster->m_HiPCLvl < lvl)
        {
            Monster->m_HiPCLvl = lvl;
        }
    }
}