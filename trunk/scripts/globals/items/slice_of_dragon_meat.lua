-----------------------------------------
-- ID: 4272
-- Item: Slice of Dragon Meat
-- Food Effect: 5 Min, Galka only
-----------------------------------------
-- Strength 6
-- Intelligence -8
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:getRace() ~= 8) then
		result = 247;
	end
	if(target:getMod(MOD_EAT_RAW_MEAT) == 1) then
		result = 0;
	end
	if (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,300,4272);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_STR, 6);
	target:addMod(MOD_INT, -8);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_STR, 6);
	target:delMod(MOD_INT, -8);
end;
