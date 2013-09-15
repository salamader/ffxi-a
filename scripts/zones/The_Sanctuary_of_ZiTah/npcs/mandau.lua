-----------------------------------
-- Area: The Sanctuary of Zitah
-- NPC:  ???
-- @zone 121
-----------------------------------
package.loaded["scripts/zones/The_Sanctuary_of_ZiTah/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/The_Sanctuary_of_ZiTah/TextIDs");
require("scripts/globals/settings");
-----------------------------------
-- onTrade
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	   if(trade:hasItemQty(18269,1) and trade:hasItemQty(1572,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1457,1) and trade:getItemCount() == 4) then
			player:startEvent(0x00cf,18270);
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
    
	if(csid == 0x00cf)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18270);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1456,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18270);
	       player:addItem(1456,30);
		   player:messageSpecial(ITEM_OBTAINED,18270);
	       player:messageSpecial(ITEM_OBTAINEDX,1456,30);    
		end
	end
end;