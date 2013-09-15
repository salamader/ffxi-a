-----------------------------------	
-- Gate Of Tartarus	
-- Staff weapon skill	
-- Skill Level: N/A	
-- Lowers target's attack. Additional effect: Refresh	
-- Refresh effect is 8mp/tick for 20 sec per 100 TP.	
-- Available only when equipped with the Relic Weapons Thyrus (Dynamis use only) and Claustrum, or the Chthonic Staff once the Latent Effect has been activated.	
-- These Relic Weapons are only available to Black Mages and Summoners. As such, only these jobs may use this Weapon Skill.	
-- Aligned with the Aqua Gorget & Snow Gorget.	
-- Aligned with the Aqua Belt & Snow Belt.	
-- Element: None	
-- Modifiers: CHR:60%	
-- 100%TP    200%TP    300%TP	
-- 3.00      3.00      3.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 3; params.ftp200 = 3; params.ftp300 = 3;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.6;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18330) then
		aftermath = 1;
	elseif (main == 18331) then
		aftermath = 1;
	elseif (main == 18648) then
		aftermath = 1;
	elseif (main == 18662) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18676) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19757) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19850) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18329) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,11,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,11,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,11,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
