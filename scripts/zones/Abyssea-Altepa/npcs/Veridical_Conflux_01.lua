-----------------------------------
-- Area: Abyssea Altepa
-- NPC: Veridical Conflux #01
-- Type: Standard NPC
-- @zone 218
-- @pos 412 -1 288 218
-----------------------------------
package.loaded["scripts/zones/Abyssea-Altepa/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
   
   mask = player:getVar("ConfluxMask[Altepa]");
   activated = player:getMaskBit(mask,0);
   cruor = player:getVar("cruor");
   cost = 1;
   
   if(player:hasKeyItem(IVORY_ABYSSITE_OF_CONFLUENCE)) then
      cost = cost - 0.2
   end
   if(player:hasKeyItem(CRIMSON_ABYSSITE_OF_CONFLUENCE)) then
      cost = cost - 0.2
   end
   if(player:hasKeyItem(INDIGO_ABYSSITE_OF_CONFLUENCE)) then
      cost = cost - 0.2
   end
   testvar = (600 + 800) * cost
   if(activated) then
    --  player:startEvent(0x0854, (600 + 800 * 65536) * cost, (1000 + 1200 * 65536) * cost, (1400 + 1600 * 65536) * cost, (1800 + 2000 * 65536) * cost, mask, 9, 1, cruor);
		player:startEvent(0x0854, 1, cost, cost, cost, mask, 9, 1, cruor);
   else
      player:startEvent(0x0855, 50 * cost, 0, 0, 0, 0, 0, 2, cruor);
   end
   
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--	 printf("CSID: %u",csid);
--	 printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--	 printf("CSID: %u",csid);
--	 printf("RESULT: %u",option);
	 
	 local price = cost;
	
	if (csid == 0x0855) then
		if(option == 1) then
			player:setVar("ConfluxMask[Altepa]",mask + 1);
			player:setVar("cruor",cruor - 50 * price);	
		end
		
	
	elseif (csid == 0x0854) then
	--	if(option == 65537) then
	--		player:setVar("cruor",cruor - 1);
	--		player:setPos(410,0,287,255);
			print("price: %u",testvar);
	--	elseif(option == 1) then
	--		player:setVar("cruor", cruor - price);
		--	player:setPos(404,0,288);
	--	end
		
	end
	
	
end;

