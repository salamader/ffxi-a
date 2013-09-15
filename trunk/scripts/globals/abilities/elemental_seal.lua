-----------------------------------
-- Ability: Elemental Seal
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
	if(player:hasStatusEffect(EFFECT_DIVINE_EMBLEM) == true) then
		player:delStatusEffect(EFFECT_DIVINE_EMBLEM);
	end
	player:addStatusEffect(EFFECT_ELEMENTAL_SEAL,1,0,60);
end;
