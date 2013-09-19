-----------------------------------
-- Large Apparatus (Left) - Holla
-- PH PM PD 
-- 1=available 2=working
-- 3=complete
-- @pos -239 -1 290 14
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
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
	elseif(player:getVar("PH") == 2)then
		player:startEvent(0x007A);
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
		player:setPos(82 ,0 ,89 ,119 ,16 );
		player:setVar("PH",2);
	elseif(csid == 0x007A and option == 0)then 
		player:setVar("PH",1);	
		player:setPos(337,19,-60,127,102);
	end
end;