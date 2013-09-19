-----------------------------------------
--	ID: 15957
--	Iron Musketeer Quiver
--	When used, you will obtain 1 Iron Musketeer's Bolt
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
	target:addItem(18739,1);
end;