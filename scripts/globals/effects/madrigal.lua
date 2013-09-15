-----------------------------------
--	EFFECT_MADRIGAL
-- getPower returns the TIER (e.g. 1,2,3,4)
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	target:addMod(MOD_ATT, effect:getTier());
	target:addMod(MOD_ACC,((effect:getPower() * 15) + effect:getSubPower()));
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

	target:delMod(MOD_ATT, effect:getTier());
	target:delMod(MOD_ACC,((effect:getPower() * 15) + effect:getSubPower()));
end;