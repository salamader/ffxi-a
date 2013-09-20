-----------------------------------
-- Ability: Saboteur
-- Enhances the next enfeebling magic
-- spell's effect and duration.
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
	player:addStatusEffect(EFFECT_SABOTEUR,1,0,60);
end;