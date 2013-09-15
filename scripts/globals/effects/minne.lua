-----------------------------------
--	EFFECT_MINNE
-- getPower returns the TIER (e.g. 1,2,3,4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER! 
-- Todo: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-----------------------------------
require("scripts/globals/status");
-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	target:addMod(MOD_ENMITY, effect:getTier());

	if(effect:getPower()==1) then
		target:addMod(MOD_DEF, (14 + effect:getSubPower()));
	elseif(effect:getPower()==2) then
		target:addMod(MOD_DEF, (28 + effect:getSubPower()));
	elseif(effect:getPower()==3) then
		target:addMod(MOD_DEF, (40 + effect:getSubPower()));
	elseif(effect:getPower()==4) then
		target:addMod(MOD_DEF, (48 + effect:getSubPower()));
	elseif(effect:getPower()==5) then
		target:addMod(MOD_DEF, (60 + effect:getSubPower()));
	end
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

	target:delMod(MOD_ENMITY, effect:getTier());

	if(effect:getPower()==1) then
		target:delMod(MOD_DEF, (14 + effect:getSubPower()));
	elseif(effect:getPower()==2) then
		target:delMod(MOD_DEF, (28 + effect:getSubPower()));
	elseif(effect:getPower()==3) then
		target:delMod(MOD_DEF, (40 + effect:getSubPower()));
	elseif(effect:getPower()==4) then
		target:delMod(MOD_DEF, (48 + effect:getSubPower()));
	elseif(effect:getPower()==5) then
		target:delMod(MOD_DEF, (60 + effect:getSubPower()));
	end
end;