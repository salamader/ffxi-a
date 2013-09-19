-----------------------------------
-- Area: Kuftal Tunnel
-- NPC:  ??? (Spawn Cancer)
-- @pos 
-----------------------------------
package.loaded["scripts/zones/Kuftal_Tunnel/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Kuftal_Tunnel/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(trade:hasItemQty(4514,1) and trade:getItemCount() == 1) then -- Trade Quus
		player:tradeComplete();
	  --SpawnMob(17490232,180):updateEnmity(player); -- Robber Crab
		SpawnMob(17490231,180):updateEnmity(player); -- Cancer
	end
	
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:messageSpecial(NOTHING_HAPPENS);
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
end;