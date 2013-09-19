-----------------------------------	
-- Expiacion
-- Sword weapon skill
-- Skill level: NA
-- Tizona: Aftermath effect varies with TP. 
-- In order to obtain Expiacion, the quest Unlocking a Myth must be completed. 
-- Description: Delivers a twofold attack.
-- Aligned with the Aqua Gorget, Snow Gorget & Soil Gorget. 
-- Aligned with the Aqua Belt, Snow Belt & Soil Belt. 
-- Element: None	
-- Modifiers: STR:30% INT:30%
-- 100%TP    200%TP    300%TP	
-- 1.5        2.0       2.5
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 1.5; params.ftp200 = 2.0; params.ftp300 = 2.5;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.3; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 19006 or sub == 19006) then
		aftermath = 1;
	elseif (main == 19075 or sub == 19075) then
		aftermath = 1;
	elseif (main == 19095 or sub == 19095) then
		aftermath = 1;
	elseif (main == 19627 or sub == 19627) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19725 or sub == 19725) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19834 or sub == 19834) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19963 or sub == 19963) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19006 or sub == 19006) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19075 or sub == 19075) or (main == 19095 or sub == 19095) or (main == 19627  or sub == 19627)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19725 or sub == 19725) or (main == 19834 or sub == 19834) or (main == 19963 or sub == 19963)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19006 or sub == 19006) then
					duration = 180;
					subpower = math.floor(tp / 10);
				elseif ((main == 19075 or sub == 19075) or (main == 19095 or sub == 19095) or (main == 19627  or sub == 19627)) then
					duration = 270;
					subpower = math.floor(tp / 10);
				elseif ((main == 19725 or sub == 19725) or (main == 19834 or sub == 19834) or (main == 19963 or sub == 19963)) then
					duration = 270;
					subpower = math.floor(tp / 10);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,18,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19006 or sub == 19006) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif ((main == 19075 or sub == 19075) or (main == 19095 or sub == 19095) or (main == 19627  or sub == 19627)) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif ((main == 19725 or sub == 19725) or (main == 19834 or sub == 19834) or (main == 19963 or sub == 19963)) then
						duration = 90;
						subpower = math.floor((tp / 10) + 20);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,14,0,duration,0,subpower);
				end
			end
		end
	end

	return tpHits, extraHits, criticalHit, damage;
end	
