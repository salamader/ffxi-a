-----------------------------------
-- ???
-- -- @pos , 312.821, -30.495, -67.15
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
	if(player:hasKeyItem(CHARRED_PROPELLER))then 	player:messageSpecial(6392);
	else
	player:startEvent(0x0002);
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
	
	if(csid == 0x0002)then
	player:addKeyItem(CHARRED_PROPELLER);
	player:messageSpecial(KEYITEM_OBTAINED,CHARRED_PROPELLER);
	end
end;