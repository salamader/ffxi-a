-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Lageegee
--  Type: Assault Mission Giver
-- @zone: 50
--  @pos: 120.808 0.161 -30.435
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
	periqia_assault_points = player:getPoint(7); 					    -- points for this area
	has_key_item = player:hasKeyItem(0x313);                            -- has Imperial Army I.D. Tag?
	current_assault_mission = player:getVar("ASSAULT_NUMBER");          -- this is the number of the assault mission that the player
																		-- has signed up for. None = 0, {}  = 1, etc.
	if (current_assault_mission > 0) then 
	  has_assault_mission_already = 1;
	else
	  has_assault_mission_already = 0;
	end;

	if (rank == 0) then
	  player:startEvent(0x011A);
	else 
	  player:startEvent(0x0114,rank,has_key_item,periqia_assault_points,has_assault_mission_already,2);
	end
end; 
 
-----------------------------------
-- onEventSelection Action
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
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end; 
 
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);

	if (option >= 497) and (option <=641) then  -- player signed up one of the missions:

	-- option = 497: Seagull Grounded                           
	-- option = 513: Requiem                 
	-- option = 529: Saving Private Ryaaf    
	-- option = 545: Shooting Down the Baron 
	-- option = 561: Building Bridges        
	-- option = 577: Stop the Bloodshed      
	-- option = 593: Defuse the Threat       
	-- option = 609: Operation: Snake Eyes   
	-- option = 625: Wake the Puppet         
	-- option = 641: The Price is Right      
					
	player:setVar("ASSAULT_NUMBER", (option-481)/16); -- number of current mission signed up for, has to be used later at entry.
	player:addKeyItem(0x2FD); -- give player periqia assault oders
	player:messageSpecial(KEYITEM_OBTAINED,0x2FD);
	player:removeKeyItem(0x313); -- remove imperial army I.D. tag (can someone confirm that the key item is removed at this time??)
	end;

	if (option >= 16386) then  -- player chose to buy an item

	--- rewards -----------------
	-- option=16386: Vision Earring 	 3,000 	 
	-- option=32770: Unyielding Ring 	 5,000 	 
	-- option=49154: Fortified Chain 	 8,000 	 
	-- option=65538: Resolute Belt 	 10,000
	-- option=81922: Bushido Cape 	10,000 	 
	-- option=98306: Khanjar 	15,000 	 
	-- option=114690: Hotarumaru 	15,000 	 
	-- option=131074: Imperial Gun 	15,000               
	-- option=147458: Amir Puggaree 	20,000 	 
	-- option=163842: Pahluwan Crackows 	20,000
	-- option=180226: Yigit Gomlek 	20,000                         
	------------------------

	cost = 0;
	if (option == 16386) then
	  cost = 3000;
	  player:addItem(15973);
	  player:messageSpecial(ITEM_OBTAINED,15973);
	elseif (option == 32770) then
	  cost = 5000;
	  player:addItem(15778);
	  player:messageSpecial(ITEM_OBTAINED,15778);
	elseif (option == 49154) then
	  cost = 8000;
	  player:addItem(15524);
	  player:messageSpecial(ITEM_OBTAINED,15524);
	elseif (option == 65538) then
	  cost = 10000;
	  player:addItem(15887);
	  player:messageSpecial(ITEM_OBTAINED,15887);
	elseif (option == 81922) then
	  cost = 10000;
	  player:addItem(15493);
	  player:messageSpecial(ITEM_OBTAINED,15493);  
	elseif (option == 98306) then
	  cost = 15000;
	  player:addItem(18025);
	  player:messageSpecial(ITEM_OBTAINED,18025);
	elseif (option == 114690) then
	  cost = 15000;
	  player:addItem(18435);
	  player:messageSpecial(ITEM_OBTAINED,18435);
	elseif (option == 131074) then
	  cost = 15000;
	  player:addItem(18686);
	  player:messageSpecial(ITEM_OBTAINED,18686);
	elseif (option == 147458) then
	  cost = 20000;
	  player:addItem(16062);
	  player:messageSpecial(ITEM_OBTAINED,16062);
	elseif (option == 163842) then
	  cost = 20000;
	  player:addItem(15695);
	  player:messageSpecial(ITEM_OBTAINED,15695);
	elseif (option == 180226) then
	  cost = 20000;
	  player:addItem(14527);
	  player:messageSpecial(ITEM_OBTAINED,14527);
	end;

	player:delPoint(7, cost);
	end;

end;