-----------------------------------------
-- Spell: Cursna
-- Removes curse and bane from target.
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	local curse = target:getStatusEffect(EFFECT_CURSE_I);
	local curse2 = target:getStatusEffect(EFFECT_CURSE_II);
	local bane = target:getStatusEffect(EFFECT_BANE);
	local pEquipMods = 0.25;
	
	-- Equipment Bonuses
	pEquipMods = pEquipMods + (caster:getMod(MOD_CURSNA_EFFECT)/100);
	pEquipMods = pEquipMods + (target:getMod(MOD_CURSNA_RCVD)/100);
	
	spell:setMsg(75);
	if(curse ~= nil and curse2 ~= nil and bane ~= nil) then
		target:delStatusEffect(EFFECT_CURSE_I);
		target:delStatusEffect(EFFECT_CURSE_II);
		target:delStatusEffect(EFFECT_BANE);
		final = EFFECT_CURSE_II;
		spell:setMsg(83);
	elseif(curse ~= nil and bane ~= nil) then
		target:delStatusEffect(EFFECT_CURSE_I);
		target:delStatusEffect(EFFECT_BANE);
		final = EFFECT_CURSE_I;
		spell:setMsg(83);
	elseif(curse2 ~= nil and bane ~= nil) then
		target:delStatusEffect(EFFECT_CURSE_II);
		target:delStatusEffect(EFFECT_BANE);
		final = EFFECT_CURSE_II;
		spell:setMsg(83);
	elseif(curse ~= nil) then
		target:delStatusEffect(EFFECT_CURSE_I);
		final = EFFECT_CURSE_I;
		spell:setMsg(83);
	elseif(curse2 ~= nil) then
		target:delStatusEffect(EFFECT_CURSE_II);
		final = EFFECT_CURSE_II;
		spell:setMsg(83);
	elseif(bane ~= nil) then
		target:delStatusEffect(EFFECT_BANE);
		final = EFFECT_BANE;
		spell:setMsg(83);
	elseif(target:hasStatusEffect(EFFECT_DOOM) and math.random() <= pEquipMods) then
		-- remove doom
		final = EFFECT_DOOM;
		target:delStatusEffect(EFFECT_DOOM);
		spell:setMsg(359);
	end
	return final;
end;