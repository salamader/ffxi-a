-----------------------------------
-- Area: North Gusta(S)
-- NPC: NPC 206 -20 669
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
if(player:hasKeyItem(BATTLE_RATIONS) == true and player:getVar("discontent") == 1)then
player:startEvent(0x0066);
elseif(player:getVar("discontent") == 2)then
player:startEvent(0x0067);
else
player:startEvent(0x0006E);
end
return cs;
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
if(csid == 0x0066)then
player:setVar("discontent",2);
player:delKeyItem(BATTLE_RATIONS);
end
end;


