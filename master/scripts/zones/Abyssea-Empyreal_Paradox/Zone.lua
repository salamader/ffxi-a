-----------------------------------
-- 
-- Zone: Abyssea-Empyreal_Paradox
-- 
-----------------------------------

require("scripts/globals/settings");
package.loaded["scripts/zones/Abyssea-Empyreal_Paradox/TextIDs"] = nil;
require("scripts/zones/Abyssea-Empyreal_Paradox/TextIDs");

-----------------------------------
--  onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn(player,prevZone)
	cs = -1;	
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		--player:setPos(-495,0,483,205); -- BC Area
		player:setPos(540,-500,-565,64);
	end	
	return cs;	
end;

-----------------------------------
-- onRegionEnter          
-----------------------------------

function onRegionEnter(player,region)
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;


