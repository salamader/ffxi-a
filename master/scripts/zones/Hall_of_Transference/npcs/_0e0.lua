-----------------------------------
-- Cermet Gate - Holla
-- 
-- @pos -219 -6 280 14
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
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

	if(player:getCurrentMission(COP) >= BELOW_THE_ARKS and (player:getVar("PH") <= 1 and 
	player:getVar("PD") <= 1 and player:getVar("PM") <= 1) and player:getVar("PromathiaStatus") == 2)then
		player:startEvent(0x00A0);
	elseif(player:getCurrentMission(COP) >= BELOW_THE_ARKS and player:getVar("PH") <= 3
	and player:getVar("PD") ~= 2 and player:getVar("PM") ~= 2)then
		player:startEvent(0x0096);
	else
		player:messageSpecial(DOOR_IS_CLOSED);
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
		player:setVar("PH",2);
		player:setPos(82 ,0 ,89 ,119 ,16); -- tp to promy holla
	end
	if(csid == 0x0096 and option == 1) then
		player:setPos(82 ,0 ,89 ,119 ,16); -- tp to promy holla
	end

end;