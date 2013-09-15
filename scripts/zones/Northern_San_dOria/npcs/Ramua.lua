-----------------------------------
--  Area: Northern San d'Oria
--  NPC: Ramua
--  Type: Recipe Giver
--  @zone: 231
--  @pos: -183.750 10.999 255.770
--  Quest: Forest for the Trees 
-----------------------------------
package.loaded["scripts/zones/Northern_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/zones/Northern_San_dOria/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local AshLog = trade:hasItemQty(698,1);
	local ArrowwoodLog = trade:hasItemQty(688,1);
	local YewLog = trade:hasItemQty(696,1);
	local WillowLog = trade:hasItemQty(695,1);
	local WalnutLog = trade:hasItemQty(693,1);
	
	if(player:getQuestStatus(SANDORIA,FOREST_FOR_THE_TREES) == QUEST_ACCEPTED) then
		if(AshLog == true and ArrowwoodLog == true and YewLog == true and WillowLog == true and WalnutLog == true and count == 5) then
			if(player:getVar("timberChecklistAsh") == 1 and player:getVar("timberChecklistArrow") == 1 and player:getVar("timberChecklistWillow") == 1 and player:getVar("timberChecklistYew") == 1 and player:getVar("timberChecklistWalnut") == 1) then
				player:startEvent(0x035C);
			elseif(player:getVar("timberChecklistAsh") == 0 or player:getVar("timberChecklistArrow") == 0 or player:getVar("timberChecklistWillow") == 0 or player:getVar("timberChecklistYew") == 0 or player:getVar("timberChecklistWalnut") == 0) then
				player:startEvent(0x035B);
			end
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(isGuildMember(player,9) == 1 and player:getQuestStatus(SANDORIA,FOREST_FOR_THE_TREES) == QUEST_AVALIABLE) then
		player:startEvent(0x0358);
	elseif(player:getQuestStatus(SANDORIA,FOREST_FOR_THE_TREES) == QUEST_ACCEPTED and player:getVar("timberSurvey") == 0) then
		player:startEvent(0x035A);
	elseif(player:getQuestStatus(SANDORIA,FOREST_FOR_THE_TREES) == QUEST_COMPLETED) then
		player:startEvent(0x035D);
	else
		player:startEvent(0x0230);
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
	if(csid == 0x0358) then
		if (player:getFreeSlotsCount() == 0) then
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,1021);
		else
			player:addQuest(SANDORIA,FOREST_FOR_THE_TREES);
			player:addItem(1021,1);
			player:messageSpecial(ITEM_OBTAINED,1021);
			player:addKeyItem(TIMBER_SURVEY_CHECKLIST);
			player:messageSpecial(KEYITEM_OBTAINED,TIMBER_SURVEY_CHECKLIST);
		end
	elseif(csid == 0x035C) then
		player:tradeComplete();
		player:addItem(18502,1);
		player:messageSpecial(ITEM_OBTAINED,18502);
		player:completeQuest(SANDORIA,FOREST_FOR_THE_TREES);
		player:addFame(SANDORIA,30*SAN_FAME);
		player:setVar("timberChecklistAsh",0);
		player:setVar("timberChecklistArrow",0);
		player:setVar("timberChecklistYew",0);
		player:setVar("timberChecklistWillow",0);
		player:setVar("timberChecklistWalnut,0");
		player:setVar("timberSurvey",0);
		player:delKeyItem(TIMBER_SURVEY_CHECKLIST);
	end
end;