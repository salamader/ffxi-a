-----------------------------------
-- Ability: Issekigan
-- Increases chance of payying and
-- gives an enmity bonus upon
-- successful parry.
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
	player:addStatusEffect(EFFECT_ISSEKIGAN,20,0,60);
end;
