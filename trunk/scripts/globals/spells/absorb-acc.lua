--------------------------------------
-- 	Spell: Absorb-ACC
-- 	Steals an enemy's accuracy.
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
	

	if(caster:hasStatusEffect(EFFECT_ACCURACY_BOOST)) then
		spell:setMsg(75); -- no effect
	else
		local bonus = AffinityBonus(caster, spell:getElement());
		local dINT = caster:getStat(MOD_INT) - target:getStat(MOD_INT);
		local resist = applyResistance(caster,spell,target,dINT,37,bonus);
		if(resist <= 0.125) then
			spell:setMsg(85);
		else
			spell:setMsg(533);
			caster:addStatusEffect(EFFECT_ACCURACY_BOOST,amountMods*resist, durationMods, amountMods*durationMods,FLAG_DISPELABLE); -- caster gains ACC
			target:addStatusEffect(EFFECT_ACCURACY_DOWN,amountMods*resist, durationMods, amountMods*durationMods,FLAG_ERASBLE);    -- target loses ACC
		end
	end
	if(caster:hasStatusEffect(EFFECT_NETHER_VOID)) then
		caster:delStatusEffect(EFFECT_NETHER_VOID);
	end
	return EFFECT_ACCURACY_BOOST;
end;