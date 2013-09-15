-----------------------------------------
--	ID: 14657
--	Item: Ducal Guard Ring
--	Enchantment: Ducal Recal
-----------------------------------------

require("scripts/globals/teleports");
require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	result = 0;
	if (target:isZoneVisited(243) == false) then
        result = 56;
    end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	ducalGaurdRing(target);
end;
