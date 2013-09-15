-----------------------------------
-- EFFECT_SIRVENTE
-- Enmity - and gains it back over time
-- I'm sure it's not correct but a stop gap until it's implemented.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	emod = effect:getPower() * -1
	target:addMod(MOD_ENMITY,emod);
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
	-- the effect gains enmity of 1 every 3 ticks depending on the source of the enmity boost
	local enmity_effect_size = effect:getPower();
	if(enmity_effect_size > 0) then
		effect:setPower(enmity_effect_size - 1)
		target:delMod(MOD_ENMITY,-1); 
	end
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
	local enmity_effect_size = effect:getPower();
	if(enmity_effect_size > 0) then
		enmity_effect_size = enmity_effect_size * -1;
		target:delMod(MOD_ENMITY,enmity_effect_size);
	end
end;