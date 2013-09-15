-----------------------------------
--  Area: Uleguerand Range
--   NPC: Eternal Ice
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
	if(player:hasKeyItem(MYSTIC_ICE)) then
		player:messageSpecial(MYSTIC_ICE_OFFSET);
	else
		player:addKeyItem(MYSTIC_ICE);
		player:messageSpecial(KEYITEM_OBTAINED,MYSTIC_ICE);
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
end;

