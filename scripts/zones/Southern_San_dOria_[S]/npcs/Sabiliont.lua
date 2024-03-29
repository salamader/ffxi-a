-----------------------------------
-- Area: Southern SandOria [S]
-- NPC: Sabiliont
-- @zone 80
-- @pos 9 2 -87
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria_[S]/TextIDs"] = nil;
require("scripts/zones/Southern_San_dOria_[S]/TextIDs");
require("scripts/globals/quests");


-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
if(player:getQuestStatus(CRYSTAL_WAR,GIFTS_OF_THE_GRIFFON) == QUEST_ACCEPTED and player:getVar("GiftsOfGriffonProg") == 6) then
		if(trade:hasItemQty(2528,1) and trade:getItemCount() == 1) then
			player:startEvent(0x01B) -- Gifts of Griffon Trade
			
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getQuestStatus(CRYSTAL_WAR,STEAMED_RAMS) == QUEST_COMPLETED)then
		player:startEvent(0x0260);
	else
		player:showText(npc, 6999); -- (Couldn't find default dialogue) What are you doing here? This is no place for civillians
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
	if(csid == 0x01B) then -- Gifts Of Griffon Trade
		player:tradeComplete();
		player:setVar("GiftsOfGriffonProg",7);
	end
end;