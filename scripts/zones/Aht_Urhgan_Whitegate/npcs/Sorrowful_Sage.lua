-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Sorrowful Sage
--  Type: Assault Mission Giver
-- @zone: 50
--  @pos: 134.096 0.161 -30.401
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
	ilrusi_assault_points = player:getPoint(9);     					-- points for this area
	has_key_item = player:hasKeyItem(0x313);                            -- has Imperial Army I.D. Tag?
	current_assault_mission = player:getVar("ASSAULT_NUMBER");          -- this is the number of the assault mission that the player
																		-- has signed up for. None = 0, {}  = 1, etc.
	nyzul_floor = player:getVar("NYZUL_FLOOR");

	if (current_assault_mission > 0) then 
	  has_assault_mission_already = 1;
	else
	  has_assault_mission_already = 0;
	end;

	if (rank == 0) then
	  player:startEvent(0x011C);
	else 
	  player:startEvent(0x0116,rank,has_key_item,nyzul_tokens,has_assault_mission_already,nyzul_floor);
	end
	  
end; 
 

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
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

	if (option == 817) then  -- player signed up for nyzul assault
		player:setVar("ASSAULT_NUMBER", 1); -- number of current mission signed up for, always 1 for Nyzul.
		player:addKeyItem(0x36E); -- give player Nyzul Isle Assault orders  
		player:messageSpecial(KEYITEM_OBTAINED,0x36E);
		player:delKeyItem(0x313); -- remove imperial army I.D. tag (can someone confirm that the key item is removed at this time??)
		--print("Player got key item");
	end;

end;