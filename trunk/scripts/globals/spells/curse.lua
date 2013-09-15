-----------------------------------------
-- Spell: Curse
-- Spell accuracy is most highly affected by 
-- Enfeebling Magic Skill, Magic Accuracy, and MND.
-- Effect -Max HP -Max MP -Move
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

	-- Calculate duration.
	local double duration = 120;

	-- Grabbing variables for paralyze potency
	local mLVL = caster:getMainLvl();
	local pMND = caster:getStat(MOD_MND);
	local mMND = target:getStat(MOD_MND);

	local dMND = (pMND - mMND);
	local multiplier = 150 / mLVL;

	-- Calculate potency.
	local potency = (multiplier * dMND) / 10;

	if potency > 25 then
		potency = 25;
	end
	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		potency = potency * 1.1;		
	end
	--printf("Duration : %u",duration);
	--printf("Potency : %u",potency);
	if(target:hasStatusEffect(EFFECT_CURSE_I)) then --effect already on, do nothing
		spell:setMsg(75);
	elseif(math.random(0,100) >= target:getMod(MOD_CURSERES)) then
		bonus = AffinityBonus(caster, spell:getElement());
		resist = applyResistance(caster,spell,target,dMND,35,bonus);

		if(resist >= 0.25) then
			if(target:addStatusEffect(EFFECT_CURSE_I,potency,0,duration*resist)) then
				spell:setMsg(236);
			else
				-- no effect
				spell:setMsg(75);
			end
		else
			-- resist
			spell:setMsg(85);
		end


	else -- resist entirely.

			spell:setMsg(85);
	end

	return EFFECT_CURSE_I;
end;
