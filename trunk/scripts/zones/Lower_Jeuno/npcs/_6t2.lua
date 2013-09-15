-----------------------------------
--	Area: Lower Jeuno
-- 	Door: Merchant's House
-- 	Starts & Finishes Quest: Save My Son, A New Dawn
--  	Optional Involvement in Quest: Chocobo's Wounds, Path of the Beastmaster
-----------------------------------
package.loaded["scripts/zones/Lower_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/teleports");
require("scripts/zones/Lower_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	local ChocobosWounds = player:getQuestStatus(JEUNO, CHOCOBO_S_WOUNDS)
	local SaveMySon = player:getQuestStatus(JEUNO, SAVE_MY_SON)
	local Level = player:getMainLvl();
	ANewDawn = player:getQuestStatus(JEUNO,A_NEW_DAWN);
	ScatteredIntoShadow = player:getQuestStatus(JEUNO, SCATTERED_INTO_SHADOW);

	if(ChocobosWounds == QUEST_AVAILABLE) then
		player:startEvent(0x0040);
	elseif(player:getVar("ChocobosWounds_Event") > 3) then
		player:startEvent(0x003f);
	elseif(SaveMySon == QUEST_AVAILABLE and ChocobosWounds == QUEST_COMPLETED and Level >= ADVANCED_JOB_LEVEL) then
		player:startEvent(0x00a4);
	elseif(SaveMySon == QUEST_ACCEPTED) then
		local SaveMySonEvent = player:getVar("SaveMySon_Event");

		if(SaveMySonEvent == 0) then
			player:startEvent(0x00e5);
		elseif(SaveMySonEvent == 1) then
			player:startEvent(0x00a3);
		end
	elseif(player:needToZone() == false and SaveMySon == QUEST_COMPLETED) then
		player:startEvent(0x0084);
	elseif(player:getMainJob() == 9 and ANewDawn == QUEST_AVAILABLE) then
+		if(ScatteredIntoShadow ~= QUEST_COMPLETED) then
+			player:startEvent(0x0001); -- Needs AF2 Completed to get AF3.
+		else
+			AF3_event = player:getVar("bstAF3event");
+			if(AF3_event == 1) then
+				player:startEvent(0x0004); -- Start A New Dawn Quest, previously rejected.
+			else
+				player:startEvent(0x0005); -- Start A New Dawn Quest, first time.
+			end
+		end
+	elseif(ANewDawn == QUEST_ACCEPTED and not player:hasKeyItem(TAMERS_WHISTLE)) then
+		player:startEvent(0x0002); -- Accepted Quest, doesn't have Key Item: Tamer's Whistle
+	elseif(ANewDawn == QUEST_ACCEPTED and player:hasKeyItem(TAMERS_WHIStle)) then
+		player:startEvent(0x0003); -- Accepted Quest, has Key Item: Tamer's Whistle
+	elseif(ANewDawn == QUEST_COMPLETED) then
+		player:startEvent(0x0000);
	end
	
	return 1;

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

	if(csid == 0x00a4 and option == 0) then
		player:addQuest(JEUNO, SAVE_MY_SON);
		debugTeleport(player,17293694); -- Nightflowers
	elseif(csid == 0x00a3) then
		if(player:getFreeSlotsCount(0) >= 1) then
			player:addTitle(LIFE_SAVER);
			player:addItem(13110);
			player:messageSpecial(ITEM_OBTAINED, 13110);
			player:addGil(GIL_RATE*2100);
			player:messageSpecial(GIL_OBTAINED, GIL_RATE*2100);
			player:setVar("SaveMySon_Event",0);
			player:needToZone(true);
			player:addFame(JEUNO,30);
			player:completeQuest(JEUNO,SAVE_MY_SON);
		else
		   player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,13110);
		end
	elseif((csid == 0x0005 or csid == 0x0004) and option == 1) then
		player:addQuest(JEUNO, A_NEW_DAWN);
	elseif(csid == 0x0005 and option == 0) then
		player:setVar("bstAF3event",1); -- Flags rejected quest, uses alternate cs next time.
	end

end;
