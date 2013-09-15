-----------------------------------------
-- Spell: Break
-- Petrifies enemies.
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
    local bonus = AffinityBonus(caster, spell:getElement());
    local resist = applyResistance(caster,spell,target,dINT,35,bonus);
    -- Duration, including resistance.  Unconfirmed.
    local duration = 30 * resist;

	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		bonus = bonus * 1.1;		
	end
	
	if (caster:hasStatusEffect(EFFECT_SABOTEUR) == true) then
		duration = duration + (duration * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
		caster:delStatusEffect(EFFECT_SABOTEUR);
	end

    if(resist > 0.0625) then
        if(target:addStatusEffect(EFFECT_PETRIFICATION,1,0,duration)) then
            spell:setMsg(236);
        else
            spell:setMsg(75);
        end
    else
        spell:setMsg(85);
    end

    return EFFECT_PETRIFICATION;
end;