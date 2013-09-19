-----------------------------------------
--	ID: 4849
--	Scroll of Aero
--	Teaches the white magic Addle
-----------------------------------------

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	return target:canLearnSpell(286);
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addSpell(286);
end;