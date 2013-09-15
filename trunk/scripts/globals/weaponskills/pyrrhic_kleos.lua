-----------------------------------     
-- Pyrrhic Kleos
-- Dagger weapon skill  
-- Skill level: N/A
-- Description: Delivers a fourfold attack that lowers target's evasion. Duration of effect varies with TP. Terpsichore: Aftermath effect varies with TP.
-- Available only after completing the Unlocking a Myth (Dancer) quest.
-- Aligned with the Soil Gorget, Aqua Gorget & Snow Gorget.
-- Aligned with the Soil Belt, Aqua Belt & Snow Belt.
--
-- Element: Unknown
-- Skillchain Properties: Distortion/Scission
-- Modifiers: STR:20% ; DEX:30%
--
-- Damage Multipliers by TP:
-- 100%TP	200%TP	300%TP
-- 1.5	    1.5	    1.5
-----------------------------------     
require("scripts/globals/status");      
require("scripts/globals/settings");    
require("scripts/globals/weaponskills");        
-----------------------------------     
        
function OnUseWeaponSkill(player, target, wsID) 
    
	local params = {};
	params.numHits = 4;
	params.ftp100 = 1.5; params.ftp200 = 1.5; params.ftp300 = 1.5;
	params.str_wsc = 0.2; params.dex_wsc = 0.3; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 then
		local tp = player:getTP();
		local duration = (tp/100 * 30) + 30;
		if(target:hasStatusEffect(EFFECT_EVASION_DOWN) == false) then
			target:addStatusEffect(EFFECT_EVASION_DOWN, 10, 0, duration);
		end
	end

	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 18989 or sub == 18989) then
		aftermath = 1;
	elseif (main == 19078 or sub == 19078) then
		aftermath = 1;
	elseif (main == 19098 or sub == 19098) then
		aftermath = 1;
	elseif (main == 19630 or sub == 19630) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19728 or sub == 19728) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19837 or sub == 19837) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19966 or sub == 19966) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18989 or sub == 18989) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19078 or sub == 19078) or (main == 19098 or sub == 19098) or (main == 19630  or sub == 19630)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19728 or sub == 19728) or (main == 19837 or sub == 19837) or (main == 19966 or sub == 19966)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18989 or sub == 18989) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif ((main == 19078 or sub == 19078) or (main == 19098 or sub == 19098) or (main == 19630  or sub == 19630)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif ((main == 19728 or sub == 19728) or (main == 19837 or sub == 19837) or (main == 19966 or sub == 19966)) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18989 or sub == 18989) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif ((main == 19078 or sub == 19078) or (main == 19098 or sub == 19098) or (main == 19630  or sub == 19630)) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif ((main == 19728 or sub == 19728) or (main == 19837 or sub == 19837) or (main == 19966 or sub == 19966)) then
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