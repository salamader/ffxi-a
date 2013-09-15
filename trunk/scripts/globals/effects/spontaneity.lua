-----------------------------------
--	EFFECT_SPONTANEITY
-- Reduces casting time of the next
-- magic spell the target casts.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_UFASTCAST,150);
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
	target:addMod(MOD_UFASTCAST,150);
end;