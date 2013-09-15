-----------------------------------	
-- Shattersoul
-- Staff weapon skill	
-- Skill level: 357	
-- Decreases target's Magic Defense. Duration of effect varies with TP.	
-- Aligned with the Shadow, Soil, and Snow Gorgets.	
-- Aligned with the Shadow, Soil, and Snow Belts.	
-- Element: None	
-- Modifiers: INT:20%~100% Depending on Merit Point upgrades.	
-- 100%TP    200%TP    300%TP	
-- 1.375      1.375     1.375	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 3;
	params.ftp100 = 1; params.ftp200 = 1; params.ftp300 = 1;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.2; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
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
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
