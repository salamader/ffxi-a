-----------------------------------------
--  ID: 15320
--  Item: Sneaking Boots
--  Enchantment: Sneak
--  Charges: 15  Recast: 60 Mins
-----------------------------------------

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
    return 0;
end;
-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	local duration = 180;
	duration = duration + (duration * target:getMod(MOD_SNEAK_DUR));
	target:delStatusEffect(EFFECT_SNEAK);
	target:addStatusEffect(EFFECT_SNEAK,1,0,duration);
end;
