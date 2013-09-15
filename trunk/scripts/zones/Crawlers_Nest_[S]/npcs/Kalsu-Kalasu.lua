-----------------------------------
-- Area: Crawlers Nest [S]
-- NPC: Kalsu-Kalasu
-- Mission NPC
-----------------------------------

package.loaded["scripts/zones/Crawlers_Nest_[S]/TextIDs"] = nil;
require("scripts/zones/Crawlers_Nest_[S]/TextIDs");
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
	greenRecommendationLetter = player:hasKeyItem(GREEN_RECOMMENDATION_LETTER);
	currentMission = player:getCurrentMission(WOTG);
	
	if (currentMission == BACK_TO_THE_BEGINNING and greenRecommendationLetter == false) then
		player:startEvent(0x0001);
	elseif(currentMission == BACK_TO_THE_BEGINNING and greenRecommendationLetter == true) then
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
		player:addKeyItem(GREEN_RECOMMENDATION_LETTER);
		player:messageSpecial(KEYITEM_OBTAINED,GREEN_RECOMMENDATION_LETTER)
	end
end;