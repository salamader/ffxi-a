-----------------------------------
-- Area: Metalworks
-- NPC: Hildolf
-- Type: Synergy NPC
-- Quests: Synergistic Pursuits
-- Synergistic Support
-- @zone: 237
-- @pos: -83.999, 2.000, -17.999
-----------------------------------
package.loaded["scripts/zones/Metalworks/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Metalworks/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/titles");
require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local EarthCrystal = trade:hasItemQty(4099,1);
	local FlintStone = trade:hasItemQty(768,1);
	local MithrilSand = trade:hasItemQty(599,1);
	local BrassTank = trade:hasItemQty(1656,1);
	local SlimeOil = trade:hasItemQty(637,1);
	
	if(player:getQuestStatus(BASTOK,SYNERGUSTIC_PURSUITS) == QUEST_ACCEPTED) then
		if(EarthCrystal == true and FlintStone == true and MithrilSand == true and BrassTank == true and count == 1) then
			player:tradeComplete();
			player:startEvent(0x03C6);
		else
			player:startEvent(0x03C7);
		end
	elseif(player:getQuestStatus(BASTOK,SYNERGUSTIC_SUPPORT) == QUEST_ACCEPTED) then
		if(SlimeOil == true and count == 1) then
			player:startEvent(0x03CF);
		else
			player:startEvent(0x03C7);
		end
	elseif(player:getQuestStatus(BASTOK,SYNERGUSTIC_SUPPORT) == QUEST_COMPLETED) then
		player:startEvent(0x03D0);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	if(player:getQuestStatus(BASTOK,SYNERGUSTIC_PURSUITS) == QUEST_AVAILABLE) then
		player:startEvent(0x03C4);
	elseif(player:getQuestStatus(BASTOK,SYNERGUSTIC_PURSUITS) == QUEST_ACCEPTED) then
		player:startEvent(0x03C5);
	elseif(player:getQuestStatus(BASTOK,SYNERGUSTIC_SUPPORT) == QUEST_AVAILABLE) then
		player:startEvent(0x03CD);
	elseif(player:getQuestStatus(BASTOK,SYNERGUSTIC_SUPPORT) == QUEST_ACCEPTED) then
		player:startEvent(0x03CE);
	else
		player:startEvent(0x03D2);
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
	if(csid == 0x03C4 and option == 2) then
		player:addQuest(BASTOK,SYNERGUSTIC_PURSUITS);
	elseif(csid == 0x03C6) then
		player:completeQuest(BASTOK,SYNERGUSTIC_PURSUITS);
		player:addFame(BASTOK,BAS_FAME*30);
		if(player:hasKeyItem(SYNERGY_CRUCIBLE) == false) then
			player:addKeyItem(SYNERGY_CRUCIBLE);
			player:messageSpecial(KEYITEM_OBTAINED, SYNERGY_CRUCIBLE);
		end
	elseif(csid == 0x03CF) then
		player:completeQuest(BASTOK,SYNERGUSTIC_SUPPORT);
		player:addFame(BASTOK,BAS_FAME*30);
		player:tradeComplete();
		if(option == 1) then
			player:addItem(2784, 3); -- Fire Fewell
			player:messageSpecial(ITEM_OBTAINED, 2784);
		elseif(option == 2) then
			player:addItem(2785, 3); -- Ice Fewell
			player:messageSpecial(ITEM_OBTAINED, 2785);
		elseif(option == 3) then
			player:addItem(2786, 3); -- Wind Fewell
			player:messageSpecial(ITEM_OBTAINED, 2786);
		elseif(option == 4) then
			player:addItem(2787, 3); -- Earth Fewell
			player:messageSpecial(ITEM_OBTAINED, 2787);
		elseif(option == 5) then
			player:addItem(2788, 3); -- Lightning Fewell
			player:messageSpecial(ITEM_OBTAINED, 2788);
		elseif(option == 6) then
			player:addItem(2789, 3); -- Water Fewell
			player:messageSpecial(ITEM_OBTAINED, 2789);
		elseif(option == 7) then
			player:addItem(2790, 3); -- Light Fewell
			player:messageSpecial(ITEM_OBTAINED, 2790);
		elseif(option == 8) then
			player:addItem(2791, 3); -- Dark Fewell
			player:messageSpecial(ITEM_OBTAINED, 2791)
		end
	elseif(csid == 0x03C6) then
		player:addQuest(BASTOK,SYNERGUSTIC_SUPPORT);
	end
end;