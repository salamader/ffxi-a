-----------------------------------
--  Area: Jugner Forest (S)
--   NPC: Helmyre
--  Type: Chocobo Renter
-- @zone: 82
--  @pos: -120.853 -1 -152.582
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Jugner_Forest_[S]/TextIDs"] = nil;
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	price = 100;
	gil = player:getGil();
	hasLicense = player:hasKeyItem(CHOCOBO_LICENSE);
	if (hasLicense and level >= 15) then
		player:startEvent(0x00d0);
	end
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
	local durationMod = 0;
	durationMod = player:getMod(MOD_CHOCOBO_TIME) * 60;
	local price = 100;
	if (csid == 0x06A and option == 0) then
	        if (player:delGil(price)) then
	            if (player:getMainLvl() >= 20) then
	                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(1800 + durationMod),true);
	            else
	                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(900 + durationMod),true);
	            end
	        end
	end
end;

