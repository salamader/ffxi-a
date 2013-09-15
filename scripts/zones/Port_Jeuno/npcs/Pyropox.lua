-----------------------------------
-- Area: Port Jeuno
-- NPC: Pyropox
-- Standard Merchant NPC
-- @zone 246
-- @pos -17.58, 4, 24.6
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
	player:startEvent(0x015D);
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
	if(csid == 0x015D) then
		stock = {4251,25,		-- Festive Fan
			 4252,25,		-- Summer Fan
			 4256,25,		-- Ouka Ranman
			 4184,50,		-- Kongou Inaho
			 4185,50,		-- Meifu Goma
			 4253,50,		-- Spirit Masque
			 4183,100,		-- Konron Hassen
			 5360,100,		-- Muteppo
			 5361,100,		-- Datechochin
			 5725,300}		-- Goshikitenge
			 			 			  
		showShop(player, STATIC, stock);
	end
end;