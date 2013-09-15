-----------------------------------
-- Ability: Rampart
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
	duration = 30;
	local head = player:getEquipID(SLOT_HEAD);
	local pEquipMods = 0;
	
	-- Equipment Bonus
	if (head == 15078) then -- Valor Coronet
	pEquipMods = 15;
	elseif (head == 15251) then -- Valor Coronet +1
	pEquipMods = 20;
	elseif (head == 10656) then -- Valor Coronet +2
	pEquipMods = 25;
	end
	
	duration = duration + pEquipMods
	
	target:addStatusEffect(EFFECT_MAGIC_SHIELD,1,0,duration);
end;
