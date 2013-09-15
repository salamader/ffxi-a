-----------------------------------
-- Area: Hall of Transference
-- NPC: Large Apparatus (Right) Mea
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/zones/Hall_of_Transference/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local ClearChip = trade:hasItemQty(478,1);
	if(ClearChip == true and count == 1) then
		player:tradeComplete();
		player:startEvent(0x00A4);
		player:setVar("LargeApparatusMea",1);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getVar("LargeApparatusMea") < 1) then 
		player:startEvent(0x00A3); -- Something to due with having the keyitem missing chip
	end
	if(player:getVar("LargeApparatusMea") == 1 and player:getVar("TuLiaRegistration") == 1) then 
		if(math.random(0,100) <= 5) then
			player:setVar("LargeApparatusMea",0); -- Clear Chip broke
		end
		player:startEvent(0x0078);
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
	if(csid == 0x00A4) then
		player:messageSpecial(REPAIRED);
	elseif(csid == 0x0078 and option == 0) then
		player:setPos(-134, -32, -206, 195, 130);
	end
end;