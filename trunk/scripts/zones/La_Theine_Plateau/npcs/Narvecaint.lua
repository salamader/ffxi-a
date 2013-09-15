-----------------------------------
-- Area: La Theine Plateau
-- NPC:  Narvecaint
-- Involved in Mission: The Rescue Drill
-- Involved in Quest: A Timely Visit
-- @zone 102
-- @pos -263 22 129
-----------------------------------
package.loaded["scripts/zones/La_Theine_Plateau/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/quests");
require("scripts/zones/La_Theine_Plateau/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:getCurrentMission(SANDORIA) == THE_RESCUE_DRILL) then
		MissionStatus = player:getVar("MissionStatus");
		
		if(MissionStatus == 6) then
			player:startEvent(0x006b);
		elseif(MissionStatus == 7) then
			player:showText(npc, RESCUE_DRILL + 14);
		elseif(MissionStatus == 8) then
			player:showText(npc, RESCUE_DRILL + 21);
		elseif(MissionStatus >= 9) then
			player:showText(npc, RESCUE_DRILL + 26);
		else
			player:showText(npc, RESCUE_DRILL);
		end
	else
		if ((player:getQuestStatus(SANDORIA,A_TIMELY_VISIT) == 1) and (player:getVar("ATimelyVisitProgress") == 2)) then
			player:startEvent(0x0000);
		elseif ((player:getQuestStatus(SANDORIA,A_TIMELY_VISIT) == 1) and (player:getVar("ATimelyVisitProgress") == 12)) then
			player:startEvent(0x0001);
		else
			player:showText(npc, RESCUE_DRILL);
		end;
	end;
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
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
	
	if(csid == 0x006b) then
		player:setVar("MissionStatus",7);
	elseif (csid == 0x0000) then
		player:setVar("ATimelyVisitProgress",3);
	elseif (csid == 0x0001) then
		player:setVar("ATimelyVisitProgress",13);
	end;

end;	