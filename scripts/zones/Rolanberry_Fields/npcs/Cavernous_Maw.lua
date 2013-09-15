-----------------------------------
-- Area: Rolanberrry Fields
-- Name: Cavernous Maw
-- Teleports Players to Rolanberry
-- Fields S
-- @zone 110
-- @pos -198, 8, 361
-----------------------------------
package.loaded["scripts/zones/Rolanberry_Fields/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/teleports");
require("scripts/globals/missions");
require("scripts/globals/campaign");
require("scripts/zones/Rolanberry_Fields/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(ENABLE_WOTG == 1 and (player:hasKeyItem(PURE_WHITE_FEATHER) == false) )then
		player:startEvent(0x01f4,1);
	elseif(ENABLE_WOTG == 1 and hasMawActivated(player,1)) then
		player:startEvent(0x0388);
	else
		player:messageSpecial(NOTHING_HAPPENS);
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
	
	if(csid == 0x01f4) then
		r = math.random(1,3);
		player:addKeyItem(PURE_WHITE_FEATHER);
		player:messageSpecial(KEYITEM_OBTAINED,PURE_WHITE_FEATHER);
		player:setVar("WotgStatus",1);
		if(r == 1) then
			player:setVar("csmaw",1);
			player:addNationTeleport(MAW,1);
			toMaw(player,1); -- go to Batallia_Downs[S]
		elseif(r == 2) then
			player:addNationTeleport(MAW,2);
			toMaw(player,3); -- go to Rolanberry_Fields_[S]
		elseif(r == 3) then
			player:addNationTeleport(MAW,4);
			toMaw(player,5); -- go to Sauromugue_Champaign_[S]
		end;
	elseif(csid == 0x0388 and option == 1) then
		toMaw(player,3); -- go to Rolanberry_Fields_[S]
	end;
	
end;

