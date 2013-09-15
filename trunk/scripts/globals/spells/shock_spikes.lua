-----------------------------------------
-- Spell: Shock Spikes
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local duration = SPIKE_EFFECT_DURATION;
	local legs = caster:getEquipID(SLOT_LEGS);
  	local typeEffect = EFFECT_SHOCK_SPIKES;
  	
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end

	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
    local int = caster:getStat(MOD_INT);
    local magicAtk = caster:getMod(MOD_MATT);
    local power = ((int + 10) / 20 + 2) * (1 + (magicAtk / 100));

    	-- Equipment Bonus Amount
    	if (legs == 15622) then -- Mercenarys Trousers
		power = ((int + 2) / 12 + 4) * (1 + (magicAtk / 100)) + (int * (4/256));
	elseif (legs == 15121 or legs == 15584) then -- Duelist Tights & +1
		power = ((int + 2) / 12 + 4) * (1 + (magicAtk / 100)) + (int * (6/256));
	elseif (legs == 10714) then -- Duelist Tights +2
		power = ((int + 2) / 12 + 4) * (1 + (magicAtk / 100)) + (int * (8/256));
	end
	
   if(target:addStatusEffect(typeEffect,power,0,duration)) then
     spell:setMsg(230);
   else
     spell:setMsg(75);
   end

    return typeEffect;
end;
