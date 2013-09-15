-----------------------------------	
-- Mystic Boon	
-- Club weapon skill	
-- Skill level: N/A	
-- Converts damage dealt to own MP. Damage varies with TP. Yagrush: Aftermath effect varies with TP.	
-- Available only after completing the Unlocking a Myth (White Mage) quest.	
-- Damage is significantly affected by Attack. Verification Needed	
-- Not aligned with any "elemental gorgets" or elemental belts due to it's absence of Skillchain properties.	
-- Element: None	
-- Modifiers: STR:30% ; MND:50%	
-- 100%TP    200%TP    300%TP	
-- 1.00      1.50      2.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 1; params.ftp200 = 1.5; params.ftp300 = 2;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.5; params.chr_wsc = 0.0;
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
	
	if (main == 18993 or sub == 18993) then
		aftermath = 1;
	elseif (main == 19062 or sub == 19062) then
		aftermath = 1;
	elseif (main == 19082 or sub == 19082) then
		aftermath = 1;
	elseif (main == 19614 or sub == 19614) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19712 or sub == 19712) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19821 or sub == 19821) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19950 or sub == 19950) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18993 or sub == 18993) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19062 or sub == 19062) or (main == 19082 or sub == 19082) or (main == 19614  or sub == 19614)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19712 or sub == 19712) or (main == 19821 or sub == 19821) or (main == 19950 or sub == 19950)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18993 or sub == 18993) then
					duration = 90;
					subpower = math.floor((tp / 10) - 10);
				elseif ((main == 19062 or sub == 19062) or (main == 19082 or sub == 19082) or (main == 19614  or sub == 19614)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 20) - 15);
				elseif ((main == 19712 or sub == 19712) or (main == 19821 or sub == 19821) or (main == 19950 or sub == 19950)) then
					duration = 120;
					subpower = math.floor((tp / 10) + 10);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,15,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18993 or sub == 18993) then
						duration = 180;
						subpower = math.floor(tp / 10);
					elseif ((main == 19062 or sub == 19062) or (main == 19082 or sub == 19082) or (main == 19614  or sub == 19614)) then
						duration = 270;
						subpower = math.floor(tp / 10);
					elseif ((main == 19712 or sub == 19712) or (main == 19821 or sub == 19821) or (main == 19950 or sub == 19950)) then
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
