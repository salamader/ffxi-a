-----------------------------------	
-- Flash Nova
-- Club weapon skill	
-- Skill Level: 290
-- Delivers a light elemental attack. Additional effect Flash. Chance of effect varies with TP.	
-- Aligned with the Aqua Gorget.	
-- Aligned with the Aqua Belt.	
-- Element: Light
-- Modifiers: STR:30% ; MND:30%	
-- 100%TP    200%TP    300%TP	
-- 3.00      3.00      3.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 3.00; params.ftp200 = 3.00; params.ftp300 = 3.00;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.3; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	if damage > 0 then
		local tp = player:getTP();
		local chance = (math.random(80,150));
		if (tp >= chance) then
			if(target:hasStatusEffect(EFFECT_FLASH) == false) then
				target:addStatusEffect(EFFECT_FLASH, 100, 0, 15);
			end
		else
		end
	end	
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
