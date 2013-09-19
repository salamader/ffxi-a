-----------------------------------
--	EFFECT_ISSEKIGAN
-- Increases chance of payying and
-- gives an enmity bonus upon
-- successful parry.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_PARRY_RATE, effect:getPower());
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
	target:delMod(MOD_PARRY_RATE, effect:getPower());
end;