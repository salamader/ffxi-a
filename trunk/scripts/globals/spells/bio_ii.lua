-----------------------------------------
-- Spell: Bio II
-- Deals dark damage that weakens an
-- enemy's attacks and gruadually reduces
-- its HP.
-----------------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	--calculate raw damage
	local basedmg = caster:getSkillLevel(DARK_MAGIC_SKILL) / 4;
	local dmg = calculateMagicDamage(basedmg,2,caster,spell,target,DARK_MAGIC_SKILL,MOD_INT,false);

	-- Softcaps at 50, should always do at least 1
	if(dmg > 50) then
		dmg = 50;
	end
	if(dmg < 1) then
		dmg = 1;
	end

	--get resist multiplier (1x if no resist)
	local resist = applyResistance(caster,spell,target,caster:getStat(MOD_INT)-target:getStat(MOD_INT),DARK_MAGIC_SKILL,1.0);
	--get the resisted damage
	dmg = dmg*resist;
	--add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
	dmg = addBonuses(caster,spell,target,dmg);
	--add in target adjustment
	dmg = adjustForTarget(target,dmg);
	--add in final adjustments including the actual damage dealt
	local final = finalMagicAdjustments(caster,target,spell,dmg);

	-- Calculate duration.
	local duration = 120;

	-- Check for Dia.
	local dia = target:getStatusEffect(EFFECT_DIA);

	-- Calculate DoT (rough, though fairly accurate)
	local dotdmg = 0;
	local darkSkill = caster:getSkillLevel(DARK_MAGIC_SKILL);
	if(darkSkill <199)then
	        dotdmg = 4;
	elseif(darkSkill >=200 and darkSkill <=210)then
	    	dotdmg = 5;
	elseif(darkSkill >=211 and darkSkill <=268)then
	    	dotdmg = 6;
	elseif(darkSkill >=269 and darkSkill <=290)then
	    	dotdmg = 7;
	elseif(darkSkill >=291)then
	    	dotdmg = 8;
	end

	-- Do it!
	if(dia == nil or (BIO_OVERWRITE == 0 and dia:getPower() <= 2) or (BIO_OVERWRITE == 1 and dia:getPower() < 2)) then
		target:delStatusEffect(EFFECT_BIO); -- delete old bio
		target:addStatusEffect(EFFECT_BIO,dotdmg,3,duration,FLAG_ERASABLE, 10);
	end

	--Try to kill same tier Dia (default behavior)
	if(DIA_OVERWRITE == 1 and dia ~= nil) then
		if(dia:getPower() <= 2) then
			target:delStatusEffect(EFFECT_DIA);
		end
	end

	return final;

end;
