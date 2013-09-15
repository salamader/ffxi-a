-----------------------------------
-- Ability: Ancient Circle
-- Grants resistance against dragons
-- to party members within AoE.
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	-- Only 1 Circle may be active at any given time.
	if (player:hasStatusEffect(EFFECT_ARCANE_CIRCLE)) then
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
	
	if(job == JOB_DRG) then
		power = 15;
	elseif(sjob == JOB_DRG) then
		power = 5
	end

	local legs = target:getEquipID(SLOT_LEGS);
	if(legs == 14227 or legs == 15574) then -- Drachen Brais / +1
		power = power + 2;
		duration = 270;
	end
	
	target:addStatusEffect(EFFECT_ANCIENT_CIRCLE,power,0,duration);
end;
