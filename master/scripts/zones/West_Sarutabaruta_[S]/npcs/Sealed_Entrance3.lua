-----------------------------------
--  Area: West Sarutabaruta [S]
--  NPC:  '-340.000', '1.825', '-364.825', 95
-----------------------------------
package.loaded["scripts/zones/West_Sarutabaruta_[S]/TextIDs"] = nil;
-------------------------------------


require("scripts/globals/settings");
require("scripts/zones/West_Sarutabaruta_[S]/TextIDs");
require("scripts/globals/keyitems");
require("scripts/globals/quests");



-----------------------------------
-- onTrigger
-----------------------------------
function onTrigger(player,npc)
local apply1 = player:getVar("apply1");
local apply2 = player:getVar("apply2");
local apply3 = player:getVar("apply3");


if(player:hasKeyItem(947))then 
	if(apply3 == 0)then 
			if(apply1 == 0 and apply2 ==0)then
			player:messageSpecial(REPAIR_1,947);
			player:setVar("apply3",1);	
			elseif(apply1 == 0 and apply2 ==1)then
			player:messageSpecial(REPAIR_1,947);
			player:setVar("apply3",1);	
			elseif(apply1 == 1 and apply2 ==0)then
			player:messageSpecial(REPAIR_1,947);
			player:setVar("apply3",1);	
			elseif(apply1 == 1 and apply2 == 1)then 					player:messageSpecial(REPAIR_2,947);
			player:delKeyItem(947);
			player:setVar("apply1",0);
			player:setVar("apply2",0);
		player:completeQuest(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS);
			end
	elseif(apply3 == 1)then
	player:messageSpecial(REPAIR_3,947);
	end
elseif(player:getQuestStatus(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS) == QUEST_COMPLETED)then
player:messageSpecial(REPAIR_3,947);
else
player:messageSpecial(REPAIR_0);
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
end;
