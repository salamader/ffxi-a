-----------------------------------
-- Area: Southern San d'Oria
-- NPC:  Capucine
-- @pos -145.384, -5.999, -11.794
-- @zone 230
-- Standard Merchant NPC
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/shop");
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
	player:showText(npc,OSTALIE_SHOP_DIALOG);
	stock = {12473,1904,	-- Poet's Circlet
			12608,1288,		-- Tunic
			12601,2838,		-- Linen Robe
			12736,602,		-- Mitts
			12729,1605,		-- Linen Cuffs
			12864,806,		-- Slacks
			12857,2318,		-- Linen Slops
			12992,556,		-- Solea
			12985,1495}		-- Holly Clogs
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