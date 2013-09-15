-----------------------------------	
-- Catastrophe	
-- Scythe weapon skill	
-- Skill Level: N/A	
-- Drain target's HP. Bec de Faucon/Apocalypse: Additional effect: Haste	
-- This weapon skill is available with the stage 5 relic Scythe Apocalypse or within Dynamis with the stage 4 Bec de Faucon.	
-- Also available without Aftermath effects with the Crisis Scythe. After 13 weapon skills have been used successfully, gives one "charge" of Catastrophe.	
-- Aligned with the Shadow Gorget & Soil Gorget.	
-- Aligned with the Shadow Belt & Soil Belt.	
-- Element: None	
-- Modifiers: INT:40% ; AGI:40%	
-- 100%TP    200%TP    300%TP	
-- 2.75      2.75      2.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 2.75; params.ftp200 = 2.75; params.ftp300 = 2.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.4; params.int_wsc = 0.4; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	local drain = (damage * 0.4);
	player:addHP(drain);

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18306) then
		aftermath = 1;
	elseif (main == 18307) then
		aftermath = 1;
	elseif (main == 18644) then
		aftermath = 1;
	elseif (main == 18658) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18672) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19753) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19846) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18305) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,7,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,7,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,7,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
