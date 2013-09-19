-----------------------------------
-- Area: Southern San d'Oria
-- NPC:  Deraquien
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- @pos -98 -2 31 230
-------------------------------------
package.loaded["scripts/zones/Southern_San_dOria/TextIDs"] = nil;
-----------------------------------

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
	
	local rank = player:getRank();
	local ATimelyVisit = player:getQuestStatus(SANDORIA,A_TIMELY_VISIT);
	local Fame = player:getFameLevel(SANDORIA);
	local ATimelyVisitProgress = player:getVar("ATimelyVisitProgress");
	local nation = player:getNation();
	local mission = player:getCurrentMission(nation);

	if(player:getQuestStatus(SANDORIA,LURE_OF_THE_WILDCAT_SAN_D_ORIA) == QUEST_ACCEPTED and player:getMaskBit(player:getVar("wildcatSandy_var"),5) == false) then
		player:startEvent(0x032b);
    elseif (nation == 0 and rank >= 2 and Fame >= 3 and ATimelyVisit == 0) or (nation ~= 0 and mission >=5 and Fame >= 3 and ATimelyVisit == 0)then
		if (ATimelyVisitProgress == 1) then
			player:startEvent(0x002f); -- shortened initial cs for the quest
		else
			player:startEvent(0x0021); -- initial cs for the quest
		end;	
	elseif	(ATimelyVisit == 1 and ATimelyVisitProgress == 2) then
		player:startEvent(0x0022); -- reminder to see Narvecaint
	elseif	(ATimelyVisit == 1 and ATimelyVisitProgress == 3) then
		player:startEvent(0x0050); -- see Halver
	elseif	(ATimelyVisit == 1 and ATimelyVisitProgress == 4) then
		player:startEvent(0x0014); -- reminder to see Halver
	elseif	(ATimelyVisit == 1 and ATimelyVisitProgress == 6) then
		player:startEvent(0x0057); -- see Phillone
	elseif	(ATimelyVisit == 1 and ATimelyVisitProgress == 7) then
		player:startEvent(0x001e); -- reminder to see Phillone
	elseif 	(ATimelyVisit == 1 and ATimelyVisitProgress == 8) then
		player:startEvent(0x0026); -- go to Jugner Forest
	elseif (ATimelyVisit == 2) then
		player:startEvent(0x028e); -- after quest completed
	else
		player:startEvent(0x012);
	end
	
	
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);

	if (csid == 0x0021) then
		if (option == 1) then
			player:addQuest(A_TIMELY_VISIT);
			player:getVar("ATimelyVisitProgress");
			player:setVar("ATimelyVisitProgress",2);
		else
			player:getVar("ATimelyVisitProgress");
			player:setVar("ATimelyVisitProgress",1);
		end;	
	elseif (csid == 0x002f and option == 1) then
		player:addQuest(A_TIMELY_VISIT);
		player:setVar("ATimelyVisitProgress",2);
	elseif (csid == 0x0050) then
		player:setVar("ATimelyVisitProgress",4);
	elseif (csid == 0x0014) then
		player:setVar("ATimelyVisitProgress",5);
	elseif (csid == 0x0057) then
		player:setVar("ATimelyVisitProgress",7);
	elseif (csid == 0x0026) then
		player:setVar("ATimelyVisitProgress",9);
		player:setPos(-206,-3,67);
	end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
	
	if(csid == 0x032b) then
		player:setMaskBit(player:getVar("wildcatSandy_var"),"wildcatSandy_var",5,true);
	end
	
end;

---------other CS
--	player:startEvent(0x028e) -- nothing to report 
--	player:startEvent(0x0021)-- theif of royl sceptre  
--	player:startEvent(0x002f)-- as again about the theif  
--	player:startEvent(0x0022) -- reminder of theif in la thein 
--	player:startEvent(0x0050)  -- thief caught but phillone was there
--	player:startEvent(0x0014)  -- go get reward for thief
--	player:startEvent(0x0057) -- vijrtall shows up and derq tells you go talk tho phillone 
--	player:startEvent(0x001e) --reminder go talk to phillone 
--	player:startEvent(0x0026) -- go help  retrieve royal sceptre 
--	player:startEvent(0x001b) -- the lady wanst involved in the theft :( 
