-----------------------------------
-- Area: Southern San d'Oria
-- NPC:  Rouva
-- Involved in Quest: Lure of the
-- Wildcat (San d'Oria), Spice Gals
-- @zone 230
-- @pos -17 2 10
--
-- TODO - Make Spice Gals once per
-- conquest tally.
-------------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/quests");
require("scripts/zones/Southern_San_dOria/TextIDs");

----------------------------------- 
-- onTrade Action 
----------------------------------- 

function onTrade(player,npc,trade)
	
	if(player:getQuestStatus(SANDORIA,FLYERS_FOR_REGINE) == QUEST_ACCEPTED) then
		if(trade:hasItemQty(532,1) and trade:getItemCount() == 1) then -- Trade Magicmart_flyer
			player:messageSpecial(FLYER_REFUSED);
		end
	end
	
end;

----------------------------------- 
-- onTrigger Action 
-----------------------------------
 
function onTrigger(player,npc) 
	
	if(player:getQuestStatus(SANDORIA,LURE_OF_THE_WILDCAT_SAN_D_ORIA) == QUEST_ACCEPTED and player:getMaskBit(player:getVar("wildcatSandy_var"),3) == false) then
		player:startEvent(0x0328);
	elseif(player:getQuestStatus(SANDORIA,SPICE_GALS) == QUEST_ACCEPTED and player:hasKeyItem(RIVERNEWORT) == true) then
		player:startEvent(0x02D5);
	elseif(player:getQuestStatus(SANDORIA,SPICE_GALS) == QUEST_ACCEPTED) then
		player:startEvent(0x02D8);
	elseif(player:getQuestStatus(SANDORIA,SPICE_GALS) == QUEST_AVAILABLE and player:getCurrentMission(COP) >= ANCIENT_VOWS) then
		player:startEvent(0x02D4);
	else
		player:startEvent(0x0298);
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
	
	if(csid == 0x0328) then
		player:setMaskBit(player:getVar("wildcatSandy_var"),"wildcatSandy_var",3,true);
	elseif(csid == 0x02D4) then
		player:addQuest(SANDORIA,SPICE_GALS);
	elseif(csid == 0x02D5) then
		if (player:getFreeSlotsCount() == 0) then
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,4247);
		else
			player:completeQuest(SANDORIA,SPICE_GALS);
			player:delKeyItem(RIVERNEWORT);
			player:addFame(SANDORIA,30*SAN_FAME);
			player:addItem(4247);
			player:messageSpecial(ITEM_OBTAINED,4247); -- Page from Miratete's Memoirs
		end
	end
	
end;