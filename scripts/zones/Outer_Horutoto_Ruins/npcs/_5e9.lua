-----------------------------------
-- Area: Inner Horutoto Ruins
-- NPC:  Gate: Magical Gizmo
-- Involved In Mission: The Heart of the Matter + 6-1
-- @pos 584 0 -660 194
-----------------------------------
package.loaded["scripts/zones/Outer_Horutoto_Ruins/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Outer_Horutoto_Ruins/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	-- Check if we are on Windurst Mission 1-2
	if(player:getCurrentMission(WINDURST) == THE_HEART_OF_THE_MATTER and 
	   player:getVar("MissionStatus") == 3 and player:hasKeyItem(SOUTHEASTERN_STAR_CHARM)) then
		player:startEvent(0x002c);
	elseif(player:getCurrentMission(WINDURST) == FULL_MOON_FOUNTAIN and player:getVar("WINDURST61") ==1)then
		if(GetServerVariable("TIMER61W") > os.time()) then
			player:messageSpecial(7242,0,248);
		elseif(GetMobAction(17572197) == 0 and GetMobAction(17572198) == 0 and GetMobAction(17572199) == 0 and GetMobAction(17572200) == 0) then
			SpawnMob(17572197);
			SpawnMob(17572198);
			SpawnMob(17572199);
			SpawnMob(17572200);
		end
	elseif(player:getVar("WINDURST61") == 5)then
		player:startEvent(0x0044);
		SetServerVariable("TIMER61W",os.time()+600);
	else
		player:messageSpecial(DOOR_FIRMLY_SHUT);
	end
	return 1;
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

	-- If we just finished the cutscene for Windurst Mission 1-2
	if(csid == 0x002c) then
		player:setVar("MissionStatus",4);
		player:messageSpecial(ALL_G_ORBS_ENERGIZED);
		-- Remove the charm that opens this door
		player:delKeyItem(SOUTHEASTERN_STAR_CHARM);
	elseif(csid == 0x0044)then 
		player:messageSpecial(7211,0,248);
		player:delKeyItem(SOUTHWESTERN_STAR_CHARM);
		player:setVar("WINDURST61",6);	
	end
	
end;