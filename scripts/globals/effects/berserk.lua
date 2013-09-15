-----------------------------------
--
-- 	EFFECT_BERSERK
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	
	target:addMod(MOD_DEFP, effect:getPower());
	target:addMod(MOD_ATTP, effect:getSubPower());
	target:addMod(MOD_RATTP, effect:getSubPower());
	target:addMod(MOD_CRITHITRATE, effect:getTier());
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

	target:delMod(MOD_DEFP, effect:getPower());
	target:delMod(MOD_ATTP, effect:getSubPower());
	target:delMod(MOD_RATTP, effect:getSubPower());
	target:delMod(MOD_CRITHITRATE, effect:getTier());
end;