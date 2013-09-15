-----------------------------------
-- Area: Port Jeuno
-- NPC: Guide Stone
-- Type: Standard Info NPC
-- @zone 246
-- @pos -149.990, -3.000, 0.000
-----------------------------------
package.loaded["scripts/zones/Port_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Port_Jeuno/TextIDs");

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:messageSpecial(GUIDE_STONE);
end; 

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 
  
-----------------------------------
-- onEventFinish Action
-----------------------------------

function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
end;