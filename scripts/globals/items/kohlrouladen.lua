-----------------------------------------
-- ID: 5760
-- Item: Kohlrouladen
-- Food Effect: 2 Hours, All Races
-----------------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -5
-- Ranged Accuracy 10%  Cap 65
-- Ranged Attack 8% Cap 60
-- Enmity -4
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,7200,5760);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_STR, 3);
	target:addMod(MOD_AGI, 3);
	target:addMod(MOD_INT, -5);
	target:addMod(MOD_FOOD_RACCP, 14);
	target:addMod(MOD_FOOD_RACC_CAP, 65);
	target:addMod(MOD_FOOD_RATTP, 8);
	target:addMod(MOD_FOOD_RATT_CAP, 60);
	target:addMod(MOD_ENMITY, -4);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_STR, 3);
	target:delMod(MOD_AGI, 3);
	target:delMod(MOD_INT, -5);
	target:delMod(MOD_FOOD_RACCP, 14);
	target:delMod(MOD_FOOD_RACC_CAP, 65);
	target:delMod(MOD_FOOD_RATTP, 8);
	target:delMod(MOD_FOOD_RATT_CAP, 60);
	target:delMod(MOD_ENMITY, -4);
end;
