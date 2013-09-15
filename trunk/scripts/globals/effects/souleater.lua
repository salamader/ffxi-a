-----------------------------------
--	EFFECT_SOULEATER
-- Consumes 10% of your HP to
-- enhance attacks.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	if(target:getObjType() == TYPE_PC) then
		local merit = target:getMerit(MERIT_MUTED_SOUL);
		local amount = 0;
		if (merit > 0) then
			amount = -1 * merit * 10;
		end
		target:addMod(MOD_ENMITY, amount)
	end
	target:addMod(MOD_ACC,25);
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
	if(target:getObjType() == TYPE_PC) then
		local merit = target:getMerit(MERIT_MUTED_SOUL);
		local amount = 0;
		if (merit > 0) then
			amount = -1 * merit * 10;
		end
		target:delMod(MOD_ENMITY, amount)
	end	
	target:delMod(MOD_ACC,25);
end;