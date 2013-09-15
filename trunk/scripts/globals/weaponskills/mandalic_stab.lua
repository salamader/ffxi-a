-----------------------------------	
-- Mandalic Stab	
-- Dagger weapon skill	
-- Skill Level: N/A	
-- Damage Varies with TP. Vajra: Aftermath effect varies with TP.	
-- Multiplies attack by 1.66	
-- Available only after completing the Unlocking a Myth (Thief) quest.	
-- Will stack with Sneak Attack.	
-- Aligned with the Shadow Gorget, Flame Gorget & Light Gorget.	
-- Aligned with the Shadow Belt, Flame Belt & Light Belt.	
-- Element: None	
-- Modifiers: DEX:30%	
-- 100%TP    200%TP    300%TP	
-- 2.00      2.13      2.50	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 2; params.ftp200 = 2.13; params.ftp300 = 2.5;
	params.str_wsc = 0.0; params.dex_wsc = 0.3; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1.66;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 18996 or sub == 18996) then
		aftermath = 1;
	elseif (main == 19065 or sub == 19065) then
		aftermath = 1;
	elseif (main == 19085 or sub == 19085) then
		aftermath = 1;
	elseif (main == 19617 or sub == 19617) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19715 or sub == 19715) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19824 or sub == 19824) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19953 or sub == 19953) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18996 or sub == 18996) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19065 or sub == 19065) or (main == 19085 or sub == 19085) or (main == 19617  or sub == 19617)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19715 or sub == 19715) or (main == 19824 or sub == 19824) or (main == 19953 or sub == 19953)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18996 or sub == 18996) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif ((main == 19065 or sub == 19065) or (main == 19085 or sub == 19085) or (main == 19617  or sub == 19617)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif ((main == 19715 or sub == 19715) or (main == 19824 or sub == 19824) or (main == 19953 or sub == 19953)) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			duration = 180;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18996 or sub == 18996) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif ((main == 19065 or sub == 19065) or (main == 19085 or sub == 19085) or (main == 19617  or sub == 19617)) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif ((main == 19715 or sub == 19715) or (main == 19824 or sub == 19824) or (main == 19953 or sub == 19953)) then
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
