-----------------------------------
-- Ability: Counterstance
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
    local power = 50;

	target:delStatusEffect(EFFECT_COUNTERSTANCE); --if not found this will do nothing
	target:addStatusEffect(EFFECT_COUNTERSTANCE,power,0,300);
end;
