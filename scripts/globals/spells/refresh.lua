-----------------------------------------
-- Spell: Refresh
-- Gradually restores target party member's MP
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

	local back = target:getEquipID(SLOT_BACK);
    local mp = 3;
	local duration = 150;
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end

	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
	if (caster:getEquipID(SLOT_LEGS) == 11128) then -- Estoqueurs Fuseau +2
		mp = mp + 1;
	end
	
	if (target:getMainLvl() < 41) then
		duration = duration * target:getMainLvl() / 41;
	end
	if (target:hasStatusEffect(EFFECT_SUBLIMATION_ACTIVATED) or target:hasStatusEffect(EFFECT_SUBLIMATION_COMPLETE)) then
		spell:setMsg(75);
		return 0;
	end
	if (back == 11575) then -- Grapevine Cape
		duration = duration + 30;		
	end
	
	target:delStatusEffect(EFFECT_REFRESH);
	target:addStatusEffect(EFFECT_REFRESH,mp,3,duration);

    return EFFECT_REFRESH;
end;