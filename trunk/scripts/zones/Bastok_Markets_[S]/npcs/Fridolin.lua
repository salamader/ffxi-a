-----------------------------------
-- Area: Bastok Markets (S)
-- NPC: NPC
-----------------------------------

require("scripts/globals/shop");
package.loaded["scripts/zones/Bastok_Markets_[S]/TextIDs"] = nil;
require("scripts/zones/Bastok_Markets_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:hasKeyItem(BLUE_RECOMMENDATION_LETTER)) then
player:startEvent(0x0003);	
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



