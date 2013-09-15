-----------------------------------------
-- ID: 5206
-- Item: Piece of Galka Mochi
-- Enchantment: 60 Min, Costume - Galka
-- Child
-----------------------------------------

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
	target:addStatusEffect(EFFECT_COSTUME,178,0,3600);
end;