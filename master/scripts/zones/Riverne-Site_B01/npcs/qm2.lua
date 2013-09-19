-----------------------------------
-- Area: Riverne Site #B01
-- NPC:  ??? (qm2)
-- @zone 29
-- @pos -517.137, 0.094, 689.199
-- Quest: Spice Gals
-----------------------------------
package.loaded["scripts/zones/Riverne-Site_B01/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/settings");
require("scripts/zones/Riverne-Site_B01/TextIDs");

-----------------------------------
-- onTrade
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger
-----------------------------------

function onTrigger(player,npc)
	if(player:getQuestStatus(SANDORIA,SPICE_GALS) == QUEST_ACCEPTED or player:getQuestStatus(SANDORIA,SPICE_GALS) == QUEST_COMPLETED) then
		player:addKeyItem(RIVERNEWORT);
		player:messageSpecial(KEYITEM_OBTAINED,RIVERNEWORT);
	else
		player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
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