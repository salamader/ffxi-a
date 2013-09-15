-----------------------------------------
-- Spell: Shellra IV
-----------------------------------------

require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local power = 62;
	if(caster:getObjType() == TYPE_PC) then
		local power = 62 + (target:getMerit(MERIT_SHELLRA_V));
	end
	local duration = 1800;

    duration = calculateDurationForLvl(duration, 75, target:getMainLvl());
	if (target:getEquipID(SLOT_EAR1) == 11039 or target:getEquipID(SLOT_EAR2) == 11039) then -- Brachyura Earring
		power = power + 1;
	end
	if (target:getEquipID(SLOT_RING1) == 10764 or target:getEquipID(SLOT_RING2) == 10764) then -- Sheltered Ring
		power = power + 1;
	end
	
	local typeEffect = EFFECT_SHELL;
	if(target:addStatusEffect(typeEffect, power, 0, duration)) then
        spell:setMsg(230);
    else
        spell:setMsg(75); -- no effect
    end
	return typeEffect;
end;
