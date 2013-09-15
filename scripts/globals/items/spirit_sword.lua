-----------------------------------------
--  ID: 16613
--  Item: Spirit Sword
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