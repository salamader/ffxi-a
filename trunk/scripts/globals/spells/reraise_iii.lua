-----------------------------------------
-- Spell: Reraise 3
-- Durration: 1 Hr
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
    target:delStatusEffect(EFFECT_RERAISE);
    target:addStatusEffect(EFFECT_RERAISE,3,0,3600); --reraise 3, 1 hr duration

    return EFFECT_RERAISE;
end;
