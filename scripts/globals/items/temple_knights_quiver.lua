-----------------------------------------
--	ID: 15956
--	Temple Knight Quiver
--	When used, you will obtain 1 Temple Knight Arrow
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
	target:addItem(18738,1);
end;