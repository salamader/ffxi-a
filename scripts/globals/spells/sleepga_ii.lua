-----------------------------------------
-- Spell: Sleepga II
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
	local duration = 90;
	local typeEffect = EFFECT_SLEEP_II;
	local bonus = AffinityBonus(caster, spell:getElement());
	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		bonus = bonus * 1.1;		
	end
	local pINT = caster:getStat(MOD_INT);
	local mINT = target:getStat(MOD_INT);
	local dINT = (pINT - mINT);
	local resm = applyResistance(caster,spell,target,dINT,ENFEEBLING_MAGIC_SKILL,bonus);
	if(resm < 0.5) then
		spell:setMsg(85);--resist message
		return typeEffect;
	end

	duration = duration * resm;


	if(target:addStatusEffect(typeEffect,2,0,duration)) then
		spell:setMsg(236);
	else
		spell:setMsg(75);
	end

	return typeEffect;
end;