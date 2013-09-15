-----------------------------------
-- Area: Southern San d`Oria
-- NPC: Macuillie
-- Type: Guildworkers Union Rep
-- Smithing
-- @zone: 231
-- @pos: -191.738, 11.001, 138.656
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

	1995,10000,1,		--sheeting
	1994,10000,1,		--chainwork
	1992,40000,1,		--metal purification is a key item
	1993,40000,1,		--metal ensorcelment is a key item
	1996,40000,2,		--way of the blacksmith

	15445,10000,1,		--blacksmiths belt
	14831,70000,3,		--blacksmiths gloves
	15820,80000,3,		--blacksmiths ring
	10949,80000,3,		--blacksmiths torque
	15044,80000,3,		--blacksmiths cuffs
	14393,100000,3,		--blacksmiths apron
	11330,100000,3,		--blacksmiths smock

	153,50000,3,		--Mastersmiths Anvil
	3324,15000,3,		--blacksmiths emblem
	334,200000,3,		--blacksmiths signboard
	3625,500000,3}		--blacksmiths stall

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