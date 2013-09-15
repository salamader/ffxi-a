-----------------------------------	
-- Blade Metsu	
-- Katana weapon skill	
-- Skill Level: N/A	
-- Additional effect: Paralysis	
-- Hidden effect: temporarily enhances Subtle Blow effect.	
-- One hit weapon skill, despite non single-hit animation.	
-- This weapon skill is only available with the stage 5 relic Katana Kikoku or within Dynamis with the stage 4 Yoshimitsu.	
-- Weaponskill is also available with the Sekirei Katana obtained from Abyssea NM Sedna.	
-- Aligned with the Shadow Gorget, Breeze Gorget & Thunder Gorget.	
-- Aligned with the Shadow Belt, Breeze Belt & Thunder Belt.	
-- Element: None	
-- Modifiers: DEX:60%	
-- 100%TP    200%TP    300%TP	
-- 3.00      3.00      3.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 3; params.ftp200 = 3; params.ftp300 = 3;
	params.str_wsc = 0.0; params.dex_wsc = 0.6; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	if damage > 0 then	
		local tp = player:getTP();
		local duration = (tp/100 * 20);
		if(player:hasStatusEffect(EFFECT_SUBTLE_BLOW_PLUS) == false) then
			player:addStatusEffect(EFFECT_SUBTLE_BLOW_PLUS, 10, 0, duration);
		end
	end
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18312 or sub == 18312) then
		aftermath = 1;
	elseif (main == 18313 or sub == 18313) then
		aftermath = 1;
	elseif (main == 18645 or sub == 18645) then
		aftermath = 1;
	elseif (main == 18659 or sub == 18659) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 18673 or sub == 18673) then
		damage = damage * 1.25;
		aftermath = 1;
	elseif (main == 19754 or sub == 19754) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif (main == 19847 or sub == 19847) then
		damage = damage * 1.4;
		aftermath = 1;
	elseif ((main == 18311 or sub == 18311) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,2,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,2,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,2,0,duration);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
