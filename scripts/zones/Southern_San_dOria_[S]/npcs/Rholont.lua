-----------------------------------
-- Area: Southern SandOria [S]
-- NPC: Rholont
-- @zone 80
-- @pos -168 -2 56
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria_[S]/TextIDs"] = nil;
require("scripts/zones/Southern_San_dOria_[S]/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
GiftsOfGriffonQuest = player:getQuestStatus(CRYSTAL_WAR,GIFTS_OF_THE_GRIFFON)
ClawsOfGriffonQuest = player:getQuestStatus(CRYSTAL_WAR,CLAWS_OF_THE_GRIFFON)
WrathOfGriffonQuest = player:getQuestStatus(CRYSTAL_WAR,WRATH_OF_THE_GRIFFON)


	------------------------------
	-- Gifts of Griffon	Quest		  
	------------------------------

	if(GiftsOfGriffonQuest == QUEST_ACCEPTED and player:getVar("GiftsOfGriffonProg") == 1) then
		player:startEvent(0x017); -- Gifts of Griffon Step 2 (after starting from Louxiard)
		
	elseif (GiftsOfGriffonQuest == QUEST_ACCEPTED and player:getVar("GiftsOfGriffonProg") == 9) then
		player:startEvent(0x018); -- Gifts of Griffon Quest Complete
		
	------------------------------
	-- Claws of Griffon	Quest		  
	------------------------------		
		
	elseif(ClawsOfGriffonQuest == QUEST_AVAILABLE and GiftsOfGriffonQuest == QUEST_COMPLETED and player:getMainLvl() >= 15) then
		player:startEvent(0x02F); -- Claws of Griffon Start
		
	------------------------------
	-- Wrath of Griffon	Quest		  
	------------------------------
	elseif(WrathOfGriffonQuest == QUEST_AVAILABLE and GiftsOfGriffonQuest == QUEST_COMPLETED and ClawsOfGriffonQuest == QUEST_COMPLETED) then
		player:startEvent(0x003B); -- Wrath of Griffon Start
		
	elseif(WrathOfGriffonQuest == QUEST_ACCEPTED and player:getVar("WrathOfGriffonProg") == 4) then
		player:startEvent(0x003C); -- Wrath of Griffon Quest Complete


	------------------------------
	-- Default Dialogue			  
	------------------------------
	else
		player:startEvent(0x020); -- Default Dialogue
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

	------------------------------
	-- Claws of Griffon	Quest	  
	------------------------------

	if(csid == 0x02F) then 		-- Claws of Griffon Start 
		player:addQuest(CRYSTAL_WAR,CLAWS_OF_THE_GRIFFON);
		
	elseif (csid == 0x017) then
		if(player:getFreeSlotsCount() == 0) then
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,2528);
	else
		player:setVar("GiftsOfGriffonProg",2);
		player:addItem(2528,7); -- Plume d'or
		player:messageSpecial(ITEM_OBTAINED,2528);
	end
	-------------------------------
	-- Gifts of Griffon	Quest		   
	-------------------------------
	elseif (csid == 0x018) then
		player:addItem(812,1)
		player:messageSpecial(ITEM_OBTAINED,812);
		player:setVar("GiftsOfGriffonProg",0);
		player:completeQuest(CRYSTAL_WAR,GIFTS_OF_THE_GRIFFON);

	-------------------------------
	-- Wrath of Griffon	Quest		   
	-------------------------------		
		
	elseif (csid == 0x003B) then
		player:addQuest(CRYSTAL_WAR,WRATH_OF_THE_GRIFFON);
		player:setVar("WrathOfGriffonProg",1);

	elseif (csid == 0x003C) then
		player:completeQuest(CRYSTAL_WAR,WRATH_OF_THE_GRIFFON);
		player:setVar("WrathOfGriffonProg",0);
		player:addKeyItem(978); -- Military Scrip
		player:messageSpecial(KEYITEM_OBTAINED,978); -- Military Scrip

	end

end;