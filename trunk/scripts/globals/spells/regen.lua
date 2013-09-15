-----------------------------------------
-- Spell: Regen
-- Gradually restores target's HP.
-----------------------------------------
-- Cleric's Briault enhances the effect
-- Scale down duration based on level
-- Composure increases duration 3x
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

	local hp = 5;
	local duration = 75;
	local body = caster:getEquipID(SLOT_BODY);
	local head = caster:getEquipID(SLOT_HEAD);
	local hands = caster:getEquipID(SLOT_HANDS);
	
	if(caster:getObjType() == TYPE_PC) then
		local job = caster:getMainJob();
		local sjob = caster:getSubJob();
		merit = caster:getMerit(MERIT_REGEN_EFFECT);
		if(job == JOB_WHM or sjob == JOB_WHM) then
			if(merit > 0) then
				hp = hp + merit;
			end
		end
	
		if (body == 15089 or body == 14502) then
			hp = hp+1;
		elseif (body == 10672) then
			hp = hp+2;
		end
	
		if (head == 11083) then
			hp = hp+1;
		end
	
		if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
			duration = duration * 3;
		end

		-- Estoqueurs Bonus
		duration = duration + (duration * caster:getMod(MOD_ENHANCING_DUR));
	
		if (hands == 11206) then
			duration = duration + 10;
		elseif (hands == 11106) then
			duration = duration + 15;
		end
	end
	
	hp = hp + caster:getMod(MOD_REGEN_EFFECT);
	duration = duration + caster:getMod(MOD_REGEN_DURATION);
	duration = calculateDurationForLvl(duration, 21, target:getMainLvl());

	if(target:addStatusEffect(EFFECT_REGEN,hp,3,duration)) then
		spell:setMsg(230);
	else
		spell:setMsg(75); -- no effect
	end

	return EFFECT_REGEN;
end;