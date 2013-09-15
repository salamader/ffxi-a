-----------------------------------
--
-- EFFECT_MULTI_STRIKES
-- Author: mvd1987
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_DOUBLE_ATTACK, effect:getPower());
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
	target:delMod(MOD_DOUBLE_ATTACK, effect:getPower());
end;