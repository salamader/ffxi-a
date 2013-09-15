-----------------------------------
-- Area: Mhaura
-- NPC: Orlando
-- Type: Standard NPC
-- Quests: Orlando's Antiques
-- @zone: 249
-- @pos: -37.268, -9, 58.047
-----------------------------------
package.loaded["scripts/zones/Mhaura/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/zones/Mhaura/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local count = trade:getItemCount();
	local FishBones = trade:hasItemQty(900,8);
	local ChickenBone = trade:hasItemQty(898,8);
	local GoblinDie = trade:hasItemQty(568,8);
	local RottenMeat = trade:hasItemQty(16995,8);
	local GoblinCup = trade:hasItemQty(566,8);
	local FingernailSack = trade:hasItemQty(564,8);
	local TeethSack = trade:hasItemQty(565,8);
	local Beastcoin = trade:hasItemQty(656,8);
	local SilverBeastcoin = trade:hasItemQty(750,8);
	local MythrilBeastcoin = trade:hasItemQty(749,8);
	local GoldBeastcoin = trade:hasItemQty(748,8);
	
	if(player:getQuestStatus(OTHER_AREAS,ORLANDO_S_ANTIQUES) == QUEST_ACCEPTED or player:getQuestStatus(OTHER_AREAS,ORLANDO_S_ANTIQUES) == QUEST_COMPLETED) then
		if(FishBones == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",1);
		elseif(ChickenBone == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",2);
		elseif(GoblinDie == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",3);
		elseif(RottenMeat == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",4);
		elseif(GoblinCup == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",5);
		elseif(FingernailSack == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",6);
		elseif(TeethSack == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",7);
		elseif(Beastcoin == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",8);
		elseif(SilverBeastcoin == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",9);
		elseif(MythrilBeastcoin == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",10);
		elseif(GoldBeastcoin == true and count == 8) then
			player:tradeComplete();
			player:startEvent(0x0066);
			player:setVar("orlandoAntiques",11);
		else
			player:startEvent(0x0068);
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:hasKeyItem(CHOCOBO_LICENSE) == false) then
		player:startEvent(0x0064);
	elseif(player:getQuestStatus(OTHER_AREAS,ORLANDO_S_ANTIQUES) == QUEST_ACCEPTED) then
		player:startEvent(0x0067);
	elseif(player:getFameLevel(WINDURST) >= 2) then
		player:startEvent(0x0065);
	else
		player:startEvent(0x006A);
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
	if(csid == 0x0066) then
		if(player:getVar("orlandoAntiques") == 1) then
			player:addGil(GIL_RATE*100);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*100);
		elseif(player:getVar("orlandoAntiques") == 2 or player:getVar("orlandoAntiques") == 3) then
			player:addGil(GIL_RATE*120);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*120);
		elseif(player:getVar("orlandoAntiques") == 4) then
			player:addGil(GIL_RATE*150);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*150);
		elseif(player:getVar("orlandoAntiques") == 5 or player:getVar("orlandoAntiques") == 6) then
			player:addGil(GIL_RATE*200);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*200);
		elseif(player:getVar("orlandoAntiques") == 7) then
			player:addGil(GIL_RATE*250);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*250);
		elseif(player:getVar("orlandoAntiques") == 8) then
			player:addGil(GIL_RATE*600);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*600);
		elseif(player:getVar("orlandoAntiques") == 9) then
			player:addGil(GIL_RATE*750);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*750);
		elseif(player:getVar("orlandoAntiques") == 10) then
			player:addGil(GIL_RATE*800);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*800);
		elseif(player:getVar("orlandoAntiques") == 11) then
			player:addGil(GIL_RATE*900);
			player:messageSpecial(GIL_OBTAINED,GIL_RATE*900);
		end
		if(player:getQuestStatus(OTHER_AREAS,ORLANDO_S_ANTIQUES) == QUEST_ACCEPTED) then
			player:completeQuest(OTHER_AREAS,ORLANDO_S_ANTIQUES);
		end
		player:addFame(OTHER_AREAS,30);
		player:setVar("orlandoAntiques",0);
	end
end;