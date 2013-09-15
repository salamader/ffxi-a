-----------------------------------
-- Ability: Dark Seal
-- Enhances acc of your next magic
-- spell. Each merit after 1st
-- reduces Dark Mag casting time
-- by 10%.
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

	local merits = player:getMerit(MERIT_DARK_SEAL);
	player:addStatusEffect(EFFECT_DARK_SEAL,merits,0,60);
end;
