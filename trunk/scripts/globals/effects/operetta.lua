-----------------------------------
-- EFFECT_OPERETTA
-- Puppet's, Scop's, and Jester's
-- Operettas
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	if(effect:getPower()==1) then
		target:addMod(MOD_SILENCERES, (20 + (effect:getSubPower() * 5)));	
	elseif(effect:getPower()==2) then
		target:addMod(MOD_SILENCERES, (40 + (effect:getSubPower() * 5)));
	elseif(effect:getPower()==3) then
		target:addMod(MOD_SILENCERES, (60 + (effect:getSubPower() * 5)));
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

	if(effect:getPower()==1) then
		target:delMod(MOD_SILENCERES, (20 + (effect:getSubPower() * 5)));	
	elseif(effect:getPower()==2) then
		target:delMod(MOD_SILENCERES, (40 + (effect:getSubPower() * 5)));
	elseif(effect:getPower()==3) then
		target:delMod(MOD_SILENCERES, (60 + (effect:getSubPower() * 5)));
	end
end;