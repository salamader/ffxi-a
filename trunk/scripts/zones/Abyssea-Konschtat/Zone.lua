-----------------------------------
-- 
-- Zone: Abyssea-Konschtat
-- 
-----------------------------------

-- Dev Research
-- EventID 0x0400-0x0405 aura of boundless rage
-- EventID 0x0800-0x0883 The treasure chest will disappear is 180 seconds menu.
-- EventID 0x0884 Conflux Teleport?
-- EventID 0x0885 DEBUG Menu


require("scripts/globals/settings");
package.loaded["scripts/zones/Abyssea-Konschtat/TextIDs"] = nil;
require("scripts/zones/Abyssea-Konschtat/TextIDs");

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
	player:setPos(91,-68,-583,151);
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



