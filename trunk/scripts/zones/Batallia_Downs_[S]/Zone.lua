-----------------------------------
--
-- Zone: Batallia_Downs_[S] (84)
--
-----------------------------------

package.loaded["scripts/zones/Batallia_Downs_[S]/TextIDs"] = nil;
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/zones/Batallia_Downs_[S]/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
local csmaw = player:getVar("csmaw");
	cs = -1;	
	if(csmaw == 1) then
	cs = 0x02BC;
	elseif(player:getVar("WotgStatus") ==1) then 
	cs = 0x02BC;
	elseif((player:getXPos() == 0) and (player:getYPos() == 0) 	and (player:getZPos() == 0)) then
	player:setPos(-500.451,-39.71,504.894,39);
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
	if(csid ==0x02BC)then
	player:completeMission(WOTG,CAVERNOUS_MAWS);
	player:addMission(WOTG,BACK_TO_THE_BEGINNING);
	player:setVar("WotgStatus",0);
	end
end;	

-----------------------------------	
-- onEventFinish	
-----------------------------------	

function onEventFinish(player,csid,option)	
	--printf("CSID: %u",csid);
	--printf("RESULT: %u",option);
if(csid == 0x02BC) then
player:setVar("csmaw",0);
end
end;	
