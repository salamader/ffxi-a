-----------------------------------	
-- Scourge	
-- Great Sword weapon skill	
-- Skill level: N/A	
-- Additional effect: temporarily improves params.critical hit rate.	
-- params.critical hit rate boost duration is based on TP when the weapon skill is used. 100% TP will give 20 seconds of params.critical hit rate boost; this scales linearly to 60 seconds of params.critical hit rate boost at 300% TP. 5 TP = 1 Second of Aftermath.	
-- Parses show the params.critical hit rate increase from the Scourge Aftermath is between 10% and 15%.	
-- This weapon skill is only available with the stage 5 relic Great Sword Ragnarok or within Dynamis with the stage 4 Valhalla.	
-- Aligned with the Light Gorget & Flame Gorget.	
-- Aligned with the Light Belt & Flame Belt.	
-- Element: None	
-- Modifiers: MND:40% ; CHR:40%	
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
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.4; params.chr_wsc = 0.4;
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
	
	if (main == 18282) then
		aftermath = 1;
	elseif (main == 18283) then
		aftermath = 1;
	elseif (main == 18640) then
		aftermath = 1;
	elseif (main == 18654) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18668) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19749) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19842) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18281) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,3,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,3,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,3,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
