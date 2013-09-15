-----------------------------------
-- Area: Port Jeuno
-- NPC: Kindlix
-- Standard Merchant NPC
-- @zone 246
-- @pos -18.82, 4, 23.302
-----------------------------------
package.loaded["scripts/zones/Port_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/shop");
require("scripts/zones/Port_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x015C);
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
	if(csid == 0x015C) then
		stock = {4167,25,		-- Cracker
				4168,25,		-- Twinkle Shower
				4169,25,		-- Little Comet
				4217,25,		-- Sparkling Hand
				4215,50,		-- Popstar
				4216,50,		-- Brilliant Snow
				4186,100,		-- Airborne
				4218,100,		-- Air Rider
				4257,300,		-- Papillion
				5441,300}		-- Angelwing
		showShop(player, STATIC, stock);
	end
end;