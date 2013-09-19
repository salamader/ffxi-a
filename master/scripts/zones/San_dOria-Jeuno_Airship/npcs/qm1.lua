-----------------------------------
-- 	???
-- 	The Stars of Ifrit
-----------------------------------
-- Includes
package.loaded["scripts/zones/San_dOria_Jeuno_Airship/TextIDs"] = nil;
-----------------------------------

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	local TOTD = VanadielTOTD();
	local TheStarsOfIfrit = player:getQuestStatus(BASTOK,THE_STARS_OF_IFRIT);

	if ((TOTD == TIME_EVENING or TOTD == TIME_NIGHT or TOTD == TIME_NEW_DAY) and IsMoonFull()) then
		if(TheStarsOfIfrit == QUEST_ACCEPTED and player:hasKeyItem(CARRIER_PIGEON_LETTER) == false) then
			player:addKeyItem(CARRIER_PIGEON_LETTER);
			player:messageSpecial(KEYITEM_OBTAINED,CARRIER_PIGEON_LETTER);
		end
	end
end;

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end; 
 
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
end;