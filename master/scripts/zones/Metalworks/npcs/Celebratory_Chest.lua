-----------------------------------
-- Area: Metalworks
-- NPC: Celebratory Chest
-- Type: Merchant NPC
-- @zone 237
-- @pos 88.029, -20.170, -11.086
-- http://ffxi.gamerescape.com/wiki/Celebratory_Chest
-----------------------------------
package.loaded["scripts/zones/Metalworks/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Metalworks/TextIDs");
require("scripts/globals/shop");

-----------------------------------
-- Action
-----------------------------------

function onTrigger(player,npc)
	stock =
	{
		4167,231,		--Cracker
		4168,275,		--Twinkle Shower
		4215,440,		--Popstar
		4216,252,		--Brilliant Snow
		4256,459,		--Ouka Ranman
		4169,275,		--Little Comet
		5769,650,		--Popper
		4170,1000,		--Wedding Bell
		5424,6000,		--Serene serinette
		5425,6000,		--Joyous serinette
		4441,1116,		--Grape Juice
		4238,3000,		--Inferno Crystal
		4240,3000,		--Cyclone Crystal
		4241,3000, 		--Terra Crystal
	};
	showShop(player, STATIC, stock);
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