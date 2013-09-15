-----------------------------------
--  Area: Port Bastok
--   NPC: Agapito
--  Type: Quest Giver
-- @zone: 236
--  @pos: -72.093 -3.097 9.309
--
-- Auto-Script: Requires Verification (Verfied by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/zones/Port_Bastok/TextIDs");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local AirshipKI = player:hasKeyItem(AIRSHIP_PASS);
	local TheStarsOfIfrit = player:getQuestStatus(BASTOK,THE_STARS_OF_IFRIT);

	if(TheStarsOfIfrit == QUEST_AVAILABLE and AirshipKI == true) then
		player:startEvent(0x00B4);
	elseif(TheStarsOfIfrit == QUEST_ACCEPTED and player:hasKeyItem(CARRIER_PIGEON_LETTER) == true) then
		player:startEvent(0x00B5);
	else
		player:startEvent(0x0011);
	end
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
	if(csid == 0x00B4) then
		player:addQuest(BASTOK,THE_STARS_OF_IFRIT);
	elseif(csid == 0x00B5) then
		player:setVar("TheStarsOfIfrit_Prog",0);
		player:addGil(GIL_RATE*2100);
		player:messageSpecial(GIL_OBTAINED,GIL_RATE*2100);
		player:addFame(BASTOK,WIN_FAME*75);
		player:addTitle(STAR_OF_IFRIT);
		player:completeQuest(BASTOK,THE_STARS_OF_IFRIT);
	end
end;
