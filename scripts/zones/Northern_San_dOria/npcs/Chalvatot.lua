-----------------------------------
--  Area: Northern San d'Oria
--  NPC: Chalvatot
--  Type: Quest NPC
--  Involved in Quest: "Her Majesty's Garden"
--  @zone: 231
--
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/keyitems");

--[[ Events:

004C (final CS for Sandy 9-1 "Breaking Barriers")
0009 (Halver: final CS for Sandy 9-2 "The Heir to the Light" + Promotion to rank 10!)
0213 default response: "I'm busy. I'd appreciate a little peace and quiet."
006F Chateau_LeautesLastWishes_Pt2: final CS for 6-1 "Leaute's Last Wishes"
0000 CS with Princess between sandy missions 7-1 and 7-2
003B "this place is not open to commoners, but since you're here, have a look. Queen Leaute would be pleased." (after finishing Sandy 6-1 or "Her majesty's garden"?)

021B default response if you talk to him for the first time as non-Sandy citizen
021A default response if you talk to him for the first time as Sandy citizen
0054 opening CS for "Her Majesty's Garden" (Map of the Northlands Areas quest) 
0052 CS for "Her Majesty's Garden"
0053 final CS for "Her Majesty's Garden"
0063 BRD AF3 quest
0062 BRD AF3 quest
0060 BRD AF3 quest
0061 BRD AF3 quest
022C Sandy Mission 3-2 "The Crystal Spring"
0231 Lure of the Wildcat

Princess Claidie CS:
0210 nothing?
0074 talks about her Coming of Age ceremony getting nearer
0064 CS for Sandy 8-2 "Lightbringer" (?)

--]]

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	if(player:getQuestStatus(SANDORIA,HER_MAJESTY_S_GARDEN) == QUEST_ACCEPTED) then
		if(trade:hasItemQty(533,2) and trade:getItemCount() == 2) then -- Trade Derfland Humus
			player:startEvent(0x0053);
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	sanFame = player:getFameLevel(SANDORIA);
	
	if (player:getVar("metChalvatot") ~= 1) then
		if (player:getNation() == SANDORIA) then
			player:startEvent(0x021A);
		else
			player:startEvent(0x021B);
		end;
	elseif(player:getQuestStatus(SANDORIA,HER_MAJESTY_S_GARDEN) == QUEST_AVALIABLE and sanFame >= 4) then
		player:startEvent(0x0054);
	elseif(player:getQuestStatus(SANDORIA,HER_MAJESTY_S_GARDEN) == QUEST_ACCEPTED) then
		player:startEvent(0x0052);
	else
		player:startEvent(0x0213);
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
	if(csid == 0x0054 and option == 1) then
		player:addQuest(SANDORIA,HER_MAJESTY_S_GARDEN);
	elseif(csid == 0x0053) then
		player:tradeComplete();
		player:addKeyItem(MAP_OF_THE_NORTHLANDS_AREA);
		player:messageSpecial(KEYITEM_OBTAINED,MAP_OF_THE_NORTHLANDS_AREA);
		player:addFame(SANDORIA,SAN_FAME*30);
		player:completeQuest(SANDORIA,HER_MAJESTY_S_GARDEN);
	end
end;

