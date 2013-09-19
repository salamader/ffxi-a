-----------------------------------
-- Area: Upper Jeuno
-- NPC: Guide Stone
-- Type: Standard Info NPC
-- @zone 244
-- @pos 25.136, -3.000, -41.313
-----------------------------------

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