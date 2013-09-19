-----------------------------------------
-- Spell: Temper
-- Author: mvd1987
-- Effect acts as a Double Attack enhancement, 
-- not Occasionally Attacks Twice
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	local base = 5;
	local power = 5 + ((target:getMod(ENHANCING_MAGIC_SKILL) - 360) / 10);
	local duration = 180;
	if(target:hasStatusEffect(EFFECT_COMPOSURE) == true) then
		duration = duration * 3;
	end

	
	if(target:hasStatusEffect(EFFECT_MULTI_STRIKES) == false) then
	
		if(target:getMod(ENHANCING_MAGIC_SKILL) <= 360) then
			target:addStatusEffect(EFFECT_MULTI_STRIKES,base,0,duration);
			
			return EFFECT_MULTI_STRIKES;
		
		elseif(target:getMod(ENHANCING_MAGIC_SKILL) > 360) then
			target:addStatusEffect(EFFECT_MULTI_STRIKES,power,0,duration);
			
			return EFFECT_MULTI_STRIKES;
		end
		
	else
		spell:setMsg(75)
		
	end
	

end;