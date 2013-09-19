-----------------------------------
-- Area: Southern SandOria [S]
-- NPC: Thierride
-- @zone 80
-- @pos -124 -2 14
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria_[S]/TextIDs"] = nil;
require("scripts/zones/Southern_San_dOria_[S]/TextIDs");
require("scripts/globals/quests");

-----------------------------------

-- Item 1019 = Lufet Salt
-- Had to use setVar because you have to trade Salts one at a time according to the wiki.
-- Lufet Salt can be obtained by killing Crabs in normal West Ronfaure.

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)


	if(trade:hasItemQty(1019,1) and trade:getItemCount() == 1 and player:getQuestStatus(CRYSTAL_WAR,BEANS_AHOY) == QUEST_ACCEPTED
	or trade:hasItemQty(1019,1) and trade:getItemCount() == 1 and player:getQuestStatus(CRYSTAL_WAR,BEANS_AHOY) == QUEST_COMPLETED) then
		if (player:getVar("BeansAhoy") == 0 == true) then
			
			player:startEvent(0x0151); -- Traded the Correct Item Dialogue (NOTE: You have to trade the Salts one at according to wiki)
	
		else
			player:startEvent(0x0154); -- Quest Complete Dialogue
			
		end
	
	else
		player:startEvent(0x0153); -- Wrong Item Traded
	
	end
	
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	if(player:getQuestStatus(CRYSTAL_WAR,BEANS_AHOY) == QUEST_AVAILABLE) then
		player:startEvent(0x014E); -- Quest Start
	
		elseif(player:getQuestStatus(CRYSTAL_WAR,BEANS_AHOY) == QUEST_ACCEPTED) then
			player:startEvent(0x014F); -- Quest Active, NPC Repeats what he says but as normal 'text' instead of cutscene.
	
	else
		player:startEvent(0x014D); -- Default Dialogue
		
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

	if (csid == 0x014E) then
		player:addQuest(CRYSTAL_WAR,BEANS_AHOY);
	
		elseif (csid == 0x0151) then
		player:tradeComplete();
		player:setVar("BeansAhoy",1);
		
		elseif (csid == 0x0154) then
			if(player:hasItem(5704,1) == true or player:getFreeSlotsCount() < 1) then
				player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,5704)
			
			else
			player:tradeComplete();
			player:addItem(5704,1);
			player:messageSpecial(ITEM_OBTAINED,5704);
			player:completeQuest(CRYSTAL_WAR,BEANS_AHOY);
			player:setVar("BeansAhoy",0);
			end
				

	
	end
	

end;