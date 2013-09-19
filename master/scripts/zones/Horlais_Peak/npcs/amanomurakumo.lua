-----------------------------------
-- Area: Horlais Peak
-- NPC: ??? amanomurakumo final stage
-- @Zone: 139
-----------------------------------
package.loaded["scripts/zones/Horlais_Peak/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/Horlais_Peak/TextIDs");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18317,1) and trade:hasItemQty(1580,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1454,1) and trade:getItemCount() == 4) then
			player:startEvent(0x000d,18318);
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

    if(csid == 0x000d)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18318);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1453,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18318);
	       player:addItem(1453,30);
		   player:messageSpecial(ITEM_OBTAINED,18318);
	       player:messageSpecial(ITEM_OBTAINEDX,1453,30);    
		end
	end
end;