-----------------------------------
-- Area: Bastok Markets (S)
-- NPC: NPC
-----------------------------------

package.loaded["scripts/zones/Bastok_Markets_[S]/TextIDs"] = nil;
require("scripts/zones/Bastok_Markets_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT	
) ==QUEST_ACCEPTED and player:getVar("fires") ==6)then
player:startEvent(0x00A0);	
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT	
) ==QUEST_ACCEPTED and player:getVar("fires") ==7)then
player:startEvent(0x00A1);	
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
printf("CSID: %u",csid);
printf("RESULT: %u",option);
if(csid == 0x00A0)then
player:setVar("fires",7);
end
end;



