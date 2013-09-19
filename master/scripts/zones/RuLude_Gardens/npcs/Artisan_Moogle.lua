-----------------------------------
-- Area: Ru'Lude Gardens
-- NPC: Artisan Moogle
-- Standard Info NPC
-- @zone 243
-- @pos 53.000, 9.000, -49.000
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/RuLude_Gardens/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x27B2, player:getContainerSize(6), 9980, player:getGil());
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
	local sizeChange = 0;
	
	if(csid == 0x27B2) then
		if(option == 1) then
			if(player:getContainerSize(6) == 0) then
				player:changeContainerSize(6,30);
				player:delGil(9980);
			end
		elseif(option == 2) then
			if(player:getContainerSize(0) > player:getContainerSize(6)) then
				sizeChange = player:getContainerSize(0) - player:getContainerSize(6);
				player:changeContainerSize(6,sizeChange);
			end
		end
	end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
	if(player:getVar("ArtisanMoogle_Day") < tonumber(os.date("%j"))) then
		if(player:getFreeSlotsCount(0) >= 1 and player:hasItem(4181) == false) then
			player:setVar("ArtisanMoogle_Day",tonumber(os.date("%j")));
			player:addItem(4181); -- Scroll of Instant Warp
			player:messageSpecial(ITEM_OBTAINED, 4181);
		else
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,4181);
		end
	end
end;