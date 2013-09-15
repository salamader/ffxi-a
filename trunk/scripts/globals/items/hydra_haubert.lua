-----------------------------------------
--	ID: 14517
--	Item: Hydra Haubert
--	Enchantment: Adds Auto Refresh
--	Duration: 30 Mins
-----------------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	return 0;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	duration = 1800;
		target:delStatusEffect(EFFECT_AUTO_REFRESH);
		target:addStatusEffect(EFFECT_AUTO_REFRESH,3,1,duration);
end;