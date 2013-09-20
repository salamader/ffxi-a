-----------------------------------
-- Area: West Ronfaure
-- NPC:  Vilatroire
-- Involved in Quest: Introduction
-- to Teamwork.
-- @zone 100
-- @pos -263.577 -72.999 425.885 
-- 0x0036  0x0088  0x0087  0x0086
-- 0x0085  0x0084  0x0083  0x0082
-- 0x0081  
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/zones/West_Ronfaure/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	--player:startEvent(0x0083); -- Same job
	--player:startEvent(0x0085); -- Same race
	local intermedTmwrk = player:getQuestStatus(SANDORIA,INTRODUCTION_TO_TEAMWORK);
	local sFame = player:getFameLevel(SANDORIA);
	if(intermedTmwrk == QUEST_AVAILABLE and sFame >= 2) then
		player:startEvent(0x0087); -- Starts first quest - 6 members same alliance
	elseif(intermedTmwrk == QUEST_ACCEPTED) then
		player:startEvent(0x0086); -- You don't have the requirements to finish
	else
		player:startEvent(0x0088); -- Default - before quests
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
	if(csid == 0x0087) then
		player:addQuest(SANDORIA,INTRODUCTION_TO_TEAMWORK);
	end
end;