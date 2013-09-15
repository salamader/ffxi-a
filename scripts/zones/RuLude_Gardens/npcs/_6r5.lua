-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: San d'Orian Embassy
-- @zone 243
-- @pos -31.107, 7.501, -65.061
-- cutscenes 0x0027  0x0082
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
-----------------------------------

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
	local pNation = player:getNation();
	local currentMission = player:getCurrentMission(pNation);
	local MissionStatus = player:getVar("MissionStatus");
	
	if((player:getRank() <= 3 and MissionStatus == 0) or pNation ~= 0) then
		player:messageSpecial(EMBASSY_1); -- restricted area
	elseif(player:getRank() == 3 and player:hasKeyItem(LETTER_TO_THE_CONSULS_SANDORIA) == false) then
		player:messageSpecial(EMBASSY_2); -- you have no letter of introduction
	else
		player:messageSpecial(EMBASSY_3); -- The consulate is away.
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
end;