-----------------------------------------
-- Spell: Utsusemi: San
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	local effect = target:getStatusEffect(EFFECT_COPY_IMAGE);
	if (effect == nil) then
		target:addStatusEffectEx(EFFECT_COPY_IMAGE,EFFECT_COPY_IMAGE_4,5,0,300);
		target:setMod(MOD_UTSUSEMI, 5);
		if(caster:getEquipID(SLOT_FEET) == 11156) then
			target:setMod(MOD_UTSUSEMI, 6);
		end
		spell:setMsg(230);
	elseif (effect:getPower() <= 5) then
		effect:setPower(5);
		effect:setIcon(EFFECT_COPY_IMAGE_4);
		effect:resetStartTime();
		target:setMod(MOD_UTSUSEMI, 5);
		if(caster:getEquipID(SLOT_FEET) == 11156) then
			target:setMod(MOD_UTSUSEMI, 6);
		end
		spell:setMsg(230);
	else
		spell:setMsg(75);
	end
	return EFFECT_COPY_IMAGE;
end;