-----------------------------------------
-- Spell: Sleepga
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
	local duration = 60;
	local bonus = AffinityBonus(caster, spell:getElement());
	local pINT = caster:getStat(MOD_INT);
	local mINT = target:getStat(MOD_INT);
	local dINT = (pINT - mINT);
	local resm = applyResistance(caster,spell,target,dINT,ENFEEBLING_MAGIC_SKILL,bonus);

	if (body == 11088) then -- Estoquers Sayon +2
		bonus = bonus * 1.1;		
	end
	
	if (caster:hasStatusEffect(EFFECT_SABOTEUR) == true) then
		duration = duration + (duration * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
		bonus = bonus * 2;
		caster:delStatusEffect(EFFECT_SABOTEUR);
    end
	if(resm < 0.5) then
		spell:setMsg(85);--resist message
		return EFFECT_SLEEP_I;
	end

	duration = duration * resm;

	if(target:addStatusEffect(EFFECT_SLEEP_I,1,0,duration)) then
		spell:setMsg(236);
	else
		spell:setMsg(75);
	end

	return EFFECT_SLEEP_I;
end;