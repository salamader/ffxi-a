-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: "Archduke's House"
-- @zone 243
-- @pos 0.000, 0.497, 128.400
-- cutscenes 0x2798  0x27b1  0x2799  0x273d  0x27cf  0x27d0  0x279b  0x27d2  0x27d4  0x27d6
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/RuLude_Gardens/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	GetNPCByID(17772689):openDoor();
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