-----------------------------------	
-- Primal Rend	
-- Axe weapon skill	
-- Skill Level: N/A	
-- Deals light elemental damage. Damage varies with TP. Aymur: Aftermath effect varies with TP.	
-- Available only after completing the Unlocking a Myth (Beastmaster) quest.	
-- Aligned with the Shadow Gorget, Soil Gorget & Aqua Gorget.	
-- Aligned with the Shadow Belt, Soil Belt & Aqua Belt.	
-- Element: Light	
-- Modifiers: CHR:30%	
-- 100%TP    200%TP    300%TP	
-- 4.00      4.25      4.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 4; params.ftp200 = 4.25; params.ftp300 = 4.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.3;
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
	
	if (main == 18999 or sub == 18999) then
		aftermath = 1;
	elseif (main == 19068 or sub == 19068) then
		aftermath = 1;
	elseif (main == 19088 or sub == 19088) then
		aftermath = 1;
	elseif (main == 19620 or sub == 19620) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19718 or sub == 19718) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19827 or sub == 19827) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19956 or sub == 19956) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18999 or sub == 18999) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19068 or sub == 19068) or (main == 19088 or sub == 19088) or (main == 19620  or sub == 19620)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19718 or sub == 19718) or (main == 19827 or sub == 19827) or (main == 19956 or sub == 19956)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18999 or sub == 18999) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif ((main == 19068 or sub == 19068) or (main == 19088 or sub == 19088) or (main == 19620  or sub == 19620)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif ((main == 19718 or sub == 19718) or (main == 19827 or sub == 19827) or (main == 19956 or sub == 19956)) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18999 or sub == 18999) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif ((main == 19068 or sub == 19068) or (main == 19088 or sub == 19088) or (main == 19620  or sub == 19620)) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif ((main == 19718 or sub == 19718) or (main == 19827 or sub == 19827) or (main == 19956 or sub == 19956)) then
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
