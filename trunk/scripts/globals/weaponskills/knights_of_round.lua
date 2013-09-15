-----------------------------------	
-- Knights Of Round	
-- Scythe Skill Level: 200 Description: Delivers a four-hit attack. Silences enemy. Durati weapon skill	
-- Sword Weapon Skill	
-- Skill Level: N/A	
-- Caliburn/Excalibur: Additional Effect: Regen.	
-- Regen 10HP/Tick, duration varies with TP.	
-- Available only when equipped with the Relic Weapons Caliburn (Dynamis use only) or Excalibur.	
-- Also available without aftermath as a latent effect on Corbenic Sword.	
-- Aligned with the Flame Gorget & Light Gorget.	
-- Aligned with the Flame Belt & Light Belt.	
-- Element: None	
-- Modifiers: STR:40% ; MND:40%	
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
	params.str_wsc = 0.4; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.4; params.chr_wsc = 0.0;
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
	local zone = player:getZone();
	
	if (main == 18276 or sub == 18276) then
		aftermath = 1;
	elseif (main == 18277 or sub == 18277) then
		aftermath = 1;
	elseif (main == 18639 or sub == 18639) then
		aftermath = 1;
	elseif (main == 18653 or sub == 18653) then
		aftermath = 1;
	elseif (main == 18667 or sub == 18667) then
		aftermath = 1;
	elseif (main == 19748 or sub == 19748) then
		aftermath = 1;
	elseif (main == 19841 or sub == 19841) then
		aftermath = 1;
	elseif ((main == 18275 or sub == 18275) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,4,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,4,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,4,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
