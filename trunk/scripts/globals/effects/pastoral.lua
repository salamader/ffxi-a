-----------------------------------
--
-- EFFECT_PASTORAL
-- Increases Poison Resistance to 
-- Party Members within target AoE
----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_POISONRES,effect:getPower());
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
end;