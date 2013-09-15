-----------------------------------
-- Area: The Sanctuary of Zitah
-- NPC:  ??? mjollnir final stage
-- @zone 121

-----------------------------------
package.loaded["scripts/zones/The_Sanctuary_of_ZiTah/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/zones/The_Sanctuary_of_ZiTah/TextIDs");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18323,1) and trade:hasItemQty(1581,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1454,1) and trade:getItemCount() == 4) then
			player:startEvent(0x00d8,18324);
		end
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)	
player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
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

    if(csid == 0x00d8)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18324);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1453,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18324);
	       player:addItem(1453,30);
		   player:messageSpecial(ITEM_OBTAINED,18324);
	       player:messageSpecial(ITEM_OBTAINEDX,1453,30);    
		end
	end
end;