-----------------------------------
-- Area: Uleguerand Range
-- NPC:  ??? (qm3)
-- Quest: Over the Hills and Far Away
-- @zone 5
-- @pos -300, -52, -19
-----------------------------------
package.loaded["scripts/zones/Uleguerand_Range/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/zones/Uleguerand_Range/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	if(player:getQuestStatus(SANDORIA,OVER_THE_HILLS_AND_FAR_AWAY) == QUEST_ACCEPTED player:getVar("overtheHills") == 1) then 
		local count = trade:getItemCount();
		local MoblinHotrok  = trade:hasItemQty(1729,1);
		if(MoblinHotrok == true and count == 1) then
			player:tradeComplete();
			player:startEvent(0x000A);
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
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
	if(csid == 0x000A) then
		player:addKeyItem(MAP_OF_THE_ULEGUERAND_RANGE);
		player:messageSpecial(KEYITEM_OBTAINED,MAP_OF_THE_ULEGUERAND_RANGE);
		player:completeQuest(SANDORIA,OVER_THE_HILLS_AND_FAR_AWAY);
		player:addFame(SANDORIA,60*SAN_FAME);
		player:setVar("overtheHills", 0);
	end
end;
