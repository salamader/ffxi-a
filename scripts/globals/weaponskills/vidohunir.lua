-----------------------------------	
-- Vidohunir	
-- Staff weapon skill	
-- Skill Level: N/A	
-- Lowers target's magic defense. Duration of effect varies with TP. Laevateinn: Aftermath effect varies with TP.	
-- Reduces enemy's magic defense by 10%.	
-- Available only after completing the Unlocking a Myth (Black Mage) quest.	
-- Aligned with the Breeze Gorget, Thunder Gorget, Aqua Gorget & Snow Gorget.	
-- Aligned with the Breeze Belt, Thunder Belt, Aqua Belt & Snow Belt.	
-- Element: Darkness	
-- Modifiers: INT:30%	
-- 100%TP    200%TP    300%TP	
-- 1.75      1.75      1.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 1.75; params.ftp200 = 1.75; params.ftp300 = 1.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.3; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 then
		local tp = player:getTP();
		local duration = (tp/100 * 60);
		if(target:hasStatusEffect(EFFECT_MAGIC_DEF_DOWN) == false) then
			target:addStatusEffect(EFFECT_MAGIC_DEF_DOWN, 10, 0, duration);
		end
	end

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 18994) then
		aftermath = 1;
	elseif (main == 19063) then
		aftermath = 1;
	elseif (main == 19083) then
		aftermath = 1;
	elseif (main == 19615) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19713) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19822) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19951) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18994) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif (main == 19063 or main == 19083 or main == 19615) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif (main == 19713 or main == 19822 or main == 19951) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18994) then
					duration = 180;
					subpower = math.floor((tp / 10) - 10);
				elseif (main == 19063 or main == 19083 or main == 19615) then
					duration = 270;
					subpower = math.floor((tp / 5) - 20);
				elseif (main == 19713 or main == 19822 or main == 19951) then
					duration = 270;
					subpower = math.floor((tp / 5) - 10);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,16,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18994) then
						duration = 180;
						subpower = math.floor(tp / 10);
					elseif (main == 19063 or main == 19083 or main == 19615) then
						duration = 270;
						subpower = math.floor(tp / 10);
					elseif (main == 19713 or main == 19822 or main == 19951) then
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
