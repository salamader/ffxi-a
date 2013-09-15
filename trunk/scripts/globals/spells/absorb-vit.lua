--------------------------------------
-- 	Spell: Absorb-VIT
-- 	Steals an enemy's vitality.
--------------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	local durationMods = ABSORB_SPELL_TICK + caster:getMod(MOD_ABSORB_DURATION);
	local amountMods = ABSORB_SPELL_AMOUNT + (ABSORB_SPELL_AMOUNT * (caster:getMod(MOD_ABSORB_POTENCY)/100));
	
	if(target:hasStatusEffect(EFFECT_VIT_DOWN) or caster:hasStatusEffect(EFFECT_VIT_BOOST)) then
		spell:setMsg(75); -- no effect
	else		
		local bonus = AffinityBonus(caster, spell:getElement());
		local dINT = caster:getStat(MOD_INT) - target:getStat(MOD_INT);
		local resist = applyResistance(caster,spell,target,dINT,37,bonus);
		if(resist <= 0.125) then
			spell:setMsg(85);
		else
			spell:setMsg(331);
			caster:addStatusEffect(EFFECT_VIT_BOOST,amountMods*resist, durationMods, amountMods*durationMods,FLAG_DISPELABLE); -- caster gains VIT
			target:addStatusEffect(EFFECT_VIT_DOWN,amountMods*resist, durationMods, amountMods*durationMods,FLAG_ERASBLE);    -- target loses VIT
		end
	end
	if(caster:hasStatusEffect(EFFECT_NETHER_VOID)) then
		caster:delStatusEffect(EFFECT_NETHER_VOID);
	end
	return EFFECT_VIT_DOWN;
end;