-----------------------------------
--
-- Zone: Rolanberry_Fields_[S] (91)
--
-----------------------------------

package.loaded["scripts/zones/Rolanberry_Fields_[S]/TextIDs"] = nil;
require("scripts/zones/Rolanberry_Fields_[S]/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/missions");

-----------------------------------
-- onInitialize
-----------------------------------
function onInitialize(zone)
zone:registerRegion(1,-209,1,305,-186,9.5,356);
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	cs = -1;	
if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(-376.179,-30.387,-776.159,220);
	end	
	return cs;	
end;		

-----------------------------------		
-- onRegionEnter		
-----------------------------------		

function onRegionEnter(player,region)	
if(player:getVar("WotgStatus") == 1)then
player:startEvent(0x02BC,1);
end
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
	if(csid ==0x02BC)then
	player:completeMission(WOTG,CAVERNOUS_MAWS);
	player:addMission(WOTG,BACK_TO_THE_BEGINNING);
	player:setVar("WotgStatus",0);
	end
end;	


