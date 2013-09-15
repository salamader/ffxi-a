-----------------------------------
-- Ability: Troubadour
-- Increases casting time for songs
-- by 1.5 and double effect and 
-- duration
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
    local merits = player:getMerit(MERIT_TROUBADOUR);
    player:addStatusEffect(EFFECT_TROUBADOUR,merits,0,60);
end;
