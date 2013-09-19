-----------------------------------
--  Area: Uleguerand Range
--  NPC: Zebada
--  Type: ENM Quest Activator
--  @zone: 5
--  @pos: -308.112 -42.137 -570.096
--
--  TODO - Check for 5 days to pass
--  before restarting quest
-----------------------------------
package.loaded["scripts/zones/Uleguerand_Range/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/zones/Uleguerand_Range/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local ChamnaetIce  = trade:hasItemQty(1780,1);
	if(ChamnaetIce == true and count == 1) then
		player:tradeComplete();
		player:startEvent(0x000D);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	-- player:startEvent(0x000F) -- Come back later cs
	
	if(player:getVar("zebada") == 0) then
		player:startEvent(0x000E);
	else
		if(math.random(0,1) == 1) then
			player:startEvent(0x000C);
		else
			player:startEvent(0x0010);
		end
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
	if (csid == 0x000E) then
		if(player:getFreeSlotsCount() >= 1) then
			player:addItem(1779,1); -- Cotton Pouch
			player:setVar("zebada",1);
		else
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,1779);
		end
	elseif (csid == 0x000D) then
		player:addKeyItem(ZEPHYR_FAN);
		player:messageSpecial(KEYITEM_OBTAINED,ZEPHYR_FAN);
		player:setVar("zebada",0);
	end
end;

