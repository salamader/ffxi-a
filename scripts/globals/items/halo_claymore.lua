-----------------------------------------
--  ID: 16603
--  Item: Halo Claymore
--  Enchantment: TP +10
--  Durration: Instant
-----------------------------------------

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	local result = 0;
	return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
    target:addTP(10);
end;