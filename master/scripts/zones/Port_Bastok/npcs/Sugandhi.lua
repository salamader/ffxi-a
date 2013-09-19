-----------------------------------
-- Area: Port Bastok
-- NPC:  Sugandhi
-- Conquest Merchant NPC
-- @zone 236
-- @pos -50.089, 2.342, 2.226
-----------------------------------
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/shop");
require("scripts/globals/conquest");
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
	player:showText(npc,SUGANDHI_SHOP_DIALOG);
	local stock = {
        0x43A1,  1107,	1,     --Kukri
        0x1010,   837,	1,     --Broadsword
        0x03B7,   108,	1,     --Tuck
        0x027C,   119,	1,     --Falchion
        0x1037,   736,	2,     --Knife
        0x1020,  4445,	2,     --Mithril Sword
        0x1034,   290,	2,     --Scimitar
        0x0764,  3960,	3,     --Bronze Knife
        0x026E,    44,	3,     --Cat Baghnakhs
        0x1036,  2387,	3,     --Bronze Sword
        0x025D,   180,	3,     --Iron Sword
        0x0765,  3960,	3,     --Degen
        0x03FC,   276,	3,     --Sapara
	}               
	showNationShop(player, BASTOK, stock);
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
