-----------------------------------
--	EFFECT_FUTAE
-- 50% Bonus to Ninjutsu Dmg
-- Expends 2 ninja tools.
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_NIN_MAG_DMG, effect:getPower());
	target:addMod(MOD_MATT, effect:getSubPower());
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
	target:delMod(MOD_NIN_MAG_DMG, effect:getPower());
	target:delMod(MOD_MATT, effect:getSubPower());
end;