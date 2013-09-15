-----------------------------------	
-- Randgrith	
-- Club weapon skill	
-- Skill level: N/A	
-- Lowers target's evasion. Gullintani/Mjollnir: Temporarily improves params.accuracy.	
-- Available only when equipped with the Relic Weapons Gullintani (Dynamis use only), Mjollnir, or a Charged Molva Maul.	
-- Aftermath: Adds +20 params.accuracy after the weapon skill is used, duration is determined by TP. Only available with Gullintani and Mjollnir.	
-- 100% = 20 seconds, 200% = 40 seconds, 300% = 60 seconds.	
-- This Relic Weapon is only available to White Mages; Scholars must use the Molva Maul to acquire this weapon skill.	
-- Shield Break effect : Evasion -32	
-- Aligned with the Breeze Gorget & Thunder Gorget.	
-- Aligned with the Breeze Belt & Thunder Belt.	
-- Element: None	
-- Modifiers: STR:40% ; MND:40%	
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
	params.str_wsc = 0.4; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.4; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 and (target:hasStatusEffect(EFFECT_WEIGHT) == false) then
		target:addStatusEffect(EFFECT_WEIGHT, 50, 0, 60);
	end

	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18324 or sub == 18324) then
		aftermath = 1;
	elseif (main == 18325 or sub == 18325) then
		aftermath = 1;
	elseif (main == 18647 or sub == 18647) then
		aftermath = 1;
	elseif (main == 18661 or sub == 18661) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18675 or sub == 18675) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19756 or sub == 19756) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19849 or sub == 19849) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18323 or sub == 18323) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,10,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,10,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,10,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
