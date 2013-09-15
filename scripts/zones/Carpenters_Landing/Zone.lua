-----------------------------------
--
-- Zone: Carpenters_Landing (2)
--
-----------------------------------

package.loaded["scripts/zones/Carpenters_Landing/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/Carpenters_Landing/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
	zone:registerRegion(1,216,-5,-532,232,1,-526);
	zone:registerRegion(2,237,-6,-540,250,1,-513);
	zone:registerRegion(3,-142,-5,50,-137,1,64);
	zone:registerRegion(4,-153,-5,64,-97,1,81);
	zone:registerRegion(5,-313,-5,498,-299,1,505);
	zone:registerRegion(6,-296,-5,497,-292,2,533);
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)
	local carpenter = player:getVar("carpenter");		
	cs = -1;	
	if((prevZone == 1) and (carpenter == 4))then
		cs = 0x000B;
	elseif((prevZone == 1) and (carpenter == 5))then
		cs = 0x000A;
	elseif((prevZone == 1) and (carpenter == 6))then
		cs = 0x000F;
	elseif ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
		player:setPos(6.509,-9.163,-819.333,239);
	end	
	return cs;	
end;		

-----------------------------------		
-- onRegionEnter		
-----------------------------------		

function onRegionEnter(player,region)	

	switch (region:GetRegionID()): caseof
	{
			[1] = function (x)  
			player:setVar("carpenter",0)
			printf("Entering Region 1");
		end,
			[2] = function (x)  
			player:setVar("carpenter",1)
			printf("Entering Region 2");
		end,
			[3] = function (x)  
			player:setVar("carpenter",0)
			printf("Entering Region 3");
		end,
			[4] = function (x)  
			player:setVar("carpenter",2)
			printf("Entering Region 4");
		end,
			[5] = function (x)  
			player:setVar("carpenter",0)
			printf("Entering Region 5");
		end,
			[6] = function (x)  
			player:setVar("carpenter",3)
			printf("Entering Region 6");
		end,

	}
end;	


-----------------------------------	
-- onRegionLeave	
-----------------------------------	

function onRegionLeave(player,region)
	switch (region:GetRegionID()): caseof
	{
			[2] = function (x)  
			player:setVar("carpenter",4);
		end,
			[4] = function (x)  
			player:setVar("carpenter",5)
		end,
			[6] = function (x)  
			player:setVar("carpenter",6)
		end,

	}
end;	

-----------------------------------		
-- onTransportEvent		
-----------------------------------		
function onTransportEvent(player,transport)

	if(player:getVar("carpenter") == 1) then
		player:startEvent(0x0011);
	end
	if(player:getVar("carpenter") == 2) then
		player:startEvent(0x0000E);
	end
	if(player:getVar("carpenter") == 3) then
		player:startEvent(0x0010);
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
	if(csid == 0x000E) then
		player:setPos(0,0,0,0,1)
	end
	if(csid == 0x000b) then
		player:startEvent(0x000d)
	end
	if(csid == 0x0010) then
		player:setPos(0,0,0,0,1)
	end
	if (csid == 0x000A) then
		player:startEvent(0x000c)
	end
	if(csid == 0x0011) then
		player:setPos(0,0,0,0,1)
	end
	if (csid == 0x000f) then
		player:setPos(-135,-1,61,106)
	end
end;	

