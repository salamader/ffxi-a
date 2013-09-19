-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Isdebaaq
--  Type: Assault Mission Giver
-- @zone: 50
--  @pos: 127.565 0.161 -43.846
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
	mamool_assault_points = player:getPoint(5);						    -- points for this area
	has_key_item = player:hasKeyItem(0x313);                            -- has Imperial Army I.D. Tag?
	current_assault_mission = player:getVar("ASSAULT_NUMBER");          -- this is the number of the assault mission that the player
																		-- has signed up for. None = 0, {}  = 1, etc.
	if (current_assault_mission > 0) then 
	  has_assault_mission_already = 1;
	else
	  has_assault_mission_already = 0;
	end;

	if (rank == 0) then
	  player:startEvent(0x0118);
	else 
	  player:startEvent(0x0112,rank,has_key_item, mamool_assault_points,has_assault_mission_already, 2);
	  -- last param: 0 = wrong job to equip, 1 = too low to equip, 2 can equip - since it's not known at this call time what the player is 
	  -- going to select, this can't be set correctly ???
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
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);

	if (option >= 177) and (option <=321) then  -- player signed up one of the missions:

	-- option = 177: Imperial Agent Rescue            
	-- option = 193: Preemptive Strike    
	-- option = 209: Sagelord Elimination 
	-- option = 225: Breaking Morale             
	-- option = 241: The Double Agent             
	-- option = 257: Imperial Treasure Retrieval  
	-- option = 273: Blitzkrieg           
	-- option = 289: Marids in the Mist   
	-- option = 305: Azure Ailments       
	-- option = 321: The Susanoo Shuffle  
					
	player:setVar("ASSAULT_NUMBER", (option-161)/16); -- number of current mission signed up for, has to be used later at entry.
	player:addKeyItem(0x2FB); -- give player mamool assault oders
	player:messageSpecial(KEYITEM_OBTAINED,0x2FB);
	player:removeKeyItem(0x313); -- remove imperial army I.D. tag (can someone confirm that the key item is removed at this time??)
	--print("Player got key item");
	end;

	if (option >= 16386) then  -- player chose to buy an item

	--- rewards -----------------
	-- option=16386: Antivenom Earring 	 3,000 	 
	-- option=32770: Ebullient Ring 	 5,000 	 
	-- option=49154: Enlightened Chain 	 8,000 	 
	-- option=65538: Spectral Belt 	 10,000 
	-- option=81922: Bullseye Cape 	10,000 	 
	-- option=98306: Storm Tulwar 	15,000 	 
	-- option=114690: Imperial Neza 	15,000 	 
	-- option=131074: Storm Tabar 	15,000           
	-- option=147458: Yigit Gages 	20,000 	 
	-- option=163842: Amir Boots 	20,000 	 
	-- option=180226: Pahluwan Seraweels 	20,000                                                           
	------------------------

	cost = 0;
	if (option == 16386) then
	  cost = 3000;
	  player:addItem(15971);
	  player:messageSpecial(ITEM_OBTAINED,15971);
	elseif (option == 32770) then
	  cost = 5000;
	  player:addItem(15776);
	  player:messageSpecial(ITEM_OBTAINED,15776);
	elseif (option == 49154) then
	  cost = 8000;
	  player:addItem(15522);
	  player:messageSpecial(ITEM_OBTAINED,15522);
	elseif (option == 65538) then
	  cost = 10000;
	  player:addItem(15885);
	  player:messageSpecial(ITEM_OBTAINED,15885);
	elseif (option == 81922) then
	  cost = 10000;
	  player:addItem(15491);
	  player:messageSpecial(ITEM_OBTAINED,15491);  
	elseif (option == 98306) then
	  cost = 15000;
	  player:addItem(17715);
	  player:messageSpecial(ITEM_OBTAINED,17715);
	elseif (option == 114690) then
	  cost = 15000;
	  player:addItem(18113);
	  player:messageSpecial(ITEM_OBTAINED,18113);
	elseif (option == 131074) then
	  cost = 15000;
	  player:addItem(17951);
	  player:messageSpecial(ITEM_OBTAINED,17951);
	elseif (option == 147458) then
	  cost = 20000;
	  player:addItem(14935);
	  player:messageSpecial(ITEM_OBTAINED,14935);
	elseif (option == 163842) then
	  cost = 20000;
	  player:addItem(15688);
	  player:messageSpecial(ITEM_OBTAINED,15688);
	elseif (option == 180226) then
	  cost = 20000;
	  player:addItem(15609);
	  player:messageSpecial(ITEM_OBTAINED,15609);
	end;

	player:delPoint(5, cost);
	end;

end;