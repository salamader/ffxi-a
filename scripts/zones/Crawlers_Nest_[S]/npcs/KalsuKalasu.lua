-----------------------------------
--  Area: The Eldieme Necropolis [S]
--  NPC: Kalsu-Kalasu
--  Starts Snake On The Plains
--	@zone: 171
--  @pos: 304 -33 -19
-----------------------------------
package.loaded["scripts/zones/Crawlers_Nest_[S]/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Crawlers_Nest_[S]/TextIDs");
require("scripts/globals/keyitems");
require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/missions");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local wotgprogress = player:getVar("WotgStatus");	

	if((player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING) and wotgprogress == 0)then 
		player:startEvent(0x0001);
	elseif(player:getCurrentMission(WOTG) == BACK_TO_THE_BEGINNING and wotgprogress == 4 and player:hasKeyItem(GREEN_RECOMMENDATION_LETTER))then 
		player:startEvent(0x0002);
	end
	return cs;
end;
-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
	if(csid == 0x0001 and option == 0) then
		player:addKeyItem(GREEN_RECOMMENDATION_LETTER);
		player:messageSpecial(KEYITEM_OBTAINED,GREEN_RECOMMENDATION_LETTER);
		player:setVar("WotgStatus",4);
	end
end;

