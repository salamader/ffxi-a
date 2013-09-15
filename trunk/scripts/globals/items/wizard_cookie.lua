-----------------------------------------
-- ID: 4576
-- Item: wizard_cookie
-- Food Effect: 5Min, All Races
-----------------------------------------
-- HP 3000
-- Character Stats AGI DEX STR +25
-- Attack +25
-- Accuracy +25
-- Ranged Accuracy +25
-- Store TP +25
-- Haste 70%
-- Regen 1400 1Tic
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
	target:addStatusEffect(EFFECT_FOOD,0,0,600,4576);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_HP, 3000);
	target:addMod(MOD_STR, 25);
	target:addMod(MOD_DEX, 25);
	target:addMod(MOD_AGI, 25);
	target:addMod(MOD_ACC, 25);
	target:addMod(MOD_RACC, 25);
	target:addMod(MOD_STORETP, 25);
	if(target:hasStatusEffect(EFFECT_HASTE) == false) then
		target:addStatusEffect(EFFECT_HASTE,700,0,600)
	end;
	if(target:hasStatusEffect(EFFECT_REGEN) == false) then
		target:addStatusEffect(EFFECT_REGEN,1400,1,600);
	end;
		
	
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_HP, 3000);
	target:delMod(MOD_STR, 25);
	target:delMod(MOD_DEX, 25);
	target:delMod(MOD_AGI, 25);
	target:delMod(MOD_ACC, 25);
	target:delMod(MOD_RACC, 25);
	target:delMod(MOD_STORETP, 25);
end;
