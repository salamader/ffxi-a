-----------------------------------
-- Area: Port Jeuno
-- NPC: Cumetouflaix
-- Standard Text NPC
-- @zone 246
-- @pos -147.179, -1.000, 6.637
-----------------------------------
package.loaded["scripts/zones/Port_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Port_Jeuno/TextIDs");

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	player:messageSpecial(CUMETOUFLAIX);
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