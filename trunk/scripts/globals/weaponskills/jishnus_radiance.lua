-----------------------------------  
-- Jishnu's Radiance
-- Archery weapon skill  
-- Skill level: 357  
-- Empyrean Weapon Skill
-- RNG Main Job Required
-- Aligned with the Thunder & Breeze Gorget.  
-- Aligned with the Thunder Belt & Breeze Belt.  
-- Element:
-- Modifiers: DEX:60%
-- 100%TP    200%TP    300%TP  
-- 1.75      1.75      1.75
-----------------------------------  
require("scripts/globals/status");  
require("scripts/globals/settings");  
require("scripts/globals/weaponskills");  
-----------------------------------  

function OnUseWeaponSkill(player, target, wsID)  

	local params = {};
	params.numHits = 3;
	params.ftp100 = 1.75; params.ftp200 = 1.75; params.ftp300 = 1.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.60; params.vit_wsc = 0.0;

	params.agi_wsc = 0.00; params.int_wsc = 0.0; params.mnd_wsc = 0.0;

	params.chr_wsc = 0.0;
	params.crit100 = 0.15; params.crit200 = 0.2; params.crit300 = 0.25;
	params.canCrit = true;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, tpHits, extraHits = doRangedWeaponskill(player, target, params);
	local crticalHit = false;

	local main = player:getEquipID(SLOT_RANGED);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19468) then
		aftermath = 1;
	elseif (main == 19546) then
		aftermath = 1;
	elseif (main == 19644) then
		aftermath = 1;
	elseif (main == 19817) then
		aftermath = 1;
	elseif (main == 19865) then
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

end;