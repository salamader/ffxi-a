-----------------------------------	
-- Tachi Rana	
-- Great Katana weapon skill	
-- Skill Level: N/A	
-- Delivers a three-fold attack. params.accuracy varies with TP. Aftermath effect varies with TP. See Kogarasumaru.	
-- In order to obtain Tachi: Rana, the Unlocking a Myth (Samurai) quest must be completed.	
-- Will stack with Sneak Attack (first hit only).	
-- Aligned with the Shadow Gorget, Soil Gorget & Snow Gorget.	
-- Aligned with the Shadow Belt, Soil Belt & Snow Belt.	
-- Element: None	
-- Modifiers: STR:35%	
-- 100%TP    200%TP    300%TP	
-- 1.00      1.00      1.00	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 3;
	params.ftp100 = 1; params.ftp200 = 1; params.ftp300 = 1;
	params.str_wsc = 0.35; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	return tpHits, extraHits, criticalHit, damage;
	
end	
