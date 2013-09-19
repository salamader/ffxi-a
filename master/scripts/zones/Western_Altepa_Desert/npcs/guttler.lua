-----------------------------------
-- Area: Western Altepa Desert
-- NPC:  ??? Guttler final stage

-----------------------------------
package.loaded["scripts/zones/Western_Altepa_Desert/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/Western_Altepa_Desert/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

    if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18287,1) and trade:hasItemQty(1574,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1451,1) and trade:getItemCount() == 4) then
			player:startEvent(0x00cd,18288);
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

    if(csid == 0x00cd)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18288);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1450,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18288);
	       player:addItem(1450,30);
		   player:messageSpecial(ITEM_OBTAINED,18288);
	       player:messageSpecial(ITEM_OBTAINEDX,1450,30);    
		end
	end
end;