-----------------------------------	
-- Cataclysm	
-- Staff weapon skill	
-- Skill Level: 290	
-- Deals dark elemental damage to enemy. Damage varies with TP.	
-- Aligned with the Shadow Gorget & Aqua Gorget.	
-- Aligned with the Shadow Belt & Aqua Belt.	
-- Element: Dark	
-- Modifiers: STR:30% ; INT:30%	
-- 100%TP    200%TP    300%TP	
-- 2.75      4.00      5.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 2.75; params.ftp200 = 4; params.ftp300 = 5;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.3; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
