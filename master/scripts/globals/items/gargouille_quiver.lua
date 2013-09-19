-----------------------------------------
--	ID: 5912
--	Item: Gargouille Quiver
--	When used, you will obtain one stack of Gargouille Arrows
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
	target:addItem(19800,99);
end;