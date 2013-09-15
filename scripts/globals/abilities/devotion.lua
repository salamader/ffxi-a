-----------------------------------
-- Ability: Devotion
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	if (player:getHP() > 3) then
		effectPower = player:getHP()/4;
		player:delHP(effectPower);
		target:addMP(effectPower);
	end
end;
