-----------------------------------
--  Area: West Sarutabaruta [S]
--  NPC:  154.470', '-40.157', '332.064 95
-----------------------------------
package.loaded["scripts/zones/West_Sarutabaruta_[S]/TextIDs"] = nil;
-------------------------------------


require("scripts/globals/settings");
require("scripts/zones/West_Sarutabaruta_[S]/TextIDs");
require("scripts/globals/keyitems");



-----------------------------------
-- onTrigger
-----------------------------------
function onTrigger(player,npc)
if((player:getQuestStatus(CRYSTAL_WAR,THE_TIGRESS_STIRS) == QUEST_ACCEPTED) and (not(player:hasKeyItem(958))))then
player:addKeyItem(958);
player:messageSpecial(KEYITEM_OBTAINED,SMALL_STARFRUIT);
else
player:messageSpecial(NOTHING);
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

