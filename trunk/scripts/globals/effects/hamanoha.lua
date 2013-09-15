-----------------------------------
--	EFFECT_HAMANOHA
-- Lowers Acc Eva MAcc MEva and TP
-- Gain for Demons.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_ACCP, effect:getPower());
	target:addMod(MOD_EVAP, effect:getPower());
	target:addMod(MOD_MACC, effect:getPower());
	target:addMod(MOD_MEVA, effect:getPower());
	target:addMod(MOD_STORETP, effect:getPower());
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
	target:delMod(MOD_ACCP, effect:getPower());
	target:delMod(MOD_EVAP, effect:getPower());
	target:delMod(MOD_MACC, effect:getPower());
	target:delMod(MOD_MEVA, effect:getPower());
	target:delMod(MOD_STORETP, effect:getPower());
end;