-----------------------------------
-- Ability: Arcane Circle
-- Grants resistance against arcana
-- to party members within AoE.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
		-- Only 1 Circle may be active at any given time.
		if (player:hasStatusEffect(EFFECT_ANCIENT_CIRCLE)) then
			return MSGBASIC_UNABLE_TO_USE_JA2,0;
		elseif (player:hasStatusEffect(EFFECT_HOLY_CIRCLE)) then
			return MSGBASIC_UNABLE_TO_USE_JA2,0;
		elseif (player:hasStatusEffect(EFFECT_WARDING_CIRCLE)) then
			return MSGBASIC_UNABLE_TO_USE_JA2,0;
	end
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local power = 0;
	local duration = 180;
	local job = player:getMainJob();
	local sjob = player:getSubJob();
	
	if(job == JOB_DRK) then
		power = 15;
	elseif(sjob == JOB_DRK) then
		power = 5
	end
	
	local feet = target:getEquipID(SLOT_FEET);
	if(feet == 14096 or feet == 15359) then -- Chaos Sollerets / +1
		power = power + 2;
		duration = 270;
	end
	
	target:addStatusEffect(EFFECT_ARCANE_CIRCLE,power,0,duration);
end;
