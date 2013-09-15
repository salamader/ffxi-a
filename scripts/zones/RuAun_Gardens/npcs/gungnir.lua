-----------------------------------
-- Area: Ru'Aun Gardens
-- NPC:  ??? gungnir final stage
-----------------------------------
package.loaded["scripts/zones/RuAun_Gardens/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/RuAun_Gardens/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18299,1) and trade:hasItemQty(1578,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1451,1) and trade:getItemCount() == 4) then
			player:startEvent(0x003c,18300);
		end
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

    if(csid == 0x003c)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18300);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1450,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18300);
	       player:addItem(1450,30);
		   player:messageSpecial(ITEM_OBTAINED,18300);
	       player:messageSpecial(ITEM_OBTAINEDX,1450,30);    
		end
	end
end;