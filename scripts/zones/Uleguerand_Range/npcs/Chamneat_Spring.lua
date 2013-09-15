-----------------------------------
-- Area: Uleguerand Range
-- NPC:  Chamneat Spring
-- Quest: ENM Quest
-- @zone 5
-- @pos -305, 4, 18 
-----------------------------------
package.loaded["scripts/zones/Uleguerand_Range/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Uleguerand_Range/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local CottonPouch  = trade:hasItemQty(1779,1);
	if(CottonPouch == true and count == 1) then
		player:tradeComplete();
		player:addItem(1780,1); -- Chamnaet Ice
		player:messageSpecial(ITEM_OBTAINED,1780);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
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
