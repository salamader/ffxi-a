-----------------------------------------
--	ID: 10269
--	Creek Top +1
--	When used, you will obtain 1 Berry Snowcone
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
	target:addItem(5710,1);
end;