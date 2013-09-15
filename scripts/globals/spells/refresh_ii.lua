-----------------------------------------
-- Spell: Refresh II
-- Gradually restores target party member's MP
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell) 
    
	local back = target:getEquipID(SLOT_BACK);   
	local mp = 6; 
	local duration = 180;
	
			
	if (target:getMainLvl() < 41) then
		duration = duration * target:getMainLvl() / 41;
	end
	
	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
	if (back == 11575) then -- Grapevine Cape
		duration = duration + 30;		
	end
	if (caster:getEquipID(SLOT_LEGS) == 11128) then -- Estoqueurs Fuseau +2
		mp = mp + 2;
	end
	
	target:delStatusEffect(EFFECT_REFRESH);
	target:addStatusEffect(EFFECT_REFRESH,mp,3,duration);
    return 0;
	
end;