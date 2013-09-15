-------------------------------------------
--    EFFECT_DIA
-- Lowers an enemy's defense and 
-- gradually deals light elemental damage.
-------------------------------------------
-- Quick Explanation of Algorithm:
-- Dia 1: Power of 1. Results in reduced defense of ~5.27%  (27/512) and 1 hp/tick damage.
-- Dia 2: Power of 2. Results in reduced defense of ~10.35% (53/512) and 2 hp/tick damage.
-- Dia 3: Power of 3. Results in reduced defense of ~15.4%  (79/512) and 3 hp/tick damage.
-- Dia 4: Power of 4. Results in reduced defense of ~20.5%  (105/512) and 4 hp/tick damage.
-- Dia 5: Power of 5. Results in reduced defense of ~25.6%  (131/512) and 5 hp/tick damage.
-------------------------------------------

require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	local power = effect:getPower();
	local subpower = effect:getSubPower();
	local tier = effect:getTier();
	target:addMod(MOD_REGEN_DOWN, (power + tier));
	target:addMod(MOD_DEFP,-subpower);
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
	local power = effect:getPower();
	local subpower = effect:getSubPower();
	local tier = effect:getTier();
	target:delMod(MOD_REGEN_DOWN, (power + tier));
	target:delMod(MOD_DEFP,-subpower);
end;
