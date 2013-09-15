-----------------------------------------
-- ID: 5873
-- Item: Dark Adaman Bullet Pouch
-- Effect: When used, you will obtain one stack of Dark Adaman Bullets
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
	target:addItem(19184,99);
end;