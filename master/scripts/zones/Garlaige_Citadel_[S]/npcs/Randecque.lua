-----------------------------------	(NOT TESTED AT ALL)
--  Area: Garlaige Citadel [S]
--  NPC: Randecque
--  Starts Steamed Rams
--  @zone: 164
--  @pos: 61 -6 137
-----------------------------------

package.loaded["scripts/zones/Garlaige_Citadel_[S]/TextIDs"] = nil;
require("scripts/zones/Garlaige_Citadel_[S]/TextIDs");
require("scripts/globals/missions");
require("scripts/globals/keyitems");
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
	local redRecommendationLetter = player:hasKeyItem(RED_RECOMMENDATION_LETTER);
	local currentMission = player:getCurrentMission(WOTG);
	
	if (currentMission == BACK_TO_THE_BEGINNING and redRecommendationLetter == false) then
		player:startEvent(0x0001);
	elseif(currentMission == BACK_TO_THE_BEGINNING and redRecommendationLetter == true) then
		player:startEvent(0x0002);
	elseif(currentMission > BACK_TO_THE_BEGINNING) then
		player:startEvent(0x0003);
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
	if(csid == 0x0001 and option == 0) then
		player:addKeyItem(RED_RECOMMENDATION_LETTER);
		player:messageSpecial(KEYITEM_OBTAINED,RED_RECOMMENDATION_LETTER)
	end
end;