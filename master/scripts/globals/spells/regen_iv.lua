-----------------------------------------
-- Spell: Regen IV
-- Gradually restores target's HP.
-----------------------------------------
-- Cleric's Briault enhances the effect
-- Scale down duration based on level
-- Composure increases duration 3x
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	local hp = 30;
	local duration = 60;
	local body = caster:getEquipID(SLOT_BODY);
	local head = caster:getEquipID(SLOT_HEAD);
	local hands = caster:getEquipID(SLOT_HANDS);

	if(caster:getObjType() == TYPE_PC) then
		local job = caster:getMainJob();
		local sjob = caster:getSubJob();
		local merit = caster:getMerit(MERIT_REGEN_EFFECT);
		if(job == JOB_WHM or sjob == JOB_WHM) then
			if(merit > 0) then
				hp = hp + merit;
			end
		end
	
		if (body == 15089 or body == 14502) then
			hp = hp+4;
		elseif (body == 10672) then
			hp = hp+7;
		end
		if (head == 11083) then
			hp = hp+4;
		end
		if (hands == 11206) then
			duration = duration + 10;
		elseif (hands == 11106) then
			duration = duration + 15;
		end
	
	duration = duration + caster:getMod(MOD_REGEN_DURATION);
	hp = hp + caster:getMod(MOD_REGEN_EFFECT);

	if (target:getMainLvl() < 21) then
		duration = duration * target:getMainLvl() / 21;
	end

	if(target:addStatusEffect(EFFECT_REGEN,hp,3,duration)) then
		spell:setMsg(230);
	else
		spell:setMsg(75); -- no effect
	end

	return EFFECT_REGEN;

end;