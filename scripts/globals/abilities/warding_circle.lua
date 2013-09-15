-----------------------------------
-- Ability: Warding Circle
-- Grants resistance against demons
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
	elseif (player:hasStatusEffect(EFFECT_ANCIENT_CIRCLE)) then
		return MSGBASIC_UNABLE_TO_USE_JA2,0;
	end
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local power = 0;
	local duration = 180;
	local job = player:getMainJob();
	local sjob = player:getSubJob();
	
	if(job == JOB_SAM) then
		power = 15;
	elseif(sjob == JOB_SAM) then
		power = 5
	end
	
	local head = target:getEquipID(SLOT_HEAD);
	if(head == 15236 or head == 13868) then -- Myochin Kabuto / +1
		power = power + 2;
		duration = 270;
	end
	target:addStatusEffect(EFFECT_WARDING_CIRCLE,power,0,duration);
end;
