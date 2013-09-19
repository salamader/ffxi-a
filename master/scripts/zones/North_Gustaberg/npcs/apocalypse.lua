-----------------------------------
-- Area: North Gustaberg
-- NPC: ??? apocalypse final stage

-----------------------------------
package.loaded["scripts/zones/North_Gustaberg/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/North_Gustaberg/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

    if(player:getVar("relic") == 1) then
	    if(trade:hasItemQty(18305,1) and trade:hasItemQty(1577,1) and trade:hasItemQty(1589,1) and trade:hasItemQty(1451,1) and trade:getItemCount() == 4) then
			player:startEvent(0x00fe,18306);
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
--printf("CSID2: %u",csid);
--printf("RESULT2: %u",option);
end;


-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);

	if(csid == 0x00fe)then
	    if(player:getFreeSlotsCount() == 1) then
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,18306);
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINEDX,1450,30);
	    else
		   player:tradeComplete();
		   player:setVar("relic",0);
	       player:addItem(18306);
	       player:addItem(1450,30);
		   player:messageSpecial(ITEM_OBTAINED,18306);
	       player:messageSpecial(ITEM_OBTAINEDX,1450,30);    
		end
	end

end;