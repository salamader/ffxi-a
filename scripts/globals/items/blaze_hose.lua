-----------------------------------------
--	ID: 15652
--	Item: Blaze Hose
--	Enchantment: Blaze Spikes
--	Durration: 5 Mins
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
	target:delStatusEffect(EFFECT_BLAZE_SPIKES);
	target:addStatusEffect(EFFECT_BLAZE_SPIKES,0,0,300);
end;
