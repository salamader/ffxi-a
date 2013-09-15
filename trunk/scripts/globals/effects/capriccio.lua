-----------------------------------
--
-- EFFECT_CAPRICCIO
-- Increases Petrification Resistance 
-- to Party Members within target AoE
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_PETRIFYRES,effect:getPower());
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
end;