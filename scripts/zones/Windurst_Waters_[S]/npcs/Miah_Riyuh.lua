-----------------------------------
--  Area: Windurst Waters (S)
--   NPC: Miah Riyuh
--  Type: Standard NPC
-- @zone: 94
--  @pos: 5.323 -2 37.462
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
	if(player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING and player:hasKeyItem(GREEN_RECOMMENDATION_LETTER) == true and player:getVar("WotgStatus") == 4)then
		player:startEvent(0x0067);
	elseif(player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING and player:getVar("WotgStatus") == 4)then
		player:startEvent(0x0069);
	elseif(player:hasKeyItem(947))then
		player:startEvent(0x0068);
	elseif(player:getQuestStatus(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS) == QUEST_COMPLETED and (not(player:hasKeyItem(924))))then
		player:startEvent(0x006A);
	elseif(player:hasKeyItem(924))then
		player:startEvent(0x006B);
	else
		player:startEvent(0x0079);
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
	printf("CSID: %u",csid);
	printf("RESULT: %u",option);
	if(csid == 0x0069 and option == 0)then
		player:addKeyItem(ZONPAZIPPAS_ALLPURPOSE_PUTTY);
		player:messageSpecial(KEYITEM_OBTAINED,ZONPAZIPPAS_ALLPURPOSE_PUTTY);
		player:setVar("WotgStatus",0);
		player:addQuest(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS);
	elseif(csid == 0x0067)then
		player:delKeyItem(GREEN_RECOMMENDATION_LETTER);
		player:addKeyItem(ZONPAZIPPAS_ALLPURPOSE_PUTTY);
		player:messageSpecial(KEYITEM_OBTAINED,ZONPAZIPPAS_ALLPURPOSE_PUTTY);
		player:setVar("WotgStatus",0);
		player:addQuest(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS);
	elseif(csid == 0x0068 and option  ==1)then player:delKeyItem(ZONPAZIPPAS_ALLPURPOSE_PUTTY);
		player:delQuest(CRYSTAL_WAR,SNAKE_ON_THE_PLAINS);
		player:setVar("WotgStatus",4);
	end
	if(csid == 0x006A)then
		player:addKeyItem(924);
		player:addItem(15754,1);
		player:messageSpecial(ITEM_OBTAINED,15754);
		player:messageSpecial(KEYITEM_OBTAINED,BRONZE_RIBBON_OF_SERVICE);
	end
end;
-- missing title Cobra Unit Mercenary

