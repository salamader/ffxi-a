-----------------------------------
--  Area: West_Ronfaure
--  NPC: Stone Monument
--  Involved in quest "An Explorer's Footsteps"
-----------------------------------
package.loaded["scripts/zones/West_Ronfaure/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/West_Ronfaure/TextIDs");

-----------------------------------
-- onTrigger
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x0384);
end;

-----------------------------------
-- onTrade
-----------------------------------

function onTrade(player,npc,trade)
	if (trade:getItemCount() == 1 and trade:hasItemQty(571,1)) then
		player:tradeComplete();
		player:addItem(570);
		player:specialMessage(ITEM_OBTAINED,570);
		player:setVar("anExplorer-CurrentTablet",0x00001);
	end
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
end;