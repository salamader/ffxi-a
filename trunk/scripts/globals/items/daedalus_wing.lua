-----------------------------------------
-- ID: 4202
-- Item: Daedalus Wing
-- Effect: Increases TP of the user by 100
-----------------------------------------

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	result = 0;
	if (target:hasStatusEffect(EFFECT_MEDICINE)) then
		result = 111;
	end
	return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addTP(100);
	target:addStatusEffect(EFFECT_MEDICINE,0,0,180);
end;