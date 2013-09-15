-----------------------------------
--	EFFECT_REPRISAL
-- Increases chances of blocking
-- with shield, reflects a portion
-- of blocked dmg back to attacker.
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
    target:addMod(MOD_BLOCK_RATE,10);
    target:addMod(MOD_SPIKES,6);
    target:addMod(MOD_SPIKES_DMG, effect:getPower());
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
    target:delMod(MOD_BLOCK_RATE,10);
    target:delMod(MOD_SPIKES,6);
    target:delMod(MOD_SPIKES_DMG, effect:getPower());
end;