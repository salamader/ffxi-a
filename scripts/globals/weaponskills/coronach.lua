-----------------------------------	
-- Coronach	
-- Marksmanship weapon skill	
-- Skill Level: NA
-- Delivers a ranged attack weaponskill. Additional effect temporarily lowers enmity.
-- Aligned with the Breeze Gorget & Thunder Gorget.	
-- Aligned with the Breeze Belt & Thunder Belt.	
-- Element: None	
-- Modifiers: DEX:40% AGI:40%	
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
	params.str_wsc = 0.0; params.dex_wsc = 0.4; params.vit_wsc = 0.0; params.agi_wsc = 0.4; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 2;

	local damage, tpHits, extraHits = doRangedWeaponskill(player, target, params);
	local crticalHit = false;

	local main = player:getEquipID(SLOT_RANGED);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18336) then
		aftermath = 1;
	elseif (main == 18337) then
		aftermath = 1;
	elseif (main == 18649) then
		aftermath = 1;
	elseif (main == 18663) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18677) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19758) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19851) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18335) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,12,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,12,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,12,0,duration);
				end
			end
		end
	end

	return tpHits, extraHits, criticalHit, damage;

end;
