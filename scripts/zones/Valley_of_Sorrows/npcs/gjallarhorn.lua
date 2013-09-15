-----------------------------------
-- Area: Valley of Sorrows
-- NPC:  ??? gjallarhorn final stage
-----------------------------------
package.loaded["scripts/zones/Valley_of_Sorrows/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/Valley_of_Sorrows/TextIDs");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18341,1) and trade:hasItemQty(1584,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1451,1) and trade:getItemCount() == 4) then
			player:startEvent(0x000f,18342);
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

    if(csid == 0x000f)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18342);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1450,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18342);
	       player:addItem(1450,30);
		   player:messageSpecial(ITEM_OBTAINED,18342);
	       player:messageSpecial(ITEM_OBTAINEDX,1450,30);    
		end
	end
end;