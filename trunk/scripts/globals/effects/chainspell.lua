-----------------------------------
--
-- 	EFFECT_CHAINSPELL
--  Allows rapid spellcasting. 	
-----------------------------------

require("scripts/globals/status");
-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_UFASTCAST,150);
	target:addMod(MOD_QUICK_MAGIC,150);			
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
	target:delMod(MOD_UFASTCAST,150);
	target:delMod(MOD_QUICK_MAGIC,150);
end;