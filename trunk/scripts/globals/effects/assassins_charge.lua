-----------------------------------
--	EFFECT_ASSASSINS_CHARGE
-- Will triple or quadruple your
-- next attack.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	if(effect:getPower() == 1) then
		target:addMod(MOD_TRIPLE_ATTACK, 100);
	elseif(effect:getPower() == 2) then
		if(math.random(100) <= 5) then
			target:addMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:addMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 3) then
		if(math.random(100) <= 10) then
			target:addMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:addMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 4) then
		if(math.random(100) <= 15) then
			target:addMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:addMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 5) then
		if(math.random(100) <= 20) then
			target:addMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:addMod(MOD_TRIPLE_ATTACK, 100);
		end
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
	if(effect:getPower() == 1) then
		target:delMod(MOD_TRIPLE_ATTACK, 100);
	elseif(effect:getPower() == 2) then
		if(math.random(100) <= 5) then
			target:delMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:delMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 3) then
		if(math.random(100) <= 10) then
			target:delMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:delMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 4) then
		if(math.random(100) <= 15) then
			target:delMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:delMod(MOD_TRIPLE_ATTACK, 100);
		end
	elseif(effect:getPower() == 5) then
		if(math.random(100) <= 20) then
			target:delMod(MOD_QUADRUPLE_ATTACK, 100);
		else
			target:delMod(MOD_TRIPLE_ATTACK, 100);
		end
	end
end;