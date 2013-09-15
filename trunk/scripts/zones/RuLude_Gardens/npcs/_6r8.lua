-----------------------------------
-- Area: Ru'Lud Gardens
-- Door: Windurstian Ambassador
-- Involved in Missions: Windurst
-- Missions 3.3 "A New Journey" and
-- 4.1 "Magicite"
-- @zone 243
-- @pos 32.110, 7.502, -20.944
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
package.loaded["scripts/globals/missions"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/RuLude_Gardens/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	pNation = player:getNation();
	currentMission = player:getCurrentMission(pNation);
	MissionStatus = player:getVar("MissionStatus");
	
	if(currentMission == A_NEW_JOURNEY and MissionStatus == 4) then
		player:startEvent(0x0028);
	elseif(player:getRank() == 4 and MissionStatus == 0 and player:getCurrentMission(WINDURST) == 255 and getMissionRankPoints(player,13) == 1) then
		if(player:hasKeyItem(ARCHDUCAL_AUDIENCE_PERMIT)) then
			player:startEvent(0x0083,1);
		else
			player:startEvent(0x0083);
		end
	elseif((player:getRank() <= 3 and MissionStatus == 0) or pNation ~= 2) then
		player:messageSpecial(EMBASSY_1); -- restricted area
	elseif(player:getRank() == 3 and player:hasKeyItem(LETTER_TO_THE_CONSULS_WINDURST) == false) then
		player:messageSpecial(EMBASSY_2); -- you have no letter of introduction
	else
		player:messageSpecial(EMBASSY_3); -- The consulate is away.
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
	
	if(csid == 0x0028) then
		finishMissionTimeline(player,1,csid,option);
	elseif(csid == 0x0083 and option == 1) then
		player:setVar("MissionStatus",1);
		if(player:hasKeyItem(ARCHDUCAL_AUDIENCE_PERMIT) == false) then
			player:addKeyItem(ARCHDUCAL_AUDIENCE_PERMIT);
			player:messageSpecial(KEYITEM_OBTAINED,ARCHDUCAL_AUDIENCE_PERMIT);
		end
	elseif(csid == 0x0026 or csid == 0x0023) then
		finishMissionTimeline(player,1,csid,option);
	end
	
end;