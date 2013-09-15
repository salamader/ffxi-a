-----------------------------------------
-- ID: 5402
-- Item: Fire Card Case
-- Effect: When used, you will obtain one stack of Fire Cards
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
	target:addItem(2176,99);
end;