-----------------------------------
-- Area: Bastok Markets (S)
-- NPC: NPC -80.085, -4.425, -125.327
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
if(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==0)then
player:startEvent(0x0074);
elseif(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==1)then
player:startEvent(0x0075);
elseif(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==4 and player:hasKeyItem(XHIFHUT)) then
player:startEvent(0x0076);
-- elseif(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) == QUEST_COMPLETED)then player:startEvent(0x0077); (while waiting 00:00)
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_AVAILABLE and player:getVar("fires") ==0)then
player:startEvent(0x0078);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==1)then
player:startEvent(0x0079);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==3)then
player:startEvent(0x007C);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==4)then
player:startEvent(0x007D);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==5)then
player:startEvent(0x007E);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==6)then
player:startEvent(0x007F);
elseif(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT) == QUEST_ACCEPTED and player:getVar("fires") ==7)then
player:startEvent(0x00A4);
else
player:startEvent(0x0068);	
end
return cs;
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
if(csid == 0x0074)then
player:setVar("bpov",1);
elseif(csid == 0x0076)then
player:setVar("bpov",0);
player:delKeyItem(XHIFHUT);
player:addGil(GIL_RATE*10000);
player:messageSpecial(GIL_OBTAINED,GIL_RATE*10000);
player:addKeyItem(WARNING_LETTER);
player:messageSpecial(KEYITEM_OBTAINED,WARNING_LETTER);
player:completeQuest(CRYSTAL_WAR,BETTER_PART_OF_VALOR);
elseif(csid == 0x0078 and option == 0)then
player:addQuest(CRYSTAL_WAR,FIRES_OF_DISCONTENT);
player:setVar("fires",1);
elseif(csid == 0x007c)then
player:setVar("fires",4);
elseif(csid == 0x007e)then
player:setVar("fires",6);
elseif(csid == 0x00A4)then
player:setVar("fires",0);
player:completeQuest(CRYSTAL_WAR,FIRES_OF_DISCONTENT);
player:addGil(GIL_RATE*10000);
player:messageSpecial(GIL_OBTAINED,GIL_RATE*10000);
end
end;



