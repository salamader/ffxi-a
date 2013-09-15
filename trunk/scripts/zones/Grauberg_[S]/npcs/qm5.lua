-----------------------------------
-- Area: grauberg
-- NPC: NPC 259.793, 33.192, 515.257
-----------------------------------

package.loaded["scripts/zones/Grauberg_[S]/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/Grauberg_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==4)then
player:startEvent(0x000B);
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
if(csid == 0x000B)then
player:setVar("fires",5);
end
end;



