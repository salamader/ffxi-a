-----------------------------------
--	EFFECT_DARK_SEAL
--  Increases MACC of next Dark 
--  Magic Spell cast
-----------------------------------

-----------------------------------
--	EFFECT_DARK_SEAL
-- Enhances acc of your next magic
-- spell. Each merit after 1st
-- reduces Dark Mag casting time
-- by 10%.
-----------------------------------

function onEffectGain(target,effect)

	target:addMod(MOD_DARK_MAG_CAST, ((effect:getPower() - 1) * 10))
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

	target:delMod(MOD_DARK_MAG_CAST, ((effect:getPower() - 1) * 10))
end;