-----------------------------------
-- Area: Port Bastok
-- NPC: Festive Moogle
-- Type: Event NPC
-- @zone 236
-- @pos 45.421, 8.499, -241.740
--
-- cutscenes 0x016A  0x016B
-----------------------------------
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Port_Bastok/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getVar("FestiveMoogleEventItems") == 0) then -- Initial CS tracking
		player:startEvent(0x016A);
	else
		player:startEvent(0x016B);
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
	if(csid == 0x016A) then
		if(player:getFreeSlotsCount(0) >= 8) then
			player:setVar("FestiveMoogleEventItems",1); -- set initial CS viewed
			player:addItem(16119); -- Nomad Cap
			player:messageSpecial(ITEM_OBTAINED,16119);
			player:addItem(16118); -- Moogle Cap
			player:messageSpecial(ITEM_OBTAINED,16118);
			player:addItem(18401); -- Moogle Rod
			player:messageSpecial(ITEM_OBTAINED,18401);
			player:addItem(320); -- Harpsichord
			player:messageSpecial(ITEM_OBTAINED,320);
			player:addItem(264); -- Stuffed Chocobo
			player:messageSpecial(ITEM_OBTAINED,264);
			player:addItem(11290); -- Tidal Talisman
			player:messageSpecial(ITEM_OBTAINED,11290);
			player:addItem(11811); -- Destrier Beret
			player:messageSpecial(ITEM_OBTAINED,11811);
			player:addItem(10293); -- Chocobo Shirt
			player:messageSpecial(ITEM_OBTAINED,10293);
		else
			player:showText(npc,ITEM_CANNOT_BE_OBTAINED);
		end
	end
end;