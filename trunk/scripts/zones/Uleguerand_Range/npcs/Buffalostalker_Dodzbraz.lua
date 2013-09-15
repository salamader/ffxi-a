-----------------------------------
--  Area: Uleguerand Range
--  NPC: Buffalostalker Dodzbraz
--  Type: Quest NPC
--  @zone: 5
--  @pos: -380.171 -24.89 -180.797
--  Quest: Bombs Away!
-----------------------------------
package.loaded["scripts/zones/Uleguerand_Range/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local BombCores = trade:hasItemQty(18139,2);
	if(player:getQuestStatus(OTHER_AREAS,BOMBS_AWAY) ~= QUEST_AVALIABLE) then
		if(BombCores == true and count == 2) then
			player:tradeComplete();
			player:startEvent(0x0008);
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x0006);
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
	if(csid == 0x0006) then
		if(player:getQuestStatus(OTHER_AREAS,BOMBS_AWAY) == QUEST_AVALIABLE) then
			player:addQuest(OTHER_AREAS,BOMBS_AWAY);
		end
	elseif(csid == 0x0008) then
		player:addItem(5276);
		player:messageSpecial(ITEM_OBTAINED,5276);
		player:completeQuest(OTHER_AREAS,BOMBS_AWAY);
		player:addFame(OTHER_AREAS,30);
	end
end;

