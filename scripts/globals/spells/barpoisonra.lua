-----------------------------------------
-- Spell: Barpoisonra
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local enchanceSkill = caster:getSkillLevel(34);
	local power = 1 + (0.02 * enchanceSkill);
	if(caster:getObjType() == TYPE_PC) then
		power = 1 + (0.02 * enchanceSkill) + caster:getMerit(MERIT_BAR_SPELL_EFFECT);
	end
	local duration = 150;

    if(enchanceSkill >180)then
        duration = 150 + 0.8 * (enchanceSkill - 180);
    end

	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end

	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
	local extraBarspellEffect = 0;
	local body = caster:getEquipID(SLOT_BODY);

	if(caster:hasStatusEffect(EFFECT_AFFLATUS_SOLACE) == true) then
		if(body == 11186) then -- Orison Bliaud +1
			extraBarspellEffect = extraBarspellEffect + 5;
		elseif(body == 11086) then -- Orison Bliaud +2
			extraBarspellEffect = extraBarspellEffect + 10;
		end
	end
	
	target:addStatusEffect(EFFECT_BARPOISON,power,0,duration,0,1,extraBarspellEffect);

    return EFFECT_BARPOISON;
end;
