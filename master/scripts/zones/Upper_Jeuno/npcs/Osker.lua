-----------------------------------
-- Area: Upper Jeuno
-- NPC: Osker
-- Involved in Quest: Chocobo's Wounds
-- @zone 244
-- @pos -61.421, 8.199, 94.162
-----------------------------------
package.loaded["scripts/zones/Upper_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/zones/Upper_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local gil = trade:getGil();
	local count = trade:getItemCount();
	if (trade:hasItemQty(717,1) and gil == 0 and count == 1) then
		player:startEvent(0x0094);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
        
    local ChocobosWounds = player:getQuestStatus(JEUNO,CHOCOBO_S_WOUNDS);
    local ANewDawn = player:getQuestStatus(JEUNO,A_NEW_DAWN);
    
    if (ANewDawn == 1 and not player:hasKeyItem(TAMERS_WHISTLE)) then
	player:startEvent(0x0092);
    elseif(ANewDawn == 1 and player:hasKeyItem(TAMERS_WHISTLE)) then
	player:startEvent(0x0093);	
    elseif (ChocobosWounds == 0) then
        player:startEvent(0x003e);
    elseif (ChocobosWounds == 1) then
        feed = player:getVar("ChocobosWounds_Event");

        if (feed == 1) then
            player:startEvent(0x0067);
        elseif (feed == 2) then
            player:startEvent(0x0033);
        elseif (feed == 3) then
            player:startEvent(0x0034);
        elseif (feed == 4) then
            player:startEvent(0x003b);
        elseif (feed == 5) then
            player:startEvent(0x002e);
        elseif (feed == 6) then
            player:startEvent(0x0037);
        end
    elseif (ChocobosWounds == 2) then
        player:startEvent(0x0037);
    else
        player:startEvent(0x0036);
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
	if(csid == 0x00094) then
	player:tradeComplete();
		player:addKeyItem(TAMERS_WHISTLE);
		player:messageSpecial(KEYITEM_OBTAINED,TAMERS_WHISTLE);
	end
end;