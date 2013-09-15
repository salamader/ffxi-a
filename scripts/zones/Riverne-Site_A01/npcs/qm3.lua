-----------------------------------
-- Area: Riverne Site #A01
-- NPC:  ??? (qm3)
-- @zone 30
-- @pos -514.717, -6.684, -407.314
-- Quest: Spice Gals
-----------------------------------
package.loaded["scripts/zones/Riverne-Site_A01/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/settings");
require("scripts/zones/Riverne-Site_A01/TextIDs");

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