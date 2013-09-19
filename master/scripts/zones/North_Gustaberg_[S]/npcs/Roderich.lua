-----------------------------------
-- Area: North Gusta(S)
-- NPC: -400.039, 39.991, -90.445,
-----------------------------------

require("scripts/globals/shop");
package.loaded["scripts/zones/Bastok_Markets_[S]/TextIDs"] = nil;
require("scripts/zones/Bastok_Markets_[S]/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getVar("discontent") == 2)then
player:startEvent(0x0068);
elseif(player:getVar("discontent") == 3)then
player:startEvent(0x0069);
elseif(player:getVar("discontent") == 4)then
player:startEvent(0x006B);
end
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
	printf("CSID: %u",csid);
	printf("RESULT: %u",option);
if(csid == 0x0068)then
player:setVar("discontent",3);
end
end;


