-----------------------------------
-- 	Passenger6
-- 	Basic Chat Text
-----------------------------------

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	player:startEvent(0x0075);
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