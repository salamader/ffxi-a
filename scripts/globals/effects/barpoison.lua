-----------------------------------
--
--  EFFECT_BARPOISON
--
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_POISONRES,effect:getPower());
	target:addMod(MOD_MDEF, effect:getTier());
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
	target:delMod(MOD_POISONRES,effect:getPower());
	target:delMod(MOD_MDEF, effect:getTier());
end;