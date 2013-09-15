-----------------------------------------
-- Spell: Curaga III
-- Restores HP of all party members within area of effect.
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
	local minCure = 270;

	local divisor = 0.6666;
	local constant = 165;
	local power = getCurePowerOld(caster);
	if(power > 460) then
		divisor = 6.5;
		constant = 354.6666;
	elseif(power > 220) then
		divisor = 2;
		constant = 275;
	end

	local final = getCureFinal(caster,spell,getBaseCureOld(power,divisor,constant),minCure,false);

	final = final + (final * (target:getMod(MOD_CURE_POTENCY_RCVD)/100));
	
	--Applying server mods....
	final = final * CURE_POWER;
	
	local diff = (target:getMaxHP() - target:getHP());
	if(final > diff) then
		final = diff;
	end
	
	local legs = caster:getEquipID(SLOT_LEGS);
	local recoverMP = 0;
	if(legs == 11226) then -- Orison's Pantaloon's +1
		recoverMP = final * .02;
		caster:addMP(recoverMP);
	end
	if(legs == 11126) then -- Orison's Pantaloon's +2
		recoverMP = final * .05;
		caster:addMP(recoverMP);
	end
	-- printf("Cure MP Recovered %u",recoverMP);
	if(recoverMP > 0) then
		caster:messageBasic(25,0,recoverMP);
	end
	
	target:addHP(final);

	target:wakeUp();
	caster:updateEnmityFromCure(target,final);
	return final;
end;