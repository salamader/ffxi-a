------------------------
--    Myrkr     -- 
------------------------
require("scripts/globals/status");
require("scripts/globals/settings");
require("scripts/globals/weaponskills");

function OnUseWeaponSkill(player, target, wsID)
	local ftpmp = fTP(player:getTP(),0.2,0.4,0.6);
	
	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19467) then
		aftermath = 1;
	elseif (main == 19545) then
		aftermath = 1;
	elseif (main == 19643) then
		aftermath = 1;
	elseif (main == 19816) then
		aftermath = 1;
	elseif (main == 19864) then
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
	
	return 1, 0, false, (ftpmp*player:getMaxMP());
end
