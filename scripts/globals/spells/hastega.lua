-----------------------------------------
-- Spell: Hastega
-- Composure increases duration 3x
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	local duration = 180;

	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
	   duration = duration * 3;
	end

	if (caster:getEquipID(SLOT_FEET) == 11148) then -- Estoqueurs Houseaux +2
		duration = duration * 1.2;
	elseif(caster:getEquipID(SLOT_FEET) == 11248) then -- Estoqueurs Houseaux +1
		duration = duration * 1.1;
	end
	if (caster:getEquipID(SLOT_BACK) == 16204) then -- Estoqueurs Cape
		duration = duration * 1.1;
	end
	
	local power = 150;

	if(target:addStatusEffect(EFFECT_HASTE,power,0,duration) == false) then
		spell:setMsg(75);
	end

	return EFFECT_HASTE;
end;



