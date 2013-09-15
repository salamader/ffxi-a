-----------------------------------------
-- Spell: Magic Finale
-----------------------------------------

require("scripts/globals/magic");
require("scripts/globals/status");
require("scripts/globals/settings");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
    -- Pull base stats.
    local dINT = (caster:getStat(MOD_CHR) - target:getStat(MOD_CHR));

    -- apply bonus, flash is hard to fully resist
	local bonus = 0;

	bonus = bonus + (caster:getMod(MOD_ALL_SONGS) * 10);
	bonus = bonus + (caster:getMod(MOD_FINALE) * 10);
	
	dINT = dINT + bonus;

    local resist = applyResistance(caster,spell,target,dINT,SINGING_SKILL);
    local effect = EFFECT_NONE;

    if(resist > 0.0625) then
        if(target:hasStatusEffect(EFFECT_FLASH) == false) then
            spell:setMsg(341);
            effect = target:dispelStatusEffect();
            if(effect == EFFECT_NONE) then
                -- no effect
                spell:setMsg(75);
            end
        else
            spell:setMsg(75);
        end
    else
        spell:setMsg(85);
    end

    return effect;
end;
