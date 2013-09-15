-----------------------------------
--
-- EFFECT_SANCTION
--
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
	if(effect:getPower() == 1) then
		target:addHP(3);
	elseif(effect:getPower() == 2) then
		target:addMP(3);
	end
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
end;