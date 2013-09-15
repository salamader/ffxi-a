-----------------------------------------
-- ID: 5915
-- Item: Adaman Bullet Pouch
-- Effect: When used, you will obtain stack of Adaman Bullets
-----------------------------------------

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
result = 0;
    if (target:getFreeSlotsCount() == 0) then
        result = 308;
    end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addItem(19803,99);
end;

