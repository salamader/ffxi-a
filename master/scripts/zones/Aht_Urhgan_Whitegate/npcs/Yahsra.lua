-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Yahsra
--  Type: Assault Mission Giver
-- @zone: 50
--  @pos: 120.967 0.161 -44.002
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/globals/besieged");

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	rank = getMercenaryRank(player);
	leujaoam_assault_points = player:getPoint(4);					    -- points for this area
	has_key_item = player:hasKeyItem(0x313);                            -- has Imperial Army I.D. Tag?
	current_assault_mission = player:getVar("ASSAULT_NUMBER");          -- this is the number of the assault mission that the player
																		-- has signed up for. None = 0, Leujaoam Cleansing = 1, etc.
	if (current_assault_mission > 0) then 
	  has_assault_mission_already = 1;
	else
	  has_assault_mission_already = 0;
	end;

	if (rank == 0) then
	  player:startEvent(0x0117);
	else 
	  player:startEvent(0x0111,rank,has_key_item,leujaoam_assault_points,has_assault_mission_already,2);
	end
end; 
 

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end; 
 
-----------------------------------
--onEventSelection Action--
-----------------------------------
function onEventSelection(player,csid,option)
--print("onEventSelection")
--print("onEventSelection - CSID:",csid);         
--print("onEventSelection - option ===",option); 


	-- last_param: 0 = wrong job to equip, 1 = too low to equip, 2 can equip 
	-- to check for equipment, 

	-- here we would need something like last_param = player:canEquip(itemID) that returns the needed values.
	-- could implement this on a case-by-case basis here, but would inefficient, since the item data that is 
	-- already in the database and would have to be duplicated here.

	player:updateEvent(0,0,0,0,2); --- last_param = 2 hardcoded for now.
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;
  
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
	--print("CSID:",csid);
	--print("RESULT:",option);

	if (option >= 17) and (option <=161) then  -- player signed up one of the missions:

	-- option = 17: Leujaoam Cleansing
	-- option = 33: Orichalcum Survey
	-- option = 49: Escort Professor Chanoix
	-- option = 65: Shanarha Grass Conservation
	-- option = 81: Counting Sheep
	-- option = 97: Supplies Recovery
	-- option = 113: Azure Experiments
	-- option = 129: Imperial Code
	-- option = 145: Red Versus Blue
	-- option = 161: Bloody Rondo 
	  
	player:setVar("ASSAULT_NUMBER", (option-1)/16); -- number of current mission signed up for, has to be used later at entry.
	player:addKeyItem(0x2FA); -- give player Leujaoam assault oders
	player:messageSpecial(KEYITEM_OBTAINED,0x2FA);
	player:removeKeyItem(0x313); -- remove imperial army I.D. tag (can someone confirm that the key item is removed at this time??)
	end;

	if (option >= 16386) then  -- player chose to buy an item

	--- rewards -----------------
	-- option=16386: Stoic Earring 3,000 	 
	-- option=32770: Unfettered Ring 5,000 	 
	-- option=49154: Tempered Chain 8,000
	-- option=65538: Potent Belt 10,000
	-- option=81922: Miraculous Cape 10,000 	 
	-- option=98306: Yigit Bulawa 15,000 	 
	-- option=114690: Imperial Bhuj 15,000 	 
	-- option=131074: Pahluwan Patas 15,000
	-- option=147458: Amir Kolluks 20,000 	 
	-- option=163842: Pahluwan Qalansuwa 20,000
	-- option=180226: Yigit Seraweels 20,000 
	------------------------

	cost = 0;
	if (option == 16386) then
	  cost = 3000;
	  player:addItem(15970);
	  player:messageSpecial(ITEM_OBTAINED,15970);
	elseif (option == 32770) then
	  cost = 5000;
	  player:addItem(15775);
	  player:messageSpecial(ITEM_OBTAINED,15775);
	elseif (option == 49154) then
	  cost = 8000;
	  player:addItem(15521);
	  player:messageSpecial(ITEM_OBTAINED,15521);
	elseif (option == 65538) then
	  cost = 10000;
	  player:addItem(15884);
	  player:messageSpecial(ITEM_OBTAINED,15884);
	elseif (option == 81922) then
	  cost = 10000;
	  player:addItem(15490);
	  player:messageSpecial(ITEM_OBTAINED,15490);  
	elseif (option == 98306) then
	  cost = 15000;
	  player:addItem(18408);
	  player:messageSpecial(ITEM_OBTAINED,18408);
	elseif (option == 114690) then
	  cost = 15000;
	  player:addItem(18485);
	  player:messageSpecial(ITEM_OBTAINED,18485);
	elseif (option == 131074) then
	  cost = 15000;
	  player:addItem(18365);
	  player:messageSpecial(ITEM_OBTAINED,18365);
	elseif (option == 147458) then
	  cost = 20000;
	  player:addItem(14933);
	  player:messageSpecial(ITEM_OBTAINED,14933);
	elseif (option == 163842) then
	  cost = 20000;
	  player:addItem(16069);
	  player:messageSpecial(ITEM_OBTAINED,16069);
	elseif (option == 180226) then
	  cost = 20000;
	  player:addItem(15606);
	  player:messageSpecial(ITEM_OBTAINED,15606);
	end;

	player:delPoint(4, cost);
	end;

end;