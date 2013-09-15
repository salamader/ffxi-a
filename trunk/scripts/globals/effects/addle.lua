-----------------------------------
--
-- EFFECT ADDLE
-- Decreases enemy's MACC and 
-- increases spellcasting time.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	local negPower = effect:getPower() * -1;
	target:addMod(MOD_MACC, negPower);
	target:addMod(MOD_FASTCAST, negPower);
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
	local negPower = effect:getPower() * -1;
	target:delMod(MOD_MACC, negPower);
	target:delMod(MOD_FASTCAST, negPower);
end;