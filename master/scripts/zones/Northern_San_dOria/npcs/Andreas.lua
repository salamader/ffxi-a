-----------------------------------
-- Area: Southern San d`Oria
-- NPC: Andreas
-- Type: Guildworkers Union Rep
-- Woodworking
-- @zone: 231
-- @pos: -189.282, 10.999, 262.626
-----------------------------------
-- Guild shops not implemented

package.loaded["scripts/zones/Northern_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/shop");
require("scripts/globals/quests");
require("scripts/zones/Northern_San_dOria/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:showText(npc,6852) -- is a temp textid
	--[[stock = {
	4242,200,1,		--plasma crystal
	4238,200,1,		--inferno crystal
	4239,200,1,		--glacier
	4240,200,1,		--cyclone
	4241,200,1,		--terra
	4243,200,1,		--torrent
	4245,200,1,		--twilight
	4244,200,1,		--aurora

	1987,10000,1,		--boltmaker
	1986,10000,1,		--lumberjack
	1984,40000,1,		--wood purification is a key item
	1985,40000,1,		--wood ensorcelment is a key item
	1988,40000,2,		--way of the carpenter

	15444,10000,1,		--carpenters belt
	14830,70000,3,		--carpenters gloves
	15819,80000,3,		--carpenters ring
	15043,80000,3,		--carpenters cuffs
	14392,100000,3,		--carpenters apron
	11329,100000,3,		--carpenters smock

	28,50000,3,		--Drawing Desk
	3672,150000,3,		--Carpenters Kit
	3331,15000,3,		--Carpenters emblem
	341,200000,3,		--Carpenters signboard
	3632,500000,3}		--Carpenters stall

	showNationShop(player, SANDORIA, stock);]]
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
end;