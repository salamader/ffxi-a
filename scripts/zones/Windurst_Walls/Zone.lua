-----------------------------------	
--	
-- Zone: Windurst_Walls (239)	
--	
-----------------------------------	

package.loaded["scripts/zones/Windurst_Walls/TextIDs"] = nil;	
require("scripts/globals/quests");
require("scripts/globals/keyitems");
require("scripts/globals/settings");	
require("scripts/zones/Windurst_Walls/TextIDs");	

-----------------------------------	
-- onInitialize	
-----------------------------------	

function onInitialize(zone)	
	zone:registerRegion(1, -2,-17,140, 2,-16,142);
	
end;			

-----------------------------------			
-- onZoneIn			
-----------------------------------			

function onZoneIn(player,prevZone)			
	cs = -1;		
	-- MOG HOUSE EXIT		
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then		
		
		if (player:getMainJob() ~= player:getVar("PlayerMainJob")) then	
			cs = 0x7534;
		end	
		player:setVar("PlayerMainJob",0);	
	end
	return cs;
end;	

-----------------------------------	
-- onRegionEnter	
-----------------------------------	

function onRegionEnter(player,region)	
	switch (region:GetRegionID()): caseof
	{
	[1] = function (x)  -- Heaven's Tower enter portal
	player:startEvent(0x56);
	end,
	}
end;	

-----------------------------------	
-- onRegionLeave	
-----------------------------------	

function onRegionLeave(player,region)	
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
	if (csid == 0x56) then	
		player:setPos(0,0,-22.40,192,242);
	elseif (csid == 0x7534 and option == 0) then	
		player:setHomePoint();
		player:messageSpecial(HOMEPOINT_SET);
	end
end;		
