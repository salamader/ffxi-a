-----------------------------------------
-- Spell: Gravity II
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

    -- Pull base stats.
    local dINT = (caster:getStat(MOD_INT) - target:getStat(MOD_INT));
    local bonus = AffinityBonus(caster,spell:getElement());
    local power = 75; -- 75% reduction
    
    local body = caster:getEquipID(SLOT_BODY);
    if (body == 11088) then -- Estoquers Sayon +2
    	power = power * 1.1;		
    end

    -- Duration, including resistance.  Unconfirmed.
    duration = 120 * applyResistance(caster,spell,target,dINT,35,bonus);

    if (caster:hasStatusEffect(EFFECT_SABOTEUR) == true) then
            duration = duration + (duration * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
            power = power + (power * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
            caster:delStatusEffect(EFFECT_SABOTEUR);
    end

    if(100 * math.random() >= target:getMod(MOD_GRAVITYRES)) then
        if(duration >= 30) then --Do it!
            target:delStatusEffect(EFFECT_WEIGHT);
            target:addStatusEffect(EFFECT_WEIGHT,power,0,duration);
                    spell:setMsg(236);
        else
                spell:setMsg(284);
        end
    else
            spell:setMsg(284);
    end
    return EFFECT_WEIGHT;
end;