-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Anastase
-- Type: Waypoint NPC
-- @zone 243
-- @pos -38.000, 0.001, -38.000
-- cutscenes 0x27e5  0x27e6  0x27e7  0x27e8  0x27e9  0x27ea
-- 0x27eb  0x27ec  0x27ed  0x27ee  0x27ef  0x27f0  0x27f1
-- 0x27f3  0x27f4  0x27f5  0x27f6  0x27f7  0x27f8  0x27fa  0x27f9
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
	player:startEvent(0x27E5);
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