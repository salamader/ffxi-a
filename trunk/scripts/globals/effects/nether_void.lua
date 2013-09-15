-----------------------------------
--	EFFECT_NETHER_VOID
-- Increases the absorption of your
-- next dark magic spell.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_ABSORB_POTENCY, effect:getPower());
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
	target:delMod(MOD_ABSORB_POTENCY, effect:getPower());
end;