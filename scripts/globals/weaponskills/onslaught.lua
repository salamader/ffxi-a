-----------------------------------	
-- Onslaught	
-- Axe weapon skill	
-- Skill Level: N/A	
-- Lowers target's params.accuracy. Additional effect: temporarily increases Attack.	
-- Available only when equipped with the Relic Weapons Ogre Killer (Dynamis use only) or Guttler or Cleofun Axe (with Latent active).	
-- These Relic Weapons are only available to Beastmasters, so only they can use this Weapon Skill.	
-- One hit attack despite of non single-hit animation	
-- The attack increase seems to be 10%.	
-- Aligned with the Shadow Gorget & Soil Gorget.	
-- Aligned with the Shadow Belt & Soil Belt.	
-- Element: None	
-- Modifiers: DEX:60%	
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
	params.str_wsc = 0.0; params.dex_wsc = 0.6; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	if damage > 0 then
		local tp = player:getTP();
		local duration = (tp/100 * 20);
		if(target:hasStatusEffect(EFFECT_ACCURACY_DOWN) == false) then
			target:addStatusEffect(EFFECT_ACCURACY_DOWN, 20, 0, duration);
		end
	end
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18288 or sub == 18288) then
		aftermath = 1;
	elseif (main == 18289 or sub == 18289) then
		aftermath = 1;
	elseif (main == 18641 or sub == 18641) then
		aftermath = 1;
	elseif (main == 18655 or sub == 18655) then
		aftermath = 1;
	elseif (main == 18669 or sub == 18669) then
		aftermath = 1;
	elseif (main == 19750 or sub == 19750) then
		aftermath = 1;
	elseif (main == 19843 or sub == 19843) then
		aftermath = 1;
	elseif ((main == 18287 or sub == 18287) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,5,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,5,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,5,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
