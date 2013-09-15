-----------------------------------
-- EFFECT_RHAPSODY
-- Increases Confusion Resistance to 
-- Party Members within target AoE
-- Addle ??
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	-- target:addMod(MOD_CONFUSIONRES,effect:getPower());
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
	-- target:delMod(MOD_CONFUSIONRES,effect:getPower());
end;