-----------------------------------------
-- ID: 13685
-- Item: Invisible Mantle
-- Item Effect: Invisible
-- Duration: 3 Mins  Charges: 20
-----------------------------------------

require("scripts/globals/settings");

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

	if(target:hasStatusEffect(EFFECT_INVISIBLE)) then
	        target:messageBasic(423);
	else
		local duration = 180;
		duration = duration + (duration * target:getMod(MOD_INVIS_DUR));
		if (not target:hasStatusEffect(EFFECT_INVISIBLE)) then
			target:addStatusEffect(EFFECT_INVISIBLE,0,10,duration);
		end
	end
end;