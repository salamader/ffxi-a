-----------------------------------	
-- Metatron Torment	
-- Hand-to-Hand Skill level: 5 Description: Delivers a threefold attack. Damage varies wit weapon skill	
-- Great Axe Weapon Skill	
-- Skill Level: N/A	
-- Lowers target's defense. Additional effect: temporarily lowers damage taken from enemies.	
-- Defense Down effect is 18.5%, 1 minute duration.	
-- Damage reduced is 20.4% or 52/256.	
-- Lasts 20 seconds at 100TP, 40 seconds at 200TP and 60 seconds at 300TP.	
-- Available only when equipped with the Relic Weapons Abaddon Killer (Dynamis use only) or Bravura.	
-- Also available as a Latent effect on Barbarus Bhuj	
-- Since these Relic Weapons are only available to Warriors, only Warriors may use this Weapon Skill.	
-- Aligned with the Flame Gorget & Light Gorget.	
-- Aligned with the Flame Belt & Light Belt.	
-- Element: None	
-- Modifiers: STR:60%	
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
	params.str_wsc = 0.6; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	if damage > 0 and (target:hasStatusEffect(EFFECT_DEFENSE_DOWN) == false) then
		target:addStatusEffect(EFFECT_DEFENSE_DOWN, 18.5, 0, 120);
	end

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18294) then
		aftermath = 1;
	elseif (main == 18295) then
		aftermath = 1;
	elseif (main == 18642) then
		aftermath = 1;
	elseif (main == 18656) then
		aftermath = 1;
	elseif (main == 18670) then
		aftermath = 1;
	elseif (main == 19751) then
		aftermath = 1;
	elseif (main == 19844) then
		aftermath = 1;
	elseif ((main == 18293) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,6,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,6,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,6,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
