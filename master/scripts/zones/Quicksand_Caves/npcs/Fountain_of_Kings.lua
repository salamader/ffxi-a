-----------------------------------
-- Area: Quicksand Caves
-- NPC:  Fountain of Kings
-- Involved in Mission: Coming of
-- Age (Sandoria 8-1)
-- @zone 208
-- @pos 567, 18, -939
-----------------------------------
package.loaded["scripts/zones/Quicksand_Caves/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/zones/Quicksand_Caves/TextIDs");

-----------------------------------
-- onTrigger Action
-----------------------------------


function onTrigger(player,npc)

	if(player:getCurrentMission(SANDORIA) == COMING_OF_AGE and player:getVar("MissionStatus") == 2) then
		SpawnMob(17629185,180);
		SpawnMob(17629186,180);
	elseif(player:getCurrentMission(SANDORIA) == COMING_OF_AGE and player:getVar("MissionStatus") == 3) then
		player:addKeyItem(DROPS_OF_AMNIO);
		player:messageSpecial(KEYITEM_OBTAINED,DROPS_OF_AMNIO);
	else
		player:messageSpecial(POOL_OF_WATER);
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