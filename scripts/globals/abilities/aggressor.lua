-----------------------------------
-- Ability: Aggressor
-- Enhances Accuracy impairs Evasion
-----------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local merit = target:getMerit(MERIT_AGGRESSIVE_AIM);
	local body = target:getEquipID(SLOT_BODY);
	local evaMod = 0;
	local duration = 180;

	if (body == 10670) then -- Warriors Lorica +2
		duration = duration + 10;
		evaMod = 10;
	elseif (body == 14500) then -- Warriors Lorica +1
		evaMod = 10;
	elseif (body == 15087) then -- Warriors Lorica
		evaMod = 5;
	end
	
	player:addStatusEffect(EFFECT_AGGRESSOR,evaMod,0,duration,0,merit);
end;