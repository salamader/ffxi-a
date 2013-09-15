-----------------------------------
--  Area: Uleguerand Range
--   NPC: Fissure
--  Type: 
-- @zone: 5
--  @pos: 
-----------------------------------
package.loaded["scripts/zones/Uleguerand_Range/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Uleguerand_Range/TextIDs");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if (npc:getID() == 16798102 and player:hasKeyItem(MYSTIC_ICE)) then
		player:startEvent(0x0002,MYSTIC_ICE);
	elseif (npc:getID() == 16798103 and player:hasKeyItem(MYSTIC_ICE)) then
		player:startEvent(0x0003,MYSTIC_ICE);
	elseif (npc:getID() == 16798104 and player:hasKeyItem(MYSTIC_ICE)) then
		player:startEvent(0x0004,MYSTIC_ICE);
	else
		player:messageSpecial(NOTHING_HERE);
	end
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
	if (option == 1) then
		player:delKeyItem(MYSTIC_ICE);
	end
end;

