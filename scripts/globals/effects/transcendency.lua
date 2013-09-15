-----------------------------------
--	EFFECT_TRANSCENDENCY
--	Maxes your character out
--	Makes you a God
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_HP, 9999);
	target:addMod(MOD_MP, 9999);
	target:addMod(MOD_STR, 999);
	target:addMod(MOD_DEX, 999);
	target:addMod(MOD_AGI, 999);
	target:addMod(MOD_VIT, 999);
	target:addMod(MOD_INT, 999);
	target:addMod(MOD_MND, 999);
	target:addMod(MOD_CHR, 999);
	target:addMod(MOD_ATT, 999);
	target:addMod(MOD_DEF, 999);
	target:addMod(MOD_REGEN, 300);
	target:addMod(MOD_REFRESH, 300);
	target:addMod(MOD_REGAIN, 50);
	target:addMod(MOD_DMG, -90);
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_HP, 9999);
	target:delMod(MOD_MP, 9999);
	target:delMod(MOD_STR, 999);
	target:delMod(MOD_DEX, 999);
	target:delMod(MOD_AGI, 999);
	target:delMod(MOD_VIT, 999);
	target:delMod(MOD_INT, 999);
	target:delMod(MOD_MND, 999);
	target:delMod(MOD_CHR, 999);
	target:delMod(MOD_ATT, 999);
	target:delMod(MOD_DEF, 999);
	target:delMod(MOD_REGEN, 300);
	target:delMod(MOD_REFRESH, 300);
	target:delMod(MOD_REGAIN, 50);
	target:delMod(MOD_DMG, -90);
end;