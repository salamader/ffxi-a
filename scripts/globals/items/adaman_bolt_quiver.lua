-----------------------------------------
--	ID: 5913
--	Item: Adaman Bolt Quiver
--	When used, you will obtain one stack of Adaman Bolts
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
	target:addItem(19801,99);
end;