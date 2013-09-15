-----------------------------------
-- Area: Southern San d'Oria
-- NPC: Synergy Engineer
-- Type: Standard NPC
-- @zone: 230
-- @pos: many
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/zones/Southern_San_dOria/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x2AFA);
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
	if(csid == 0x02AFA and option == 12) then
		if(player:hasKeyItem(SYNERGY_CRUCIBLE) == false) then
			player:delGil(100);
			player:addKeyItem(SYNERGY_CRUCIBLE);
			player:messageSpecial(KEYITEM_OBTAINED, SYNERGY_CRUCIBLE);
		end
	end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

