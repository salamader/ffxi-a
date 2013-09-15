-----------------------------------------
-- Spell: Aisha: Ichi
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
	
	-- Base power.
	local power = 15;
	
	-- Duration, including resistance.  Unconfirmed.
	local duration = 180 * applyResistance(caster,spell,target,dINT,43,bonus);
	
		if(duration >= 90) then --Do it!
			-- Try to erase a weaker attkdown.
			local attkdown = target:getStatusEffect(EFFECT_ATTACK_DOWN)
			if(attkdown ~= nil) then
				if(attkdown:getPower() < power) then
					target:delStatusEffect(EFFECT_ATTACK_DOWN);	
					target:addStatusEffect(EFFECT_ATTACK_DOWN,power,0,duration);
					spell:setMsg(267);
				else
					spell:setMsg(75);
				end
			else
				target:addStatusEffect(EFFECT_ATTACK_DOWN,power,0,duration);
				spell:setMsg(267);

			end
		else
			spell:setMsg(284);
		end

	
	return EFFECT_ATTACK_DOWN;
	
end;