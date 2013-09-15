-----------------------------------
--	EFFECT_MINUET
-- getPower returns the TIER (e.g. 1,2,3,4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER! 
-- Todo: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-----------------------------------
require("scripts/globals/status");
-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	
	target:addMod(MOD_ACC, effect:getTier());

	if(effect:getPower()==1) then
		target:addMod(MOD_ATT, (15 + effect:getSubPower()));
		target:addMod(MOD_RATT, (15 + effect:getSubPower()));
	elseif(effect:getPower()==2) then
		target:addMod(MOD_ATT, (32 + effect:getSubPower()));
		target:addMod(MOD_RATT, (32 + effect:getSubPower()));
	elseif(effect:getPower()==3) then
		target:addMod(MOD_ATT, (48 + effect:getSubPower()));
		target:addMod(MOD_RATT, (48 + effect:getSubPower()));
	elseif(effect:getPower()==4) then
		target:addMod(MOD_ATT, (56 + effect:getSubPower()));
		target:addMod(MOD_RATT, (56 + effect:getSubPower()));
	elseif(effect:getPower()==5) then
		target:addMod(MOD_ATT, (62 + effect:getSubPower()));
		target:addMod(MOD_RATT, (62 + effect:getSubPower()));
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

	target:delMod(MOD_ACC, effect:getTier());
	
	if(effect:getPower()==1) then
		target:delMod(MOD_ATT, (15 + effect:getSubPower()));
		target:delMod(MOD_RATT, (15 + effect:getSubPower()));
	elseif(effect:getPower()==2) then
		target:delMod(MOD_ATT, (32 + effect:getSubPower()));
		target:delMod(MOD_RATT, (32 + effect:getSubPower()));
	elseif(effect:getPower()==3) then
		target:delMod(MOD_ATT, (48 + effect:getSubPower()));
		target:delMod(MOD_RATT, (48 + effect:getSubPower()));
	elseif(effect:getPower()==4) then
		target:delMod(MOD_ATT, (56 + effect:getSubPower()));
		target:delMod(MOD_RATT, (56 + effect:getSubPower()));
	elseif(effect:getPower()==5) then
		target:delMod(MOD_ATT, (62 + effect:getSubPower()));
		target:delMod(MOD_RATT, (62 + effect:getSubPower()));
	end
end;