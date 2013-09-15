-----------------------------------------
-- Spell: Hyoton: San
-- Deals ice damage to an enemy and lowers its resistance against fire.
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
	--doNinjutsuNuke(V,M,caster,spell,target,hasMultipleTargetReduction,resistBonus)
	local dmg = doNinjutsuNuke(134,1,caster,spell,target,false,1.0);
	local duration = 30;
	if(caster:getObjType() == TYPE_PC) then
		dmg = dmg + caster:getMerit(MERIT_HYOTON_EFFECT);
		duration = 30 + caster:getMerit(MERIT_HYOTON_EFFECT);
	end
	handleNinjutsuDebuff(caster, target, spell, duration, 15, MOD_FIRERES);

	return dmg;

end;
