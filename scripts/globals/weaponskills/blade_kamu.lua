-----------------------------------	
-- Blade Kamu	
-- Katana weapon skill	
-- Skill Level: N/A	
-- Lowers target's params.accuracy. Duration of effect varies with TP. Nagi: Aftermath effect varies with TP.	
-- Effect lasts 60 seconds @ 100 TP, 90 seconds @ 200 TP, and 120 seconds @ 300 TP	
-- Available only after completing the Unlocking a Myth (Ninja) quest.	
-- Aligned with the Shadow Gorget, Thunder Gorget & Breeze Gorget.	
-- Aligned with the Shadow Belt, Thunder Belt & Breeze Belt.	
-- Element: None	
-- Modifiers: STR:50% ; INT:50%	
-- 100%TP    200%TP    300%TP	
-- 1.00      1.00      1.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 1; params.ftp200 = 1; params.ftp300 = 1;
	params.str_wsc = 0.5; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.5; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 then	
		local tp = player:getTP();
		local duration = (tp/100 * 30) + 30;
		if(target:hasStatusEffect(EFFECT_ACCURACY_DOWN) == false) then
			target:addStatusEffect(EFFECT_ACCURACY_DOWN, 10, 0, duration);
		end
	end
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 19003 or sub == 19003) then
		aftermath = 1;
	elseif (main == 19072 or sub == 19072) then
		aftermath = 1;
	elseif (main == 19092 or sub == 19092) then
		aftermath = 1;
	elseif (main == 19624 or sub == 19624) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19722 or sub == 19722) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19831 or sub == 19831) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19960 or sub == 19960) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 19003 or sub == 19003) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19072 or sub == 19072) or (main == 19092 or sub == 19092) or (main == 19624  or sub == 19624)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19722 or sub == 19722) or (main == 19831 or sub == 19831) or (main == 19960 or sub == 19960)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 19003 or sub == 19003) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif ((main == 19072 or sub == 19072) or (main == 19092 or sub == 19092) or (main == 19624  or sub == 19624)) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif ((main == 19722 or sub == 19722) or (main == 19831 or sub == 19831) or (main == 19960 or sub == 19960)) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 19003 or sub == 19003) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif ((main == 19072 or sub == 19072) or (main == 19092 or sub == 19092) or (main == 19624  or sub == 19624)) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif ((main == 19722 or sub == 19722) or (main == 19831 or sub == 19831) or (main == 19960 or sub == 19960)) then
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
