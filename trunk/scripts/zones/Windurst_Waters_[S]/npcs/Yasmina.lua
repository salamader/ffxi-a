-----------------------------------
--  Area: Windurst Waters (S)
--   NPC: Yasmina
--  Type: Chocobo Renter
-- @zone: 94
--  @pos: -34.972 -5.815 221.845
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Windurst_Waters_[S]/TextIDs"] = nil;
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
	player:startEvent(0x0006, 10, 10);
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
	if (csid == 0x0006 and option == 0) then
        if (player:delGil(price)) then
            if (player:getMainLvl() >= 20) then
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(1800 + durationMod),true);
            else
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(900 + durationMod),true);
            end
            player:setPos(320,-3,-45,189,95);
        end
	end
end;

