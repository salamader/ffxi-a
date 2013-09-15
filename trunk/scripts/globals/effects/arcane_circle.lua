-----------------------------------
-- 	EFFECT_ARCANE_CIRCLE
-- Grants resistance against arcana
-- to party members within AoE.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
   target:addMod(MOD_ARCANA_KILLER, effect:getPower());
   target:addMod(MOD_ARCANE_DMG, effect:getPower());
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
   target:delMod(MOD_ARCANA_KILLER, effect:getPower());
   target:delMod(MOD_ARCANE_DMG, effect:getPower());
end;
