-----------------------------------
-- Area: Ro'Maeve
-- NPC:  ???
-- Moongatepass
-- @pos -277 -3 -17 and <many pos>
-----------------------------------
package.loaded["scripts/zones/RoMaeve/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/RoMaeve/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:hasKeyItem(MOONGATE_PASS) == false) then
		player:addKeyItem(MOONGATE_PASS); -- Give the Moongate Pass
		player:messageSpecial(KEYITEM_OBTAINED,MOONGATE_PASS);
	else
		player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
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