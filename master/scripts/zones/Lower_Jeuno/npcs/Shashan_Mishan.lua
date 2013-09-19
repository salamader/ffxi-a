-----------------------------------
-- 	Shashan-Mishan
-- 	Gives weather reports.
-----------------------------------

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	birth = 1009810800;
	timer = os.time();
	counter = (timer - birth);
	player:startEvent(0x8271c,0,0,0,0,0,0,0,counter);
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