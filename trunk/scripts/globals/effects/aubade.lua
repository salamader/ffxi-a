-----------------------------------
--
-- EFFECT_AUBADE
-- Increases Sleep Resistance to 
-- Party Members within target AoE
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_SLEEPRES,effect:getPower());
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
	target:delMod(MOD_SLEEPRES,effect:getPower());
end;