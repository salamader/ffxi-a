-----------------------------------
-- 	EFFECT_ANCIENT_CIRCLE
-- Grants resistance against dragons
-- to party members within AoE.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
   target:addMod(MOD_DRAGON_KILLER,effect:getPower());
   target:addMod(MOD_DRAGON_DMG,effect:getPower());
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
   target:delMod(MOD_DRAGON_KILLER,effect:getPower());
   target:delMod(MOD_DRAGON_DMG,effect:getPower());
end;
