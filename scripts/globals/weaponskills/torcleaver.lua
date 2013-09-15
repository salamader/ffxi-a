-----------------------------------     
-- Torcleaver
-- Skill Level: N/A
-- Description: Deals triple damage. Damage varies with TP. Caladbolg: Aftermath.
-- Available only when equipped with Caladbolg (85)/(90)/(95) or Espafut +1/+2/+3.
-- Aligned with the Light Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Light Belt, Aqua Belt & Snow Belt.
-- Element: None
-- Skillchain Properties: Light/Distortion
-- Modifiers: VIT:60%
-- Damage Multipliers by TP:
-- 100%TP	200%TP	300%TP
-- 4.75	    5.75	6.5

-----------------------------------        
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     

function OnUseWeaponSkill(player, target, wsID) 
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 4.75; params.ftp200 = 5.75; params.ftp300 = 6.5;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.6; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.00; params.crit200 = 0.00; params.crit300 = 0.00;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	
	if (main == 19459) then
		aftermath = 1;
	elseif (main == 19537) then
		aftermath = 1;
	elseif (main == 19635) then
		aftermath = 1;
	elseif (main == 19808) then
		aftermath = 1;
	elseif (main == 19856) then
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