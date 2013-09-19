-----------------------------------
-- Area: Port Bastok
-- NPC: Silver Owl
-- Type: Tenshodo Merchant
-- @zone 236
-- @pos -99.155, 4.649, 23.292
-- TODO send to correct guild shop
-----------------------------------
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/shop");
require("scripts/globals/quests");
require("scripts/globals/keyitems");
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
	if (player:hasKeyItem(TENSHODO_MEMBERS_CARD)) then 
		if (player:sendGuild(0xEC03, 1, 23, 4)) then 
			player:showText(npc,TENSHODO_SHOP_OPEN_DIALOG);
		end
	else
		player:showText(npc,TENSHODO_SHOP_CLOSED_DIALOG);
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
	if (csid == 0x0097) then
		player:addKeyItem(TENSHODO_APPLICATION_FORM);
		player:messageSpecial(KEYITEM_OBTAINED,TENSHODO_APPLICATION_FORM);
	end
end;