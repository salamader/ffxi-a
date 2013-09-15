-----------------------------------------
-- Spell: Odin
-- Summons Odin to fight by your side
-----------------------------------------

require("scripts/globals/pets");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	caster:spawnPet(PET_ODIN);
	return 0;
end;