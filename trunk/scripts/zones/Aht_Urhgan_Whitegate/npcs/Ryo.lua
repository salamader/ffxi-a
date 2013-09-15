-----------------------------------
-- Area: Aht Urhgan Whitegate
-- NPC:  Ryo
-- Type: ZNM
-- @pos -127.086 0.999 22.693 50
-----------------------------------

require("scripts/globals/besieged");
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
require("scripts/globals/settings");

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	player:startEvent(0x0391);
end; 
 
function onEventSelection(player,csid,option)
	if (option == 300) then -- player asked about zeni balance
		player:updateEvent(player:getPoint(10),0);
	else
		player:updateEvent(0,0); -- first parameter serves as bitmask to delete options from main menu, needs to be reset
	end;
end;


-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end; 
 
  
-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("updateCSID: %u",csid);
--printf("updateRESULT: %u",option);
	
	if(option == 300) then
		player:updateEvent(player:getPoint(ZENI),0);
	else
		player:updateEvent(0,0);
	end
	
end;
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
end;