-----------------------------------
-- Large Apparatus (Left) - Mea
-- PH PM PD 
-- 1=available 2=working
-- 3=complete
-- @pos 269 -81 -39 14
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("/scripts/globals/missions");
require("scripts/globals/titles");
require("scripts/zones/Hall_of_Transference/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:getVar("PromathiaStatus") == 2)then 
		player:startEvent(0x00A0);
	elseif(player:getVar("PM") == 2)then
		player:startEvent(0x0080);
	else(player:getVar("PH") ~= 3 and player:getVar("PD") ~= 3 and player:getVar("PM") ~= 3 and player:getVar("TuLiaRegistration") ~= 1)then
		player:messageSpecial(NODATA);
	end
	return 1;
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);

	if(csid == 0x00A0) then
		player:setPos(-107 ,0 ,223 ,164 ,20 ); -- tp to promy mea
		player:setVar("PM",2);
	elseif(csid == 0x0080 and option == 0)then 
		player:setVar("PM",1);
		player:setPos(179, 35, 257, 195, 117);
	end
end;