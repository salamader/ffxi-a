-----------------------------------
-- Area: JUGNER Forest [S]
-- NPC:  Telepoint
-----------------------------------

require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;



-----------------------------------
-- OnTrigger Action
-----------------------------------


function onTrigger(player,npc)
	
	if(player:hasKeyItem(JUGNER_GATE_CRYSTAL) == false) then
		player:addKeyItem(JUGNER_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,JUGNER_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
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