-----------------------------------------
-- Spell: Aquaveil
-- Reduces chance of having a spell
-- interrupted.
-----------------------------------------

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

	target:delStatusEffect(EFFECT_AQUAVEIL);

	-- duration is said to be based on enhancing skill with max 5 minutes, but I could find no
	-- tests that quantify the relationship so I'm using 5 minutes for now.

	local duration = 300;
	local power = AQUAVEIL_INTERR_RATE;
	
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end
	-- Estoqueurs Bonus
	duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));

	if (caster:getEquipID(SLOT_WAIST) == 11753) then -- Emphatikos Rope
		power = power + 12;
	end
	
	if (caster:getEquipID(SLOT_LEGS) == 10329) then -- Shedir Seraweels
		power = power + 12;
	end
	
	target:addStatusEffect(EFFECT_AQUAVEIL,power,0,duration);
		spell:setMsg(230);

	return EFFECT_AQUAVEIL;

end;