-----------------------------------------
-- ID: 15838
-- Item: Protect Earring
-- Item Effect: Protect
-----------------------------------------

require("scripts/globals/settings");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
    return 0;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)

    local power = 15;

	if (target:getEquipID(SLOT_EAR1) == 11039 or target:getEquipID(SLOT_EAR2) == 11039) then -- Brachyura Earring
		power = power + 2;
	end
	if (target:getEquipID(SLOT_RING1) == 10764 or target:getEquipID(SLOT_RING2) == 10764) then -- Sheltered Ring
		power = power + 2;
	end

    if(target:addStatusEffect(EFFECT_PROTECT, power, 0, 1800)) then
        target:messageBasic(205);
    else
        target:messageBasic(423); -- no effect
    end
end;