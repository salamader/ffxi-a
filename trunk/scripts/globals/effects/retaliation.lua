-----------------------------------
--	EFFECT_RETALIATION
-- Allows you to counterattack but
-- reduces movement speed.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_MOVE, -30);
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
	target:delMod(MOD_MOVE, -30);
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
end;