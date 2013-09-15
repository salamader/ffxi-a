-----------------------------------	
-- Aeolian Edge	
-- Dagger weapon skill	
-- Skill level: 290	
-- Delivers an area attack that deals wind elemental damage. Damage varies with TP.	
-- This weapon skill is ranged and can be used from a distance (Up to 15').	
-- Directly affected by Magic Attack Bonus.	
-- Aligned with the Breeze Gorget, Soil Gorget, & Thunder Gorget.	
-- Aligned with the Breeze Belt, Soil Belt, & Thunder Belt.	
-- Element: Wind	
-- Modifiers: DEX:28% ; INT:28%	
-- 100%TP    200%TP    300%TP	
-- 2.75      3.50      4.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 2.75; params.ftp200 = 3.50; params.ftp300 = 4.00;
	params.str_wsc = 0.0; params.dex_wsc = 0.28; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.28; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	return tpHits, extraHits, criticalHit, damage;
	
end
