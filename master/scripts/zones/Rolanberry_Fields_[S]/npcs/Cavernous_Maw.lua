-----------------------------------
-- Area: Rolanberrry Fields S
-- Name: Cavernous Maw
-- Teleports Players to Rolanberry
-- Fields
-- @zone 91
-- @pos -198, 8, 360
-----------------------------------
package.loaded["scripts/zones/Rolanberry_Fields_[S]/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/teleports");
require("scripts/globals/campaign");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/zones/Rolanberry_Fields_[S]/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING)then
		player:startEvent(0x02BD,1);
	elseif(hasMawActivated(player,1) == false) then
		player:startEvent(0x0065);
	else
		player:startEvent(0x0066);
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
--print("CSID:",csid);
--print("RESULT:",option);
	
	if(option == 1) then
		if(csid == 0x0065) then
			player:addNationTeleport(MAW,2);
		end
		toMaw(player,4);
	elseif(csid == 0x02BD)then
		player:completeMission(WOTG,BACK_TO_THE_BEGINNING);
		player:addMission(WOTG,CAIT_SITH);
		player:addNationTeleport(MAW,1);
		toMaw(player,4);
	end
end;