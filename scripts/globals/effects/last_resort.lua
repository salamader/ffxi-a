-----------------------------------
-- 	EFFECT_LAST_RESORT
-- Enhances attacks - weakens defense
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	target:addMod(MOD_ATTP,20 + effect:getSubPower());
	target:addMod(MOD_DEFP,((-15 - effect:getSubPower()) + effect:getTier()));
	target:addMod(MOD_HASTE_ABILITY, effect:getPower())
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)

	target:delMod(MOD_ATTP,20 + effect:getSubPower());
	target:delMod(MOD_DEFP,((-15 - effect:getSubPower()) + effect:getTier()));
	target:delMod(MOD_HASTE_ABILITY, effect:getPower())
end;