-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Mushayra
--  Type: Standard NPC
-- @zone: 50
--  @pos: -111.551 -6.999 -61.720
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
-- Includes
require("scripts/globals/settings");
require("scripts/globals/quests");
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)

	artsAndCrafts = player:getQuestStatus(AHT_URHGAN,ARTS_AND_CRAFTS);
	
	if (artsAndCrafts == QUEST_ACCEPTED) then
		player:showText(npc,HADAHDA_DIALOG + 16);
	else
		player:startEvent(0x0207);
	end
end; 
 
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 
  
-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
end;