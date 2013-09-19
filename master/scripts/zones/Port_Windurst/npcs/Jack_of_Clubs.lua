-----------------------------------
--	Area: Port Windurst
--	NPC: Jack of Clubs
--	Adventurer's Assistant
--	Working 100%
-------------------------------------

require("scripts/globals/settings");
package.loaded["scripts/zones/Port_Windurst/TextIDs"] = nil;
require("scripts/zones/Port_Windurst/TextIDs");

----------------------------------- 
-- onTrade Action 
----------------------------------- 

function onTrade(player,npc,trade) 
	if (trade:getItemCount() == 1 and trade:hasItemQty(0x218,1) == true) then
		player:startEvent(0x2718,GIL_RATE*9999);
		player:addGil(GIL_RATE*9999);
		player:tradeComplete();
	end
end;

----------------------------------- 
-- onTrigger Action 
-----------------------------------
 
function onTrigger(player,npc) 
	---- Begin Custom Code ----
	---- Adding Rings ----
	if not player:hasItem(0x34B7)
		then player:addItem(0x34B7);
	end

	if not player:hasItem(0x34B9)
		then player:addItem(0x34B9);
	end

	if not player:hasItem(0x34B8)
		then player:addItem(0x34B8);
	end
	
	---- Adding Missing job gear/spells ----
	if not player:hasItem(17859)
		then player:addItem(17859);
	end
	
	if not player:hasItem(17809)
		then player:addItem(17809);
	end
	
	if not player:hasSpell(296)
		then player:addSpell(296);
	end

	--- Clearing all "Lure of the Wildcat" quests ---
	--San d'Orea
	if(player:getQuestStatus(0,113) == QUEST_ACCEPTED) then
		player:completeQuest(0,113);
		player:delKeyItem(0x2E7);
		player:addKeyItem(0x2F1);
	end
	--Bastok
	if(player:getQuestStatus(1,84) == QUEST_ACCEPTED) then
		player:completeQuest(1,84);
		player:delKeyItem(0x2E8);
		player:addKeyItem(0x2F2);
	end
	--Windurst
	if(player:getQuestStatus(2,94) == QUEST_ACCEPTED) then
		player:completeQuest(2,94);
		player:delKeyItem(0x2E9);
		player:addKeyItem(0x2F3);
	end
	--Jeuno
	if(player:getQuestStatus(3,90) == QUEST_ACCEPTED) then
		player:completeQuest(3,90);	
		player:delKeyItem(0x2EA);
		player:addKeyItem(0x2F4);
	end
	---- End Custom Code ----
	
	player:startEvent(0x2717,0,3);
	
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



