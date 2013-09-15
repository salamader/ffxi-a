-----------------------------------------
-- Spell: Massacre Elegy
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
	local duration = 120;
	local power = 768;

	local bonus = AffinityBonus(caster, spell:getElement());
    local pCHR = caster:getStat(MOD_CHR);
    local mCHR = target:getStat(MOD_CHR);
    local dCHR = (pCHR - mCHR);
    local resm = applyResistance(caster,spell,target,dCHR,SINGING_SKILL,bonus);
    if(resm < 0.5) then
        spell:setMsg(85);--resist message
        return 1;
    end

    if(100 * math.random() < target:getMod(MOD_SLOWRES)) then
        spell:setMsg(85); -- resisted spell
    else
    
 	duration = duration + (duration * (caster:getMod(MOD_SONG_DURATION)/100));
 	duration = duration + (duration * ((caster:getMod(MOD_ALL_SONGS) * 10)/100));
	duration = duration + (duration * ((caster:getMod(MOD_ELEGY) * 10)/100));
	
	power = power + ((caster:getMod(MOD_ELEGY) + caster:getMod(MOD_ALL_SONGS)) * 5);
	if (power > 1024) then
		power = 1024;
	end
	
        -- Try to overwrite weaker elegy
        if(target:addStatusEffect(EFFECT_ELEGY,power,0,duration)) then
            spell:setMsg(237);
        else
            spell:setMsg(75); -- no effect
        end

    end

    return EFFECT_ELEGY;
end;