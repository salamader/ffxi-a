-----------------------------------------
-- ID: 5406
-- Item: Thunder Card Case
-- Effect: When used, you will obtain one stack of Thunder Cards
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
	target:addItem(2180,99);
end;