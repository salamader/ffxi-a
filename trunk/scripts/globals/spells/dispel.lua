-----------------------------------------
-- Spell: Dispel
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
    local dINT = (caster:getStat(MOD_INT) - target:getStat(MOD_INT));

    local resist = applyResistance(caster,spell,target,dINT,ENFEEBLING_MAGIC_SKILL);

	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		dINT = dINT * 1.1;		
	end

    local effect = EFFECT_NONE;

    if(resist > 0.0625) then
		spell:setMsg(341);
		local effect = target:dispelStatusEffect();
		if(effect == EFFECT_NONE) then
			-- no effect
			spell:setMsg(75);
		end
	else
        spell:setMsg(85);
    end

    return effect;
end;
