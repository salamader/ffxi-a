-----------------------------------
--
--  EFFECT_BARPETRIFY
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_PETRIFYRES,effect:getPower());
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
	target:delMod(MOD_PETRIFYRES,effect:getPower());
	target:delMod(MOD_MDEF, effect:getTier());
end;