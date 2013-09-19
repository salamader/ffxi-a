-----------------------------------
--	Area: Ru'Lud Gardens
--	NPC:  Laityn
--	Standard Info NPC
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getQuestStatus(WINDURST,RECOLLECTIONS) == QUEST_ACCEPTED and player:getVar("windurstRecollectionsCS") == 0) then
		player:startEvent(0x2713);
	elseif(player:getQuestStatus(WINDURST,RECOLLECTIONS) == QUEST_ACCEPTED and player:getVar("windurstRecollectionsCS") == 1) then
		player:startEvent(0x2714);
	elseif(player:getQuestStatus(WINDURST,RECOLLECTIONS) == QUEST_COMPLETED) then
		player:startEvent(0x2715,0x370c);
	else
		player:startEvent(0x2716);
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
	if(csid == 0x2713) then
		player:setVar("windurstRecollectionsCS",1)
	end
end;



