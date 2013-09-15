-----------------------------------	(NOT TESTED AT ALL)
-- Area: Bastok Markets [S]
-- NPC: Adelbrecht
-- Mission NPC
-----------------------------------

package.loaded["scripts/zones/Bastok_Markets_[S]/TextIDs"] = nil;
require("scripts/zones/Bastok_Markets_[S]/TextIDs");
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
	
	if (currentMission == BACK_TO_THE_BEGINNING and blueRecommendationLetter == true) then
		player:startEvent(0x008b);
	elseif(currentMission == BACK_TO_THE_BEGINNING and blueRecommendationLetter == false) then
		player:startEvent(0x008c);
	elseif(currentMission > BACK_TO_THE_BEGINNING) then -- NEED TO ADD QUEST STUFF 'THE FIGHTING FOURTH'
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
	if(csid == 0x008b and option == 0) then
		player:delKeyItem(BLUE_RECOMMENDATION_LETTER);
		player:addQuest(CRYSTAL_WAR,THE_FIGHTING_FOURTH);
		player:addKeyItem(BATTLE_RATIONS);
		player:messageSpecial(KEYITEM_OBTAINED,BATTLE_RATIONS)
	end
end;