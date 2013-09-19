-----------------------------------
-- Area: Southern SandOria [S]
-- NPC: Wyatt
-- @zone 80
-- @pos 124 0 84
-----------------------------------
package.loaded["scripts/zones/Southern_San_dOria_[S]/TextIDs"] = nil;
require("scripts/zones/Southern_San_dOria_[S]/TextIDs");
require("scripts/globals/titles");
require("scripts/globals/quests")
require("scripts/globals/keyitems")

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)


	if (trade:hasItemQty(2506,4) and trade:getItemCount() == 4) then
			player:startEvent(0x004);
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	if (player:getQuestStatus(CRYSTAL_WAR,SEEING_SPOTS) == QUEST_AVAILABLE) then
			player:startEvent(0x002);
			
	elseif (player:getQuestStatus(CRYSTAL_WAR,SEEING_SPOTS) == QUEST_ACCEPTED) then
			player:startEvent(0x003);
	
	elseif (player:getQuestStatus(CRYSTAL_WAR,SEEING_SPOTS) == QUEST_COMPLETED and player:hasKeyItem(987) == true) then
			player:startEvent(0x042)
		
 	else
 		player:showText(npc, WYATT_DIALOG);
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
	if (csid == 0x002) then
		player:addQuest(CRYSTAL_WAR,SEEING_SPOTS);

	elseif (csid == 0x0042) then
		player:addGil(GIL_RATE*20417);
		player:delKeyItem(987);
		player:messageSpecial(GIL_OBTAINED,GIL_RATE*20417);

	elseif (csid == 0x004) then
		if(player:getVar("SeeingSpotsQuest") == 0) then
			player:tradeComplete();
			player:setTitle(LADY_KILLER);
			player:addGil(GIL_RATE*3000);
			player:messageSpecial(GIL_OBTAINED,3000);
			player:completeQuest(CRYSTAL_WAR,SEEING_SPOTS);
			player:setVar("SeeingSpotsQuest",1);
		else
			player:tradeComplete();
			player:addGil(GIL_RATE*1500);
			player:messageSpecial(GIL_OBTAINED,1500);
		end

	end

end;