-----------------------------------
-- Area: Valley of Sorrows
-- NPC:  ??? 
-----------------------------------
package.loaded["scripts/zones/Valley_of_Sorrows/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Valley_of_Sorrows/TextIDs");
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
        player:startEvent(0x0000);
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

    if(csid == 0x0000)then
	    player:setVar("MissionStatus",2);
		player:addKeyItem(FIGURE_OF_TITAN);
		player:messageSpecial(KEYITEM_OBTAINED,FIGURE_OF_TITAN);
	end
end;
