-----------------------------------	
-- Tachi: Fudo	
-- Great Katana weapon skill	
-- Skill Level: N/A	
-- Deals double damage. Damage varies with TP. Masamune: Aftermath.	
-- Available only when equipped with Masamune (85), Masamune (90), Masamune (95), Hiradennotachi +1 or Hiradennotachi +2.
-- Aligned with Light Gorget, Snow Gorget & Aqua Gorget.	
-- Aligned with Light Belt, Snow Belt & Aqua Belt. 	
-- Element: None	
-- Modifiers: STR:60%	
-- 100%TP    200%TP    300%TP	
-- 3.75      4.75      5.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 3.75; params.ftp200 = 4.75; params.ftp300 = 5.75;
	params.str_wsc = 0.60; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 2;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19465) then
		aftermath = 1;
	elseif (main == 19543) then
		aftermath = 1;
	elseif (main == 19641) then
		aftermath = 1;
	elseif (main == 19814) then
		aftermath = 1;
	elseif (main == 19862) then
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
