-----------------------------------
--
-- EFFECT_SPIRIT_SURGE
--
-----------------------------------

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	-- TODO: The dragoon's MAX HP increases by (25% of wyvern MAXHP)
	-- local petMaxHP = target:getPet():getMaxHP();
	-- ... but there's no LUA function to change MAX HP ... 
	
	-- The dragoon is healed by wyvern's remaining HP
	local petHP = target:getPet():getHP();
	target:addHP(petHP);
	
	-- The wyvern's current TP is transfered to the dragoon
	local petTP = target:getPet():getTP();
	target:addTP(petTP);
	
	-- The wyvern is "absorbed" into the dragoon (Call Wyvern will not allow a resummon during the effect)
	target:despawnPet();
	
	-- All Jump recast times are reset
	target:resetAbilityRecast(158);	-- Jump
	target:resetAbilityRecast(159); -- High Jump
	target:resetAbilityRecast(160); -- Super Jump
	
	-- The dragoon gets a Strength boost relative to his level
	target:addMod(MOD_STR,effect:getPower());
	
	-- The dragoon gets a 50 Accuracy boost
	target:addMod(MOD_ACC,50);
	
	-- The dragoon gets 25% Haste (256/1024, see http://wiki.bluegartr.com/bg/Job_Ability_Haste for haste calculation)
	target:addMod(MOD_HASTE_ABILITY,256);
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
	-- TODO: The dragoon's MAX HP returns to normal (when the MAXHP boost in onEffectGain() gets implemented)
	
	-- The dragoon loses the Strength boost
	target:delMod(MOD_STR,effect:getPower());
	
	-- The dragoon loses the 50 Accuracy boost
	target:delMod(MOD_ACC,50);
	
	-- The dragoon loses 25% Haste
	target:delMod(MOD_HASTE_ABILITY,256);
end;