-----------------------------------
-- Area: The Eldieme Necropolis
-- NPC: Sarcophagus
-- Involved in Quest: The Requiem (BARD AF2)
-- @zone 195
-- @pos -420 8 500
-----------------------------------
package.loaded["scripts/zones/The_Eldieme_Necropolis/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/quests");
require("scripts/zones/The_Eldieme_Necropolis/TextIDs");

-----------------------------------
-- sarcophagusNumber
-----------------------------------

function sarcophagusNumber(X,Z)
	if(X <= -423 and X >= -426 and Z >= 494 and Z <= 499) then
		return 1;
	elseif(X <= -418 and X >= -423 and Z >= 500 and Z <= 505) then
		return 2;
	elseif(X <= -415 and X >= -418 and Z >= 500 and Z <= 505) then
		return 3;
	elseif(X <= -410 and X >= -415 and Z >= 500 and Z <= 505) then
		return 4;
	elseif(X <= -410 and X >= -415 and Z >= 494 and Z <= 499) then
		return 5;
	end
end;

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(player:getVar("TheRequiemCS") == 3 and trade:hasItemQty(4154,1) and trade:getItemCount() == 1) then 
		if(player:getVar("TheRequiemRandom") == 0) then
			player:setVar("TheRequiemRandom",math.random(1,5));
		end
		
		if(sarcophagusNumber(npc:getXPos(),npc:getZPos()) == player:getVar("TheRequiemRandom") and player:getVar("TheRequiemYumKilled") == 0) then 
			player:tradeComplete();
			player:messageSpecial(SENSE_OF_FOREBODING);
			player:setVar("TheRequiemAlreadyPoped",1);
			SpawnMob(17576265,300):updateEnmity(player); -- Spawn Yum Kimil NM @pos -414 8 499
			SpawnMob(17576267,180):updateEnmity(player); -- Spawn Owl Guardian NM @pos -414 8 501
			SpawnMob(17576266,180):updateEnmity(player); -- Spawn Dog Guardian NM @pos -414 8 497
		else
			player:messageSpecial(NOTHING_HAPPENED);
		end
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	--player:startEvent(0x002e);
	Sarcophagus = sarcophagusNumber(npc:getXPos(),npc:getZPos());	
	ANewDawn = player:getQuestStatus(JEUNO,A_NEW_DAWN);
	SturmKilled = player:getVar("ANewDawnSturmKilled");
	
	if(sarcophagusNumber(npc:getXPos(),npc:getZPos()) == player:getVar("TheRequiemRandom")) then
		if(player:getVar("TheRequiemYumKilled") == 1) then
			player:startEvent(0x002e);
		elseif(player:getVar("TheRequiemAlreadyPoped") == 1) then
			player:messageSpecial(SENSE_OF_FOREBODING);
			SpawnMob(17576265):updateEnmity(player); -- Spawn Yum Kimil NM @pos -414 8 499
			SpawnMob(17576267):updateEnmity(player); -- Spawn Owl Guardian NM @pos -414 8 501
			SpawnMob(17576266):updateEnmity(player); -- Spawn Dog Guardian NM @pos -414 8 497
		end
	elseif(ANewDawn == QUEST_ACCEPTED) then
		if(player:hasKeyItem(TAMERS_WHISTLE) and Sarcophagus == 4 and SturmKilled ~= 1) then
			SpawnMob(17576269); -- Spawn Taifun NM @pos
                	SpawnMob(17576270); -- Spawn Trombe NM @pos 
                	SpawnMob(17576268); -- Spawn Strum NM @pos
		elseif(Sarcophagus == 4 and SturmKilled == 1) then
			player:startEvent(0x002d);
		else
			player:messageSpecial(NOTHING_HAPPENED);
		end
	else
		player:messageSpecial(SARCOPHAGUS_CANNOT_BE_OPENED); -- Standard dialog
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
	
	if(csid == 0x002e) then 
		player:setVar("TheRequiemCS",0);
		player:setVar("TheRequiemYumKilled",0);
		player:setVar("TheRequiemRandom",0);
		player:setVar("TheRequiemAlreadyPoped",0);
		player:addKeyItem(STAR_RING1);
		player:messageSpecial(KEYITEM_OBTAINED,STAR_RING1); -- Star Ring (Key Item). 
	elseif(csid == 0x002d) then
		player:setVar("ANewDawnSturmKilled",0);
		player:delKeyItem(TAMERS_WHISTLE);
		player:addItem(14222);
		player:messageSpecial(ITEM_OBTAINED,14222);
		player:completeQuest(JEUNO,A_NEW_DAWN);
	end
	
end;
