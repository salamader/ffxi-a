-----------------------------------
-- Area: Temple of Uggalepih
-- NPC:  Granite Door
-- windurst 7-2
-- @pos 338 0 330 159
-----------------------------------
package.loaded["scripts/zones/Temple_of_Uggalepih/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/zones/Temple_of_Uggalepih/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(trade:hasItemQty(1143,1) and trade:getItemCount() == 1) 
	then
	if(player:getCurrentMission(WINDURST) == AWAKENING_OF_THE_GODS and player:getVar("WINDURST72") >=2) then
	player:startEvent(0x0017);
	else
	player:startEvent(0x0019);
	end
	else
	player:startEvent(0x002E);
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:getZPos() < 329) then
		player:messageSpecial(THE_DOOR_IS_LOCKED,1143);
	else
		player:startEvent(0x001A);
	end
	
	return 0;
	
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
	
	if(csid == 0x0017) then
		player:setVar("WINDURST72",5);
		player:delKeyItem(251);
		player:addKeyItem(252);
		player:messageSpecial(KEYITEM_OBTAINED,252);
		player:tradeComplete(trade);
	end
	
end;