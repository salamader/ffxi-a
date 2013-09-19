-----------------------------------------
-- ID: 5914
-- Item: Orichalcum Bullet Pouch
-- Effect: When used, you will obtain stack of Orichalcum Bullets
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
	target:addItem(19802,99);
end;

