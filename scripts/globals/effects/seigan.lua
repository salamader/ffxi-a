-----------------------------------
-- Effect:
-- Seigan
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

	local head = caster:getEquipID(SLOT_HEAD);
	local pEquipMods = 0;
	
	-- Equipment Bonus
	if (head == 11075 or head == 11175) then -- Unkai Kabuto +2 & +1
		pEquipMods = 5;
	end

	target:addMod(MOD_COUNTER,((target:getMod(MOD_ZANSHIN)/4)+pEquipMods));
	target:addMod(MOD_FASTCAST,-50);
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
	target:delMod(MOD_COUNTER,(target:getMod(MOD_ZANSHIN)/4));
	target:delMod(MOD_FASTCAST,-50);
end;
