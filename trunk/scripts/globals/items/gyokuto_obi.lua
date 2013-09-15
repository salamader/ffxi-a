-----------------------------------------
--	ID: 15860
--	Gyokuto Obi
--	Enchantment: Costume - Large Rarab
--	Durration: 60 Mins
-----------------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	return target:canUseCostume();
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_COSTUME,335,0,3600);
end;