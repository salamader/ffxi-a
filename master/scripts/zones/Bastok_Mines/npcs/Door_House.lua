-----------------------------------
-- Area: Bastok Mines
-- NPC: Door CS
-- Standard Info NPC
-- Mini Quest Af Corsair
-- @zone 234
-- @pos 11.909, -1.042, -16.056
-----------------------------------

require("scripts/globals/settings");
require("scripts/zones/Bastok_Mines/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/keyitems");
require("scripts/globals/common");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	-- "Corsair SideQuest" Trades
	
	if(player:getVar("LeleroonsLetterBlue") ==2) then
		if(trade:getItemCount() == 4 and trade:hasItemQty(2007,1) and trade:hasItemQty(663,1) and trade:hasItemQty(879,1) and trade:hasItemQty(2010,1)) then  --Trade Laminated Buffalo Leather, Mythril Sheet, Karakul Leather, Wolf Felt
			player:tradeComplete(); --Trade Completed
			player:startEvent(0x209); 
			player:setVar("LeleroonsLetterBlue",3);
		end
	
	
	elseif(player:getVar("LeleroonsLetterBlue") == 3) then
		if(trade:hasItemQty(2186,4) and trade:getItemCount() == 4) then -- Trade Imperial Mythril Pieces
			player:tradeComplete(); --Trade Completed
			player:setVar("LeleroonsLetterBlue",4);
			player:startEvent(0x20C);
			player:setVar("Corsair_Boots_JPMidnight_Timer",getMidnight()); -- SET TIMER FOR 1 DAY REAL LIFETIME
		end
	
	end	
end;  

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)	
	
	local BlueLetter = player:getVar("LeleroonsLetterBlue");

	if(BlueLetter == 1 and player:hasKeyItem(LELEROONS_LETTER_BLUE) == true) then
		player:startEvent(0x207);	--First CS For Side Quest Blue Letter
		player:delKeyItem(LELEROONS_LETTER_BLUE); -- Removes Key Item Blue Letter
		player:setVar("LeleroonsLetterBlue",2);
		player:setVar("AgainstAllOddsSideQuests",0);
	elseif(BlueLetter == 2) then
		player:startEvent(0x208);
	elseif(BlueLetter == 3) then
		player:startEvent(0x217);
	elseif(player:getVar("Corsair_Boots_JPMidnight_Timer") < os.time() and BlueLetter == 4) then  
		player:needToZone(true);
		player:startEvent(0x20A);	-- CS For Final Part Of Side Quest Blue Letter Complete
	elseif(BlueLetter == 4) then
		player:startEvent(0x20B);	
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

	if(csid == 0x20A) then
		player:addItem(15685); -- Corsair's Bottes
		player:messageSpecial(ITEM_OBTAINED, 15685); -- Item Obtained: Corsair's Bottes
		player:setVar("LeleroonsLetterBlue",0);
		player:setVar("AgainstAllOddsSideQuests",1); -- Set for SideQuest NPC
		player:setVar("Corsair_Boots_JPMidnight_Timer",0);
	end
end;

