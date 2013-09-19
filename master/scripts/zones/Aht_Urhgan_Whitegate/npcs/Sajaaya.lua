-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Sajaaya
--  Type: Weather Checker
-- @zone: 50
--  @pos: -4.727 -6.999 -25.312
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	birth = 1009810800;
	timer = os.time();
	counter = (timer - birth);
	player:startEvent(0x01f6,0,0,0,0,0,0,0,counter);
end; 


-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end;  
  
-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
end;