-----------------------------------     
-- Victory Smite
-- Hand-to-Hand Weapon Skill
-- Skill Level: N/A
-- Description: Delivers a fourfold attack. Chance of params.critical hit varies with TP.
-- Must have Verethragna (85)/(90)/(95)/(99)/(99-2) or Revenant Fists +1/+2/+3 equipped.
-- Aligned with the Light Gorget, Breeze Gorget & Thunder Gorget.
-- Aligned with the Light Belt, Breeze Belt & Thunder Belt.    
-- Element: None
-- Skillchain Properties: Light, Fragmentation
-- Modifiers: STR:60%
-- Damage Multipliers by TP:
-- 100%TP	200%TP	300%TP
-- 2.25		2.25	2.25
-- params.critical Chance added with TP:
-- 100%TP	200%TP	300%TP
-- 10%		25%		45%
--
-----------------------------------     
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     
        
function OnUseWeaponSkill(player, target, wsID) 
        
	local params = {};
	params.numHits = 4;
	params.ftp100 = 2.25; params.ftp200 = 2.25; params.ftp300 = 2.25;
	params.str_wsc = 0.6; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.1; params.crit200 = 0.25; params.crit300 = 0.45;
	params.canCrit = true;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19456) then
		aftermath = 1;
	elseif (main == 19534) then
		aftermath = 1;
	elseif (main == 19632) then
		aftermath = 1;
	elseif (main == 19805) then
		aftermath = 1;
	elseif (main == 19853) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 90;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,1,0,duration);
		elseif (tp >= 200) then
			duration = 60;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,1,0,duration);
			end
		else
			duration = 30;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,1,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
end     