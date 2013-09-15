-----------------------------------
-- 
-- Zone: Monarch_Linn
-- 
-----------------------------------

require("scripts/globals/settings");
package.loaded["scripts/zones/Monarch_Linn/TextIDs"] = nil;
require("scripts/zones/Monarch_Linn/TextIDs");

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
		--player:setPos(-19,0,592,194); -- BC Exit
		--player:setPos(71,0,-1,126); -- BC Area
		player:setPos(6,0,-540,127);
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



