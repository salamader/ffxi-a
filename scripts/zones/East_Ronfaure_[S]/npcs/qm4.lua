-----------------------------------
-- ???
-- -- @pos , 541.425, -49.83, 178.563
-----------------------------------
package.loaded["scripts/zones/East_Ronfaure_[S]/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/campaign");
require("scripts/zones/East_Ronfaure_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
if(player:getQuestStatus(CRYSTAL_WAR,STEAMED_RAMS) == QUEST_ACCEPTED) then 
	if(player:hasKeyItem(PIECE_OF_SHATTERED_LUMBER))then 	player:messageSpecial(6392);
	else
	player:startEvent(0x0001);
	end
else
player:messageSpecial(6392);
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
-- onEventFinish Action
-----------------------------------

function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
	
	if(csid == 0x0001)then
	player:addKeyItem(PIECE_OF_SHATTERED_LUMBER);
	player:messageSpecial(KEYITEM_OBTAINED,PIECE_OF_SHATTERED_LUMBER);
	end
end;