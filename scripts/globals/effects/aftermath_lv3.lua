-----------------------------------
--	EFFECT AFTERMATH LVL3
--  Beneficial status effect from
--	specific WS and Weapon combination
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	if(effect:getPower() == 1) then
		-- Occasionally deal 2x Dmg in battleutils
	elseif(effect:getPower() == 2) then
		target:addMod(MOD_SUBTLE_BLOW, 10);
	elseif(effect:getPower() == 3) then
		target:addMod(MOD_CRITHITRATE, 5);
	elseif(effect:getPower() == 4) then
		target:addMod(MOD_REGEN, 8);
	elseif(effect:getPower() == 5) then
		target:addMod(MOD_ATTP, 10);
	elseif(effect:getPower() == 6) then
		target:addMod(MOD_DMG, -20);
	elseif(effect:getPower() == 7) then
		target:addMod(MOD_HASTE_ABILITY, 26);
	elseif(effect:getPower() == 8) then
		target:addMod(MOD_SPIKES, 5);
		target:addMod(MOD_SPIKES_DMG, 40);
	elseif(effect:getPower() == 9) then
		target:addMod(MOD_STORETP, 7);
	elseif(effect:getPower() == 10) then
		target:addMod(MOD_ACC, 20);
	elseif(effect:getPower() == 11) then
		target:addMod(MOD_REFRESH, 8);
	elseif(effect:getPower() == 12) then
		target:addMod(MOD_ENMITY, -20);
	elseif(effect:getPower() == 13) then
		target:addMod(MOD_RACC, 20);
	elseif(effect:getPower() == 14) then
		target:addMod(MOD_DOUBLE_ATTACK, effect:getSubPower());
	elseif(effect:getPower() == 15) then
		target:addMod(MOD_DOUBLE_ATTACK, (effect:getSubPower() * 2));
		target:addMod(MOD_TRIPLE_ATTACK, effect:getSubPower());
	elseif(effect:getPower() == 16) then
		-- Occasionally deal 2x-3x Dmg in battleutils
	end
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
	if(effect:getPower() == 1) then
		-- Occasionally deal 2x Dmg in battleutils
	elseif(effect:getPower() == 2) then
		target:delMod(MOD_SUBTLE_BLOW, 10);
	elseif(effect:getPower() == 3) then
		target:delMod(MOD_CRITHITRATE, 5);
	elseif(effect:getPower() == 4) then
		target:delMod(MOD_REGEN, 8);
	elseif(effect:getPower() == 5) then
		target:delMod(MOD_ATTP, 10);
	elseif(effect:getPower() == 6) then
		target:delMod(MOD_DMG, -20);
	elseif(effect:getPower() == 7) then
		target:delMod(MOD_HASTE_ABILITY, 26);
	elseif(effect:getPower() == 8) then
		target:delMod(MOD_SPIKES, 5);
		target:delMod(MOD_SPIKES_DMG, 40);
	elseif(effect:getPower() == 9) then
		target:delMod(MOD_STORETP, 7);
	elseif(effect:getPower() == 10) then
		target:delMod(MOD_ACC, 20);
	elseif(effect:getPower() == 11) then
		target:delMod(MOD_REFRESH, 8);
	elseif(effect:getPower() == 12) then
		target:delMod(MOD_ENMITY, -20);
	elseif(effect:getPower() == 13) then
		target:delMod(MOD_RACC, 20);
		elseif(effect:getPower() == 14) then
		target:delMod(MOD_DOUBLE_ATTACK, effect:getSubPower());
	elseif(effect:getPower() == 15) then
		target:delMod(MOD_DOUBLE_ATTACK, (effect:getSubPower() * 2));
		target:delMod(MOD_TRIPLE_ATTACK, effect:getSubPower());
	elseif(effect:getPower() == 16) then
		-- Occasionally deal 2x-3x Dmg in battleutils
	end
end;