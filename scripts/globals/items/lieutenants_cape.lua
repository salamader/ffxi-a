-----------------------------------------
--	ID: 16230
--	Item: Lieutenants Cape
--	Enchantment: Restore 50% HP & 25% MP
--  Max Charges: 100      Use Delay: 30 secs
--  Casting Time: 8 secs  Reuse Delay: 30 mins
-----------------------------------------

require("scripts/globals/status");
require("scripts/globals/settings");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	result = 0;
	mHP = target:getMaxHP();
	cHP = target:getHP();
	mMP = target:getMaxMP();
	cMP = target:getMP();
	
	if (mHP == cHP and mMP == cMP) then
	result = 56; -- Does not let player use item if their hp and mp are full
	end
	return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	if(target:addStatusEffect(EFFECT_ENCHANTMENT) == false) then
		target:addStatusEffect(EFFECT_ENCHANTMENT,0,0,1800,14957);
	end;	
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addHP((target:getMaxHP()/100)*50);
	target:addMP((target:getMaxMP()/100)*25);
	target:messageBasic(26);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
end;