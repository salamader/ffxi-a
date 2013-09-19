-----------------------------------
-- Area: Toraimarai Canal
-- NPC:  ??? (BLM AF6 Final ???)
-- @zone 169
-----------------------------------
package.loaded["scripts/zones/Toraimarai_Canal/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/zones/Toraimarai_Canal/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getQuestStatus(WINDURST,THE_ROOT_OF_THE_PROBLEM) == QUEST_ACCEPTED and player:getVar("windurstTheRootOfTheProblem") == 5) then
		player:startEvent(0x0030);
	elseif(player:getQuestStatus(WINDURST,THE_ROOT_OF_THE_PROBLEM) == QUEST_ACCEPTED and player:getVar("windurstTheRootOfTheProblem") == 7) then
		player:startEvent(0x0037);
	else
		player:messageSpecial(11);
	end
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
	if(csid == 0x0030) then
		if(option == 1) then
			SpawnMob(17469516,8832);
			player:setVar("windurstTheRootOfTheProblem",6)
		end
	end
end;




