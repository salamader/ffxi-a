-----------------------------------	
-- Stringing Pummel
-- Hand-to-Hand weapon skill	
-- Skill Level: NA
-- Delivers an sixfold attack. Chance of critical varies with TP. 
-- Kenkonken:Aftermath effect varies with TP.
-- In order to obtain Stringing Pummel, the quest Unlocking a Myth must be completed.	
-- Aligned with the Shadow Gorget, Soil Gorget & Flame Gorget.	
-- Aligned with the Shadow Belt, Soil Belt & Flame Belt.	
-- Element: None	
-- Modifiers: STR:32% ; VIT:32%	
-- 100%TP    200%TP    300%TP	
-- 0.75      0.75      0.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 6;
	params.ftp100 = 0.75; params.ftp200 = 0.75; params.ftp300 = 0.75;
	params.str_wsc = 0.32; params.dex_wsc = 0.0; params.vit_wsc = 0.32; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.2; params.crit200 = 0.3; params.crit300 = 0.45;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 19008) then
		aftermath = 1;
	elseif (main == 19077) then
		aftermath = 1;
	elseif (main == 19097) then
		aftermath = 1;
	elseif (main == 19629) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19727) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19836) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19965) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19008) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif (main == 19077 or main == 19097 or main == 19629) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif (main == 19727 or main == 19836 or main == 19965) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19008) then
					duration = 180;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif (main == 19077 or main == 19097 or main == 19629) then
					duration = 270;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif (main == 19727 or main == 19836 or main == 19965) then
					duration = 270;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19008) then
						duration = 180;
						subpower = math.floor(tp / 10);
					elseif (main == 19077 or main == 19097 or main == 19629) then
						duration = 270;
						subpower = math.floor(3 * (tp / 20));
					elseif (main == 19727 or main == 19836 or main == 19965) then
						duration = 270;
						subpower = math.floor((tp / 10) + 20);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,14,0,duration,0,subpower);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
