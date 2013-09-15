-----------------------------------
--
-- 	EFFECT_MAGIC_ACC_DOWN
-- 	Increases / Decreases
-- 	Magic Acc
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(MOD_MACC,effect:getPower());
end;
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
    target:delMod(MOD_MACC,effect:getPower());
end;