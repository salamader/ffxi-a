-----------------------------------	(NOT TESTED AT ALL)
-- Area: The Eldieme Necropolis [S]
-- NPC: Turbulent Storm
-- Mission NPC
-----------------------------------

package.loaded["scripts/zones/The_Eldieme_Necropolis_[S]/TextIDs"] = nil;
require("scripts/zones/The_Eldieme_Necropolis_[S]/TextIDs");
require("scripts/globals/missions");
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
	blueRecommendationLetter = player:hasKeyItem(BLUE_RECOMMENDATION_LETTER);
	currentMission = player:getCurrentMission(WOTG);
	
	if (currentMission == BACK_TO_THE_BEGINNING and blueRecommendationLetter == false) then
		player:startEvent(0x0007);
	elseif(currentMission == BACK_TO_THE_BEGINNING and blueRecommendationLetter == true) then
		player:startEvent(0x0008);
	elseif(currentMission > BACK_TO_THE_BEGINNING) then
		player:startEvent(0x0009);
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
	if(csid == 0x0007 and option == 0) then
		player:addKeyItem(BLUE_RECOMMENDATION_LETTER);
		player:messageSpecial(KEYITEM_OBTAINED,BLUE_RECOMMENDATION_LETTER)
	end
end;