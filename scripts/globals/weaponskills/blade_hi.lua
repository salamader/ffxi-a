-----------------------------------     
-- Blade HI    
-- Katana weapon skill  
-- Skill level: N/A
-- Description: Deals quadruple damage. Chance of params.critical hit varies with TP. Kannagi: Aftermath.
-- Available only when equipped with Kannagi (85)/(90)/(95)/(99) or Tobi +1/+2/+3.
-- Aligned with the Shadow Gorget & Soil Gorget.
-- Aligned with the Shadow Belt & Soil Belt.
-- Element: None        
-- Modifiers: AGI:60% 
-- Skillchain Properties: Darkness/Gravitation
-- 100%TP    200%TP    300%TP   
-- 4.00      4.00      4.00   
--
-- params.critical Hit Rate by TP:
-- 100%TP    200%TP    300%TP
-- 15%	     20%       25%
--
-----------------------------------        
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     
        
function OnUseWeaponSkill(player, target, wsID) 
        
	local params = {};
	params.numHits = 1;
	params.ftp100 = 4; params.ftp200 = 4; params.ftp300 = 4;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.6; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.15; params.crit200 = 0.2; params.crit300 = 0.25;
	params.canCrit = true;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);        

	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19464 or sub == 19464) then
		aftermath = 1;
	elseif (main == 19542 or sub == 19542) then
		aftermath = 1;
	elseif (main == 19640 or sub == 19640) then
		aftermath = 1;
	elseif (main == 19813 or sub == 19813) then
		aftermath = 1;
	elseif (main == 19861 or sub == 19861) then
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