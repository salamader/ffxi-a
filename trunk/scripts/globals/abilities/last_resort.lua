-----------------------------------
-- Ability: Last Resort
-- Enhances attacks - weakens defense
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
	local defMod = 0;
	local merit = player:getMerit(MERIT_LAST_RESORT_EFFECT);
	local feet = player:getEquipID(SLOT_FEET);
	if(feet == 10737 or feet == 15672 or feet == 15139) then
		defMod = defMod + 10;
	end
	player:addStatusEffect(EFFECT_LAST_RESORT,player:getMerit(MERIT_DESPERATE_BLOWS),0,180,0,merit,defMod);
end;