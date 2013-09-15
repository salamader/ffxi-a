-----------------------------------
-- Ability: Trance
-- Lowers Cost of Dances and Steps to 0
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
	player:addStatusEffect(EFFECT_TRANCE,1,0,60);
end;