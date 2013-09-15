-----------------------------------------
-- ID: 4165
-- Item: Pot of Silent Oil
-- Effect: This lubricant cuts down
-- 		   99.99% of all friction
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------
function onItemCheck(target)
	return 0;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	local duration = math.random(60, 180);
	duration = duration + (duration * target:getMod(MOD_SNEAK_DUR));
	if (not target:hasStatusEffect(EFFECT_SNEAK)) then
		target:addStatusEffect(EFFECT_SNEAK,1,10,duration);
	end
end;
