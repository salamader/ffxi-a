-----------------------------------------
-- Spell: Barwater
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

	local power = 40 + 0.2 * enchanceSkill;

	local duration = 150;

	if(enchanceSkill >180)then
		duration = 150 + 0.8 * (enchanceSkill - 180);
	end

	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end
	
	local extraBarspellEffect = 0;
	if(caster:getEquipID(SLOT_MAIN) == 17077 or caster:getEquipID(SLOT_SUB) == 17077) then
		extraBarspellEffect = 5;
	end
	
	local body = caster:getEquipID(SLOT_BODY);
	if(body == 14436 or body == 14438) then -- Blessed Briault / +1
		extraBarspellEffect = extraBarspellEffect + 5;
	end


	if(caster:hasStatusEffect(EFFECT_AFFLATUS_SOLACE) == true) then
		extraBarspellEffect = extraBarspellEffect + 5;
		if(body == 11186) then -- Orison Bliaud +1
			extraBarspellEffect = extraBarspellEffect + 5;
		elseif(body == 11086) then -- Orison Bliaud +2
			extraBarspellEffect = extraBarspellEffect + 10;
		end
	end

	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
	duration = duration + (duration * caster:getMod(MOD_BARSPELL_DUR));
	
	power = power + caster:getMod(MOD_BARSPELL_PWR);
	
	target:addStatusEffect(EFFECT_BARWATER,power,0,duration,0,1,extraBarspellEffect);

	return EFFECT_BARWATER;
end;
