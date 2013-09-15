-----------------------------------------
-- ID: 5124
-- Item: Tropical Clam
-- Food Effect: 5Min, Mithra only
-----------------------------------------
-- Vitality 4
-- Dexterity -5 
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
result = 0
	if (target:getRace() ~= 7) then
		result = 247;
	end
	if(target:getMod(MOD_EAT_RAW_FISH) == 1) then
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
	target:addStatusEffect(EFFECT_FOOD,0,0,300,5124);
end;

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_VIT, 4);
	target:addMod(MOD_DEX, -5);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_VIT, 4);
	target:delMod(MOD_DEX, -5);
end;
