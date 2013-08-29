-----------------------------------
-- Area: Aht Urhgan Whitegate
-- NPC: Tateeya
-- Automaton Attachment Unlocks
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	local tradeStatus = player:getVar('TateeyaTradeStatus');
	if (tradeStatus == 1) then
		for i=0,7 do
			local subid = trade:getItemSubId(i);
			if (subid >= 0x2000 and subid < 0x2800) then
				if (player:unlockAttachment(subid)) then
					player:startEventString(0x028B, player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName(), subid); --unlock attachment event
					trade:confirmItem(i);
					player:confirmTrade();
				else
					player:startEvent(0x028C); --already unlocked event
				end
				break;
			end
		end
	end
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local tradeStatus = player:getVar('TateeyaTradeStatus');
	if (tradeStatus == 0) then
		if (player:getMainJob() == JOB_PUP) then
			player:startEventString(0x028A, player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName()); --trade me to unlock attachments
		else
			player:startEvent(0x0102); --default no PUP CS
		end
	else
		player:startEventString(0x028A, player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName(), player:getAutomatonName(), 1);
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
	if (csid == 0x028A) then --unlocking attachments explanation
		player:setVar('TateeyaTradeStatus', 1);
	end
end;


