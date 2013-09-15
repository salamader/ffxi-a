-----------------------------------
--
-- Zone: Sauromugue_Champaign_[S] (98)
--
-----------------------------------

package.loaded["scripts/zones/Sauromugue_Champaign_[S]/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/Sauromugue_Champaign_[S]/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
zone:registerRegion(1,361,5,-228,382,14,-223);
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	cs = -1;	
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(-104,-25.36,-410,195);
	end	
	return cs;	
end;		

-----------------------------------		
-- onRegionEnter		
-----------------------------------		

function onRegionEnter(player,region)	
	if(player:getVar("WotgStatus") == 1)then
		player:startEvent(0x02BC,2);
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
