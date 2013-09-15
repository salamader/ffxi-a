-----------------------------------------
-- Spell: Kakka: Ichi
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	target:delStatusEffect(EFFECT_STORE_TP);
	target:addStatusEffect(EFFECT_STORE_TP,EFFECT_STORE_TP,10,0,180);
	spell:setMsg(230);
	
	return EFFECT_STORE_TP;
end;