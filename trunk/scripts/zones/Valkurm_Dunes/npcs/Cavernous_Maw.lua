-----------------------------------
-- Area: Valkurm Dunes
-- Name: Cavernous Maw
-- Teleports Players to Abyssea
-- Misareaux
-- @zone 103
-- @pos 368.980, -0.443, -119.874
-----------------------------------
package.loaded["scripts/zones/Valkurm_Dunes/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/teleports");
require("scripts/globals/missions");
require("scripts/globals/campaign");
require("scripts/zones/Valkurm_Dunes/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x0037,1,1,1,1,1,1,1);	
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
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
	if(csid == 0x0037 and option == 1) then
		player:setPos(670,-15,318,119,216);
	end
end;