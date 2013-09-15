-----------------------------------------
-- ID: 5405
-- Item: Earth Card Case
-- Effect: When used, you will obtain one stack of Wind Cards
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
	target:addItem(2179,99);
end;