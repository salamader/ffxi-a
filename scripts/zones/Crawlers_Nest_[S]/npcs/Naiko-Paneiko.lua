-----------------------------------
-- Area: Crawlers Nest [S]
-- NPC: Naiko-Paneiko
-- Quest NPC
-----------------------------------

package.loaded["scripts/zones/Crawlers_Nest_[S]/TextIDs"] = nil;
require("scripts/zones/Crawlers_Nest_[S]/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	scoopdedicatedLinkpearl = player:hasKeyItem(SCOOPDEDICATED_LINKPEARL);
	questStatus = player:getQuestStatus(CRYSTAL_WAR,THE_WEEKLY_ADVENTURER);
	
	if (questStatus == QUEST_AVAILABLE) then
		player:startEvent(0x0010);
	elseif(questStatus == QUEST_ACCEPTED) then		-- HAS DONE NOTHING, NEED HAS DONE, AND COMPLETED
		player:startEvent(0x0015);
	elseif(questStatus == QUEST_COMPLETED) then
		player:startEvent(0x0004);
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
	if(csid == 0x0010) then
		player:addKeyItem(SCOOPDEDICATED_LINKPEARL);
		player:messageSpecial(KEYITEM_OBTAINED,SCOOPDEDICATED_LINKPEARL);
		player:addQuest(CRYSTAL_WAR,THE_WEEKLY_ADVENTURER);
	end
end;