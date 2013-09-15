-----------------------------------
--  Area: Windurst Waters (S)
--   NPC: Dhea Prandoleh
--  Type: Standard NPC
-- @zone: 94
--  @pos: 3.167 -2 15.545
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Windurst_Waters_[S]/TextIDs"] = nil;
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if((player:hasKeyItem(959)) and (player:getQuestStatus(CRYSTAL_WAR,THE_TIGRESS_STIRS) == QUEST_AVAILABLE) and player:getVar("tigress") ==1)then
		player:startEvent(0x0080);
	elseif(player:getQuestStatus(CRYSTAL_WAR,THE_TIGRESS_STIRS) == QUEST_ACCEPTED and player:getVar("tigress") == 2)then
		player:startEvent(0x0083);
	elseif(player:getQuestStatus(CRYSTAL_WAR,THE_TIGRESS_STRIKES) == QUEST_AVAILABLE and player:getVar("tigress") == 3)then
		player:startEvent(0x0085);
	elseif(player:getVar("tigress") == 7) then
		player:startEvent(0x0086);
	else
		player:startEvent(0x00a0);
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
	if(csid == 0x0080)then
		player:addQuest(CRYSTAL_WAR,THE_TIGRESS_STIRS);
		player:delKeyItem(959);
		player:setVar("tigress",2);
	elseif(csid == 0x0085)then
		player:addQuest(CRYSTAL_WAR,THE_TIGRESS_STRIKES);
	elseif(csid == 0x0086)then
		player:completeQuest(CRYSTAL_WAR,THE_TIGRESS_STRIKES);
		player:addItem(139);
		player:messageSpecial(ITEM_OBTAINED,139);
		player:setVar("tigress",0);
	end
end;

