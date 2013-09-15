-----------------------------------------
--      ID: 15769
--      Olduum Ring
--      Teleports to Wajoam Woodlands Leypoint
-----------------------------------------
 
require("scripts/globals/teleports");
require("scripts/globals/settings");
require("scripts/globals/status");
 
-----------------------------------------
-- OnItemCheck
-----------------------------------------
 
function onItemCheck(target)
	result = 0;
	if (target:isZoneVisited(51) == false) then
        result = 56;
    end
	return result;
end;
-----------------------------------------
-- OnItemUse
-----------------------------------------
 
function onItemUse(target)
	olduumRing(target);
end;
