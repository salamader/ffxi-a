-----------------------------------
-- Area: Yhoator Jungle
-- NPC:  Telepoint
-----------------------------------
package.loaded["scripts/zones/Yhoator_Jungle/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/zones/Yhoator_Jungle/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

	item = trade:getItem();

	if(trade:getItemCount() == 1 and item > 4095 and item < 4104) then	
		if(player:getFreeSlotsCount() > 0 and player:hasItem(613) == false) then
			player:tradeComplete();
			player:addItem(613);
			player:messageSpecial(ITEM_OBTAINED,613); -- Faded Crystal
		else
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,613); -- Faded Crystal
		end
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:hasKeyItem(DEM_GATE_CRYSTAL) == false) then
		player:addKeyItem(DEM_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,DEM_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
	end
		
	if(player:hasKeyItem(HOLLA_GATE_CRYSTAL) == false) then
		player:addKeyItem(HOLLA_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,HOLLA_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
	end
		
	if(player:hasKeyItem(MEA_GATE_CRYSTAL) == false) then
		player:addKeyItem(MEA_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,MEA_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
	end
		
	if(player:hasKeyItem(VAHZL_GATE_CRYSTAL) == false) then
		player:addKeyItem(VAHZL_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,VAHZL_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
	end
		
	if(player:hasKeyItem(YHOATOR_GATE_CRYSTAL) == false) then
		player:addKeyItem(YHOATOR_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,YHOATOR_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
	end
		
	if(player:hasKeyItem(ALTEPA_GATE_CRYSTAL) == false) then
		player:addKeyItem(ALTEPA_GATE_CRYSTAL);
		player:messageSpecial(KEYITEM_OBTAINED,ALTEPA_GATE_CRYSTAL);
	else
		player:messageSpecial(ALREADY_OBTAINED_TELE);
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
end;