-----------------------------------
-- Area: Horlais Peak
-- Name: Mission Rank 7
-- @pos 299 -123 345 146
-----------------------------------
package.loaded["scripts/zones/Balgas_Dais/TextIDs"] = nil;
-------------------------------------
require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/zones/Balgas_Dais/TextIDs");

-----------------------------------

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
print("leave code "..leavecode);
	
	if(leavecode == 2) then 
		if(player:hasCompletedMission(WINDURST,SAINTLY_INVITATION))then
	player:startEvent(0x7d01,1,1,1,instance:getTimeInside(),1,3,1);
		else
	player:startEvent(0x7d01,1,1,1,instance:getTimeInside(),1,3,0);
		end
	elseif(leavecode == 4) then
		player:startEvent(0x7d02);
	end
	
end;

function onEventUpdate(player,csid,option)
print("bc update csid "..csid.." and option "..option);
end;
	
function onEventFinish(player,csid,option)
print("bc finish csid "..csid.." and option "..option);
	
	if(csid == 0x7d01) then
		if(player:hasKeyItem(HOLY_ONES_INVITATION)) then
		player:delKeyItem(HOLY_ONES_INVITATION);
		player:addKeyItem(BALGA_CHAMPION_CERTIFICATE);
	player:messageSpecial(KEYITEM_OBTAINED,BALGA_CHAMPION_CERTIFICATE);
	player:addTitle(VICTOR_OF_THE_BALGA_CONTEST);
			player:setVar("WINDURST62",2);
					end
	end
	
end;