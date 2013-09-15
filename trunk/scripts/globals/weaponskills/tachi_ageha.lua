-----------------------------------	
-- Tachi:Ageha
-- Great Katana weapon skill	
-- Skill level: 300	
-- Lowers targets defense. Chance of lowering target's defense varies with TP.	
-- Aligned with the Shadow and Soil Gorgets.	
-- Aligned with the Shadow and Soil Belts.	
-- Element: None	
-- Modifiers: CHR:50%
-- 100%TP    200%TP    300%TP	
-- 2.80      2.80      2.80	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 2.8; params.ftp200 = 2.8; params.ftp300 = 2.8;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.5; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 and (target:hasStatusEffect(EFFECT_DEFENSE_DOWN) == false) then
		target:addStatusEffect(EFFECT_DEFENSE_DOWN, 27, 0, 180);
	end

	return tpHits, extraHits, criticalHit, damage;
	
end	
