-----------------------------------
-- Area: Northern San d'Oria
-- NPC: Bacherume
-- Type: Standard Info NPC
-- @zone: 231
-- @pos: 4.500 0.000 99.000
-- cutscenes  0x0000  0x0238  0x0239  0x0036  0x032a  0x036e
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x0238);
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

