-----------------------------------
-- Area: vunkerl
-- NPC: 207.081', '-32.002', '315.458
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
if(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) == QUEST_ACCEPTED)then
	if(trade:hasItemQty(2521,1) and trade:getItemCount() == 1)then player:startEvent(0x0067);
	end
end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==2)then
player:startEvent(0x0065);
elseif(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==3)then
player:startEvent(0x0066);
elseif(player:getQuestStatus(CRYSTAL_WAR,BETTER_PART_OF_VALOR) ==QUEST_ACCEPTED and player:getVar("bpov") ==4)then
player:startEvent(0x0068);
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
if(csid == 0x0065)then
player:setVar("bpov",3);
elseif(csid ==0x0067)then
player:tradeComplete();
player:addKeyItem(XHIFHUT);
player:messageSpecial(KEYITEM_OBTAINED,XHIFHUT);
player:setVar("bpov",4);
end
end;



