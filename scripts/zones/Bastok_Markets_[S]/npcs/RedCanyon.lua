-----------------------------------
-- Area: Bastok Markets (S)
-- NPC: NPC
-----------------------------------

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
player:startEvent(0x00C8);	
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
printf("CSID: %u",csid);
printf("RESULT: %u",option);
if(csid == 0x00C8 and option == 1)then
player:setPos(380,0.001,147,194,88);
end
end;



