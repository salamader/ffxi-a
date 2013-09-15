-----------------------------------
-- 
-- Zone: Phanauet_Channel
-- 
-----------------------------------

require("scripts/globals/settings");
package.loaded["scripts/zones/Phanauet_Channel/TextIDs"] = nil;
require("scripts/zones/Phanauet_Channel/TextIDs");

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
		player:setPos(0,-2,2,192);
	end	
	return cs;	
end;

-----------------------------------
-- onRegionEnter          
-----------------------------------

function onRegionEnter(player,region)
end;
-----------------------------------		
-- onTransportEvent		
-----------------------------------		
function onTransportEvent(player,transport)
player:startEvent(0x0064);
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
if(csid == 0x0064)then
player:setPos(0,0,0,0,2)
end
end;



