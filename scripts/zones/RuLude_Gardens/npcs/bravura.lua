-----------------------------------
--  Area: Ru'Lude Gardens
--  NPC: ??? Bravura final stage

-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
require("scripts/zones/RuLude_Gardens/TextIDs");
require("scripts/globals/settings");
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

    if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18293,1) and trade:hasItemQty(1576,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1457,1) and trade:getItemCount() == 4) then
			player:startEvent(0x2733,18294);
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
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
	
	if(csid == 0x2733)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18294);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1456,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18294);
	       player:addItem(1456,30);
		   player:messageSpecial(ITEM_OBTAINED,18294);
	       player:messageSpecial(ITEM_OBTAINEDX,1456,30);    
		end
	end
end;

