-----------------------------------------
-- Spell: Slow
-- Spell accuracy is most highly affected by Enfeebling Magic Skill, Magic Accuracy, and MND.
-- Slow's potency is calculated with the formula (150 + dMND*2)/1024, and caps at 300/1024 (~29.3%).
-- And MND of 75 is neccessary to reach the hardcap of Slow.
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
    if(100 * math.random() >= target:getMod(MOD_SLOWRES)) then
		local dMND = (caster:getStat(MOD_MND) - target:getStat(MOD_MND));
		local bonus = AffinityBonus(caster, spell:getElement());

		local potency = 230 + math.floor(dMND * 1.6);

		 -- ([230] + [y * 10] + [floor(dMND * 1.6)])/1024

		 if(potency > 350) then
			potency = 350;
		 end

		local merits = caster:getMerit(MERIT_SLOW_II);
		--Power.
		local power = (potency  + (merits * 10)) / 1024;

		--Duration, including resistance.
		local duration = 180 * applyResistance(caster,spell,target,dMND,35,bonus);

        if(duration >= 60) then --Do it!

            if(target:addStatusEffect(EFFECT_SLOW,power,0,duration)) then
                spell:setMsg(236);
            else
                spell:setMsg(75);
            end

        else
            spell:setMsg(85);
        end
    else
        spell:setMsg(85);
    end

    return EFFECT_SLOW;
end;