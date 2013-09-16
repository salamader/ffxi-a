-----------------------------------	
-- Leaden Salute
-- Marksmanship weapon skill	
-- Skill Level: NA
-- Deals darkness elemental damage. Damage varies with TP.
-- Death Penalty: Aftermath effect varies with TP.
-- Aligned with the Shadow, Soil, & Light Gorgets.	
-- Aligned with the Shadow, Soil, & Light Belts.	
-- Element: Darkness	
-- Modifiers: AGI:30%	
-- 100%TP    200%TP    300%TP	
-- 4.00      4.25      4.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 4; params.ftp200 = 4.25; params.ftp300 = 4.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.3; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doRangedWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_RANGED);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 19007) then
		aftermath = 1;
	elseif (main == 19076) then
		aftermath = 1;
	elseif (main == 19096) then
		aftermath = 1;
	elseif (main == 19628) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19726) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19835) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19964) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 120;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19007) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,1,0,duration);
			elseif (main == 19076 or main == 19096 or main == 19628) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,1,0,duration);
			elseif (main == 19726 or main == 19835 or main == 19564) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,16,0,duration);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19007) then
					duration = 90;
					subpower = math.floor(tp / 10);
				elseif (main == 19076 or main == 19096 or main == 19628) then
					duration = 120;
					subpower = math.floor(tp / 10);
				elseif (main == 19726 or main == 19835 or main == 19564) then
					duration = 120;
					subpower = math.floor(tp / 10);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,17,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19007) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif (main == 19076 or main == 19096 or main == 19628) then
						duration = 90;
						subpower = math.floor(tp / 10);
					elseif (main == 19726 or main == 19835 or main == 19564) then
						duration = 90;
						subpower = math.floor(tp / 10);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,16,0,duration,0,subpower);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	