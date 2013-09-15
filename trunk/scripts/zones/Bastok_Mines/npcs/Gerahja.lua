-----------------------------------
-- Area: Bastok Markets
-- NPC: Gerahja
-- VCS Trainer NPC
-- Quest: Kamp Kweh
-- @zone 234
-- @pos 54.161, 0.871, -96.057
-----------------------------------
package.loaded["scripts/zones/Bastok_Mines/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Bastok_Mines/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getVar("Gerahja_Event") == 0) then
		player:startEvent(0x021F);
	else
		player:startEvent(0x0220);
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
	if(csid == 0x021F) then
		player:setVar("Gerahja_Event",1);
	end
end;



