-----------------------------------
-- Area: Toraimarai Canal
-- NPC:  marble door
-- WM 7-1
-----------------------------------
package.loaded["scripts/zones/Toraimarai_Canal/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/treasure");
require("scripts/globals/quests");
require("scripts/zones/Toraimarai_Canal/TextIDs");


-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
A = GetMobAction(17469666)
B = GetMobAction(17469667)
C = GetMobAction(17469668)
D = GetMobAction(17469669)
E = A+B+C+D

if(E == 96)then
	GetNPCByID(17469795):openDoor(30);
	else
	player:startEvent(0x0046);
	end
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID2: %u",csid);
--printf("RESULT2: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
printf("CSID: %u",csid);
printf("RESULT: %u",option);
end;




