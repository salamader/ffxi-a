-----------------------------------
-- Area: Beaucedine Glacier
-- NPC:  ??? Ragnarok final stage
-----------------------------------
package.loaded["scripts/zones/Beaucedine_Glacier/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Beaucedine_Glacier/TextIDs");
require("scripts/globals/settings");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

    if(player:getVar("relic") == 1) then
	   if(trade:hasItemQty(18281,1) and trade:hasItemQty(1574,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1454,1) and trade:getItemCount() == 4) then
			player:startEvent(0x008b,18282);
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
--printf("OPTION: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("OPTION: %u",option);

    if(csid == 0x008b)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18282);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1453,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18282);
	       player:addItem(1453,30);
		   player:messageSpecial(ITEM_OBTAINED,18282);
	       player:messageSpecial(ITEM_OBTAINEDX,1453,30);    
		end
	end
	
end;