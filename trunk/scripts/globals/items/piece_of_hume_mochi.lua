-----------------------------------------
--	ID: 5203
--	Item: Piece of Hume Mochi
--	Enchantment: 60 Min, Costume - Hume
--  child (male)
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
	target:addStatusEffect(EFFECT_COSTUME,114,0,3600);
end;