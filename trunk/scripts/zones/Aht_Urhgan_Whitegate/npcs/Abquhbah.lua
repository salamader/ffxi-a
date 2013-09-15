-----------------------------------
-- Area: Aht Urhgan Whitegate
-- NPC:  Abquhbah
-- Standard Info NPC
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
	if(getMercenaryRank(player) > 0) then
		player:startEvent(0x00FF);	--Default Mercenary
	else
		player:startEvent(0x00FE);	--Default
	end
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