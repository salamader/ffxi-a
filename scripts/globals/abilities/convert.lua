-----------------------------------
-- Ability: Convert
-- Swaps current HP with MP
--
-- At 0 MP this ability will not activate, as it would cause a self-KO. 
-- Instead, a message stating "Player cannot perform that action" will be received. 
-- In the past, the ability would still activate, but it would have no effect.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local MP = player:getMP();
	local HP = player:getHP();
	if (MP > 0) then
		-- Murgleis sword augments Convert.
		if ((player:getEquipID(SLOT_MAIN) == 18995 or player:getEquipID(SLOT_SUB) == 18995) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 2;
		elseif ((player:getEquipID(SLOT_MAIN) == 19064 or player:getEquipID(SLOT_SUB) == 19064) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 2;
		elseif ((player:getEquipID(SLOT_MAIN) == 19084 or player:getEquipID(SLOT_SUB) == 19084) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 2;
		elseif ((player:getEquipID(SLOT_MAIN) == 19616 or player:getEquipID(SLOT_SUB) == 19616) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 2;
		elseif ((player:getEquipID(SLOT_MAIN) == 19714 or player:getEquipID(SLOT_SUB) == 19714) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 2;
		elseif ((player:getEquipID(SLOT_MAIN) == 19823 or player:getEquipID(SLOT_SUB) == 19823) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 3;
		elseif ((player:getEquipID(SLOT_MAIN) == 19952 or player:getEquipID(SLOT_SUB) == 19952) and (HP > (player:getMaxHP()/2))) then
			HP = HP * 3;
		end
		player:setHP(MP);
		player:setMP(HP);
	end
end;