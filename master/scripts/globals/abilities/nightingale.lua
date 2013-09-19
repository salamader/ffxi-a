-----------------------------------
-- Ability: Nightingale
-- Halves recast times of songs.
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
    local merits = player:getMerit(MERIT_NIGHTINGALE);
    player:addStatusEffect(EFFECT_NIGHTINGALE,merits,0,60);
end;
