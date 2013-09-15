-----------------------------------     
-- Rudra's Storm
-- Dagger weapon skill  
-- Skill level: N/A
-- Deals triple damage and weighs target down (duration: 60s). Damage varies with TP.
-- Aligned with the Aqua Gorget, Snow Gorget & Shadow Gorget.
-- Aligned with the Aqua Belt, Snow Belt & Shadow Belt.       
-- Element: None        
-- Modifiers: DEX:60% 
-- 100%TP    200%TP    300%TP   
-- 3.25      4.25      5.25     
-----------------------------------     
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     

function OnUseWeaponSkill(player, target, wsID) 
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 3.25; params.ftp200 = 4.25; params.ftp300 = 5.25;
	params.str_wsc = 0.0; params.dex_wsc = 0.6; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
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
	
	if (main == 19457 or sub == 19457) then
		aftermath = 1;
	elseif (main == 19535 or sub == 19535) then
		aftermath = 1;
	elseif (main == 19633 or sub == 19633) then
		aftermath = 1;
	elseif (main == 19806 or sub == 19806) then
		aftermath = 1;
	elseif (main == 19854 or sub == 19854) then
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