-----------------------------------
-- Area: Selbina
-- NPC:  Graegham
-- Type: Guild Merchant Fishing Guild
-- @zone 248
-- @pos -12.423, -7.287, 8.665
-----------------------------------

require("scripts/globals/settings");
require("scripts/zones/Selbina/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:sendGuild(5171,3,18,5)) then
		player:showText(npc,TextID_Selbina.FISHING_SHOP_DIALOG);
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
end;
