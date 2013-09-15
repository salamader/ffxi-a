-----------------------------------
--
--  EFFECT_BARWATER
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	target:addMod(MOD_WATERRES,effect:getPower());
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

	target:delMod(MOD_WATERRES,effect:getPower());
	target:delMod(MOD_MDEF, effect:getTier());
end;