-----------------------------------------
--	ID: 15958
--	Combat Caster Quiver
--	When used, you will obtain 1 Combat Casters Arrow
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
	target:addItem(18740,1);
end;