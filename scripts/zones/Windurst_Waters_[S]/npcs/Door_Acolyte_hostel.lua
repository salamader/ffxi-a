-----------------------------------
--  Area: Windurst Waters (S)
--   NPC: 
--  Type: Standard NPC
-- @zone: 94
--  @pos: 124 -2 220 94
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Windurst_Waters_[S]/TextIDs"] = nil;
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:hasKeyItem(958))then
player:startEvent(0x0081,4144);
else
player:startEvent(0x00a0);
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
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
if(csid == 0x0081)then
player:completeQuest(CRYSTAL_WAR,THE_TIGRESS_STIRS);
player:addItem(4144);
player:delKeyItem(958);
player:messageSpecial(ITEM_OBTAINED,4144);
player:setVar("tigress",3);
end
end;

