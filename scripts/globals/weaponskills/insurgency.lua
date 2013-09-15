-----------------------------------	
-- Insurgency	
-- Scythe weapon skill	
-- Skill level: N/A	
-- Delivers a fourfold attack. Damage varies with TP. Liberator: Aftermath effect varies with TP.	
-- Available only after completing the Unlocking a Myth (Dark Knight) quest.	
-- Appears to be heavily modified by attack.	
-- Aligned with the Flame Gorget, Light Gorget & Shadow Gorget.	
-- Aligned with the Flame Belt, Light Belt & Shadow Belt.	
-- Element: None	
-- Modifiers: STR:20% ; INT:20%	
-- 100%TP    200%TP    300%TP	
-- 0.50      0.75      1.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 4;
	params.ftp100 = 0.5; params.ftp200 = 0.75; params.ftp300 = 1;
	params.str_wsc = 0.2; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.2; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 18998) then
		aftermath = 1;
	elseif (main == 19067) then
		aftermath = 1;
	elseif (main == 19087) then
		aftermath = 1;
	elseif (main == 19619) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19717) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19826) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19955) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18998) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif (main == 19067 or main == 19087 or main == 19619) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif (main == 19717 or main == 19826 or main == 19955) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18998) then
					duration = 90;
					subpower = math.floor(2 * (tp / 5) - 60);
				elseif (main == 19067 or main == 19087 or main == 19619) then
					duration = 120;
					subpower = math.floor(3 * (tp / 5) - 90);
				elseif (main == 19717 or main == 19826 or main == 19955) then
					duration = 120;
					subpower = math.floor((tp * .6) - 80);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,14,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18998) then
						duration = 60;
						subpower = math.floor(tp / 10);
					elseif (main == 19067 or main == 19087 or main == 19619) then
						duration = 90;
						subpower = math.floor(3 * (tp / 20));
					elseif (main == 19717 or main == 19826 or main == 19955) then
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
