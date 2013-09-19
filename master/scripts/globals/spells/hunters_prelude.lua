-----------------------------------------
-- Spell: Hunter's Prelude
-- Grants Ranged Accuracy bonus to target.
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local duration = 120;
	local sLvl = caster:getSkillLevel(SINGING_SKILL); -- Gets skill level of Singing

	duration = duration + (duration * (target:getMod(MOD_SONG_DURATION)/100));
	duration = duration + (duration * ((target:getMod(MOD_ALL_SONGS) * 10)/100));
	duration = duration + (duration * ((target:getMod(MOD_PRELUDE) * 10)/100));
	
    -- Until someone finds a way to delete Effects by tier we should not allow bard spells to stack.
    -- Since all the tiers use the same effect buff it is hard to delete a specific one.
    target:delStatusEffect(EFFECT_PRELUDE);
    target:addStatusEffect(EFFECT_PRELUDE,1,0,duration);
    spell:setMsg(230);
    return EFFECT_PRELUDE;
end;