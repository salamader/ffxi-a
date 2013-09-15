-----------------------------------------
-- Spell: Chocobo Mazurka
-- Gives party members enhanced movement
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
	local power = 24;
	
 	duration = duration + (duration * (caster:getMod(MOD_SONG_DURATION)/100));
 	duration = duration + (duration * ((caster:getMod(MOD_ALL_SONGS) * 10)/100));
	duration = duration + (duration * ((caster:getMod(MOD_MAZURKA) * 10)/100));
	
	power = power + ((target:getMod(MOD_MAZURKA) + target:getMod(MOD_ALL_SONGS)) * 4);
	
	
    -- Until someone finds a way to delete Effects by tier we should not allow bard spells to stack.
    -- Since all the tiers use the same effect buff it is hard to delete a specific one.
    target:addStatusEffect(EFFECT_MAZURKA,power,0,duration);
    return EFFECT_MAZURKA;
end;

