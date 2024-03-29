-----------------------------------
-- Area: Horlais Peak
-- Name: Mission Rank 2
-- @zone 139
-- @pos -509, 158, -211
-----------------------------------
package.loaded["scripts/zones/Horlais_Peak/TextIDs"] = nil;
package.loaded["scripts/globals/bcnm"] = nil;
-----------------------------------

require("scripts/globals/bcnm");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Horlais_Peak/TextIDs");

-----------------------------------

-- Maat Battle in Horlais Peak
-- EXAMPLE SCRIPT
-- 
-- What should go here:
-- giving key items, playing ENDING cutscenes
--
-- What should NOT go here:
-- Handling of "battlefield" status, spawning of monsters,
-- putting loot into treasure pool, 
-- enforcing ANY rules (SJ/number of people/etc), moving
-- chars around, playing entrance CSes (entrance CSes go in bcnm.lua)

-- After registering the BCNM via bcnmRegister(bcnmid)
function OnBcnmRegister(player,instance)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function OnBcnmEnter(player,instance)
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function OnBcnmLeave(player,instance,leavecode)
-- print("leave code "..leavecode);
	
	if(leavecode == 2) then -- play end CS. Need time and battle id for record keeping + storage
		if(player:hasCompletedMission(SANDORIA,THE_SECRET_WEAPON)) then
			player:startEvent(0x7D01,1,1,1,instance:getTimeInside(),1,3,1);
		else
			player:startEvent(0x7D01,1,1,1,instance:getTimeInside(),1,3,0);
		end
	elseif(leavecode == 4) then
		player:startEvent(0x7D02);
	end
	
end;

function onEventUpdate(player,csid,option)
-- print("bc update csid "..csid.." and option "..option);
end;
	
function onEventFinish(player,csid,option)
-- print("bc finish csid "..csid.." and option "..option);
	
	if(csid == 0x7D01) then
		if(player:getCurrentMission(SANDORIA) == THE_SECRET_WEAPON) then
			player:addKeyItem(CRYSTAL_DOWSER);
			player:messageSpecial(KEYITEM_OBTAINED,CRYSTAL_DOWSER);
			player:setVar("SecretWeaponStatus",3)
		end
	end

end;
