-----------------------------------
--
-- Zone: Full_Moon_Fountain (170)
--
-----------------------------------

package.loaded["scripts/zones/Full_Moon_Fountain/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/Full_Moon_Fountain/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	cs = -1;	
	if(player:getCurrentMission(WINDURST) == FULL_MOON_FOUNTAIN and player:getVar("WINDURST61") == 6)then
		cs = 0x0032;
	elseif ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(-260.136,2.09,-325.702,188);
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
	if(csid == 0x0032)then
		player:setVar("WINDURST61",0);
		player:completeMission(WINDURST,FULL_MOON_FOUNTAIN);
	end
end;	