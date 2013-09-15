-----------------------------------
--
-- EFFECT_HYMNUS
-- Grants Reraise to Party Members 
-- within target AoE
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	-- power level is the raise number (3)
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
    if(target:getHP() <= 0) then
		target:sendRaise(effect:getPower());
    end
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
end;