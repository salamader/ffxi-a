-----------------------------------	
-- Tachi Rana	
-- Great Katana weapon skill	
-- Skill Level: N/A	
-- Delivers a three-fold attack. params.accuracy varies with TP. Aftermath effect varies with TP. See Kogarasumaru.	
-- In order to obtain Tachi: Rana, the Unlocking a Myth (Samurai) quest must be completed.	
-- Will stack with Sneak Attack (first hit only).	
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.	
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.	
-- Element: None	
-- Modifiers: STR:35%	
-- 100%TP    200%TP    300%TP	
-- 1.00      1.00      1.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 3;
	params.ftp100 = 1; params.ftp200 = 1; params.ftp300 = 1;
	params.str_wsc = 0.35; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 19002) then
		aftermath = 1;
	elseif (main == 19071) then
		aftermath = 1;
	elseif (main == 19091) then
		aftermath = 1;
	elseif (main == 19623) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19721) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19830) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19959) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19002) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif (main == 19071 or main == 19091 or main == 19623) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif (main == 19721 or main == 19830 or main == 19959) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19002) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif (main == 19071 or main == 19091 or main == 19623) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif (main == 19721 or main == 19830 or main == 19959) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19002) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif (main == 19071 or main == 19091 or main == 19623) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif (main == 19721 or main == 19830 or main == 19959) then
						duration = 90;
						subpower = math.floor((tp / 10) + 20);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,14,0,duration,0,subpower);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
