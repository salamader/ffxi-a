-----------------------------------------
-- ID: 5870
-- Item: Trump Card Case
-- Effect: When used, you will obtain one stack of Trump Cards
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
	target:addItem(2974,99);
end;