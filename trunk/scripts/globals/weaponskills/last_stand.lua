-----------------------------------	
-- Last Stand
-- Marksmanship weapon skill	
-- Skill level: 357
-- Delivers a twofold attack. Damage varies with TP.
-- Aligned with the Flame, Aqua & Light Gorgets.
-- Element: None
-- Modifiers: AGI: 100%
-- 100%TP    200%TP    300%TP	
-- 2.00      2.125      2.25	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 2; params.ftp200 = 2.125; params.ftp300 = 2.25;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 1.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;

	-- needs ignore defense. param

	local damage, tpHits, extraHits = doRangedWeaponskill(player, target, params);
	local crticalHit = false;

	return tpHits, extraHits, criticalHit, damage;

end;
