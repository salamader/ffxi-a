-----------------------------------
-- Area: Ru'Lude Gardens
-- Door: Bastokan Embassy
-- @zone 243
-- @pos 19.046, 7.500, -75.110
-- cutscenes 0x0026  0x0081
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
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
	
	if((player:getRank() <= 3 and MissionStatus == 0) or pNation ~= 1) then
		player:messageSpecial(EMBASSY_1); -- restricted area
	elseif(player:getRank() == 3 and player:hasKeyItem(LETTER_TO_THE_CONSULS_BASTOK) == false) then
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