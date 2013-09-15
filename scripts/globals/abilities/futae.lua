-----------------------------------
-- Ability: Futae
-- 50% Bonus to Ninjutsu Dmg
-- Expends 2 ninja tools.
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local mabBonus = 0;
	local hands = player:getEquipID(SLOT_HANDS);
	if (hands == 11216) then
		mabBonus = 5;
	elseif(hands == 11116) then
		mabBonus = 10;
	end
	player:addStatusEffect(EFFECT_FUTAE,50,0,60,0,mabBonus);
end;
