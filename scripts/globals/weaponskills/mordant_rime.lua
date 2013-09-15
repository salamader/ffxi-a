-----------------------------------     
-- Mordant Rime
-- Dagger weapon skill  
-- Skill level: N/A
-- Description: Delivers a twofold attack that decreases target's movement speed. Chance of decreasing movement speed varies with TP. Carnwenhan: Aftermath effect varies with TP.
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt. 
-- Element: None
-- Skillchain Properties: Fragmentation/Distortion
-- Modifiers: DEX:30% ; CHR:50%
--
-- Damage Multipliers by TP:
-- 100%TP	200%TP	300%TP
-- 3.0	    3.0	    3.0
--
-- Skillchain Properties: Fragmentation/Distortion
-----------------------------------             
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     
        
function OnUseWeaponSkill(player, target, wsID) 
        
	local params = {};
	params.numHits = 2;
	params.ftp100 = 3; params.ftp200 = 3; params.ftp300 = 3;
	params.str_wsc = 0.0; params.dex_wsc = 0.3; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.5;
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
	local subpower = 0;
	
	if (main == 19000 or sub == 19000) then
		aftermath = 1;
	elseif (main == 19069 or sub == 19069) then
		aftermath = 1;
	elseif (main == 19089 or sub == 19089) then
		aftermath = 1;
	elseif (main == 19621 or sub == 19621) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19719 or sub == 19719) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19828 or sub == 19828) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19957 or sub == 19957) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19000 or sub == 19000) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19069 or sub == 19069) or (main == 19089 or sub == 19089) or (main == 19621  or sub == 19621)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19719 or sub == 19719) or (main == 19828 or sub == 19828) or (main == 19957 or sub == 19957)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19000 or sub == 19000) then
					duration = 90;
					subpower = math.floor((tp / 10) - 10);
				elseif ((main == 19069 or sub == 19069) or (main == 19089 or sub == 19089) or (main == 19621  or sub == 19621)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 20) - 15);
				elseif ((main == 19719 or sub == 19719) or (main == 19828 or sub == 19828) or (main == 19957 or sub == 19957)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 20) - 15);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,15,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19000 or sub == 19000) then
						duration = 180;
						subpower = math.floor(tp / 10);
					elseif ((main == 19069 or sub == 19069) or (main == 19089 or sub == 19089) or (main == 19621  or sub == 19621)) then
						duration = 270;
						subpower = math.floor(tp / 10);
					elseif ((main == 19719 or sub == 19719) or (main == 19828 or sub == 19828) or (main == 19957 or sub == 19957)) then
						duration = 270;
						subpower = math.floor(tp / 10);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,15,0,duration,0,subpower);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
        
end     