------------------------
--    Dagan     -- 
------------------------
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");

function OnUseWeaponSkill(player, target, wsID)
	local ftphp = fTP(player:getTP(),0.22,0.34,0.52);
	local ftpmp = fTP(player:getTP(),0.15,0.25,0.35);
	player:addHP(ftphp*player:getMaxHP());
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19466 or sub == 19466) then
		aftermath = 1;
	elseif (main == 19544 or sub == 19544) then
		aftermath = 1;
	elseif (main == 19642 or sub == 19642) then
		aftermath = 1;
	elseif (main == 19815 or sub == 19815) then
		aftermath = 1;
	elseif (main == 19863 or sub == 19863) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 90;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,1,0,duration);
		elseif (tp >= 200) then
			duration = 60;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,1,0,duration);
			end
		else
			duration = 30;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,1,0,duration);
				end
			end
		end
	end
	
	return 0, 0, false, (ftpmp*player:getMaxMP());
end
