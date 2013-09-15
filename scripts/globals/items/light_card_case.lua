-----------------------------------------
-- ID: 5408
-- Item: Light Card Case
-- Effect: When used, you will obtain one stack of Light Cards
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
	target:addItem(2182,99);
end;