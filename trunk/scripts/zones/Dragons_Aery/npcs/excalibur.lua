-----------------------------------
-- Area: Dragons Aery
-- NPC:  ??? Excalibur final stage
-----------------------------------
package.loaded["scripts/zones/Dragons_Aery/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Dragons_Aery/TextIDs");
require("scripts/globals/settings");
-----------------------------------
-- onTrade
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	   if(trade:hasItemQty(18275,1) and trade:hasItemQty(1573,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1454,1) and trade:getItemCount() == 4) then
			player:startEvent(0x0003,18276);
		end
	end
end;

-----------------------------------
-- onTrigger
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
    
	if(csid == 0x0003)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18276);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1453,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18276);
	       player:addItem(1453,30);
		   player:messageSpecial(ITEM_OBTAINED,18276);
	       player:messageSpecial(ITEM_OBTAINEDX,1453,30);    
		end
	end
end;