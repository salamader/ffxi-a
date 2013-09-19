-----------------------------------
--  Area: Fort Karugo-Narugo [S]
--  NPC:  ??? ', '207.748', '-30.190', '54.052', 96
-----------------------------------
package.loaded["scripts/zones/Fort_Karugo-Narugo_[S]/TextIDs"] = nil;
-------------------------------------


require("scripts/zones/Fort_Karugo-Narugo_[S]/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger
-----------------------------------

function onTrigger(player,npc)
if(player:getVar("tigress") == 4) then
player:startEvent(0x0066);
elseif(player:getVar("tigress") == 6)then
player:startEvent(0x0067);
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
if(csid == 0x0066)then
player:setVar("tigress",5);
if(GetMobAction(17170645) == 0) then
SpawnMob(17170645,180):updateEnmity(player);
player:setVar("tigress",5);
end
elseif(csid == 0x0067)then
player:setVar("tigress",7);
end
end;


