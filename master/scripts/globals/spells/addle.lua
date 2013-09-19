-----------------------------------------
-- Spell: Addle
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

	local power = 20;

	-- Duration
	local duration = 120

	-- Equipment bonus
	local back = caster:getEquipID(SLOT_BACK);
	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		power = power * 1.1;		
	end	
	if (back == 10977) then -- Romanus Cape 6% Addle Bonus
		duration = duration + (duration * .06);		
	end
	
	if (caster:hasStatusEffect(EFFECT_SABOTEUR) == true) then
	        duration = duration + (duration * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
	        power = power + (power * (1 + (caster:getMod(MOD_SABOTEUR)/100)));
	        caster:delStatusEffect(EFFECT_SABOTEUR);
    	end
	
	if(100 * math.random() >= target:getMod(MOD_SILENCERES)) then -- Silence resist used instead of addle resist for now.
		if(target:addStatusEffect(EFFECT_ADDLE,power,0,duration)) then
			spell:setMsg(236);
		else
			spell:setMsg(75);
		end
	else
		spell:setMsg(284);
	end
	return EFFECT_ADDLE;
end;