-----------------------------------
--	
--	EFFECT_PRELUDE
-- getPower returns the TIER (e.g. 1,2,3,4)
-- DO NOT ALTER ANY OF THE EFFECT VALUES! DO NOT ALTER EFFECT POWER! 
-- Todo: Find a better way of doing this. Need to account for varying modifiers + CASTER's skill (not target)
-----------------------------------
require("scripts/globals/status");
-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	preludePower = 15;
	preludePower2 = 34;
	local mod = 0;
	
	mod = mod + target:getMod(MOD_PRELUDE) + target:getMod(MOD_ALL_SONGS);
			
	preludePower = preludePower + (mod * 3);
	preludePower2 = preludePower2 + (mod * 7);

	
	if(effect:getPower()==1) then
		target:addMod(MOD_RACC, preludePower);
	elseif(effect:getPower()==2) then
		target:addMod(MOD_RACC, preludePower2);
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
		target:delMod(MOD_RACC, preludePower);
	elseif(effect:getPower()==2) then
		target:delMod(MOD_RACC, preludePower2);
	end
end;