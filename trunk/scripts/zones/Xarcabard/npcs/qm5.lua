-----------------------------------
-- Area: Xarcabard
-- NPC:  ??? 
-- @zone 112
-----------------------------------
package.loaded["scripts/zones/Xarcabard/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Xarcabard/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;
-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)	

if(player:getCurrentMission(SANDORIA) == BREAKING_BARRIERS and player:getVar("MissionStatus") >= 1) then
        player:startEvent(0x000c);
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

    if(csid == 0x000c)then
	    player:setVar("MissionStatus",3);
		player:addKeyItem(FIGURE_OF_GARUDA);
		player:messageSpecial(KEYITEM_OBTAINED,FIGURE_OF_GARUDA);
	end
end;
