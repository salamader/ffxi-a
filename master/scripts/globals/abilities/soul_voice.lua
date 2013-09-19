-----------------------------------
-- 	Soul Voice
-- 	Enhances the effect of songs.
--
--	Actually doubles the effect of songs.
-----------------------------------
 
function OnAbilityCheck(player,target,ability)
	return 0,0;
end;
 
require("scripts/globals/settings");
require("scripts/globals/status");

function OnUseAbility(player, target, ability)
	target:addStatusEffect(EFFECT_SOUL_VOICE,1,0,180);
end;