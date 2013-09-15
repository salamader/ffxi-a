-----------------------------------------
-- Spell: Baramnesia
-----------------------------------------
require("scripts/globals/magic");
require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local duration = 150;
	local enchanceSkill = caster:getSkillLevel(34);
	local power = 40 + 0.2 * enchanceSkill;
	
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster == target) then
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
	
    target:delStatusEffect(EFFECT_BARAMNESIA);
    target:addStatusEffect(EFFECT_BARAMNESIA,power,0,duration,0,1,extraBarspellEffect);
end;