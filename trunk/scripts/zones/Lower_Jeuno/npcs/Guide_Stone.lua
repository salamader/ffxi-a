-----------------------------------
-- Area: Lower Jeuno
-- NPC: Guide Stone
-- Type: Standard Info NPC
-- @zone 245
-- @pos 19.886, -3.000, 47.000
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