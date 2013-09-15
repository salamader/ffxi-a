-----------------------------------
-- Cavernous Maw
-- Teleports Players to Batallia Downs
-- @pos -48 0 435 84
-----------------------------------
package.loaded["scripts/zones/Batallia_Downs_[S]/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/teleports");
require("scripts/globals/campaign");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/zones/Batallia_Downs_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
if(player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING)then
if(player:getQuestStatus(CRYSTAL_WAR,FIRES_OF_DISCONTENT)==QUEST_COMPLETED)then player:startEvent(0x02BD);
elseif(player:getQuestStatus(CRYSTAL_WAR,CLAWS_OF_THE_GRIFFON)==QUEST_COMPLETED)then player:startEvent(0x02BD);
elseif(player:getQuestStatus(CRYSTAL_WAR,THE_TIGRESS_STRIKES)==QUEST_COMPLETED)then player:startEvent(0x02BD);
end
elseif(hasMawActivated(player,0) == false) then
player:startEvent(0x0064);
else
player:startEvent(0x0065);
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

	if(option == 1) then
		if(csid == 0x0064) then
			player:addNationTeleport(MAW,1);
		end
		toMaw(player,2);
	elseif(csid == 0x02BD)then
	player:completeMission(WOTG,BACK_TO_THE_BEGINNING);
	player:addMission(WOTG,CAIT_SITH);
	player:addNationTeleport(MAW,1);
	toMaw(player,2);
	end
	end;