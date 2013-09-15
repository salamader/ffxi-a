-----------------------------------
-- Ability: Spontaneity
-- Reduces casting time of the next
-- magic spell the target casts.
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)

	if(player:hasStatusEffect(EFFECT_MANAWELL) == true) then
		return MSGBASIC_UNABLE_TO_USE_JA,0;
	else
		return 0,0;
	end
end;

function OnUseAbility(player, target, ability)

	player:addStatusEffect(EFFECT_SPONTANEITY,1,0,60);
end;
