-----------------------------------
-- Area: Lower Jeuno
-- NPC: Fephita
-- Chocobo Vendor
-- @zone 245
-- @pos -89.284, -0.100, -200.190
-----------------------------------

require("scripts/globals/settings");
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

	local price = 100;
	local gil = player:getGil();
	local hasLicense = player:hasKeyItem(CHOCOBO_LICENSE);
	local level = player:getMainLvl();

	if (hasLicense and level >= 15) then
		player:startEvent(0x2713,price,gil);
	else
		player:startEvent(0x2716,price,gil);
	end

end;

-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("OPTION:",option);
    local durationMod = 0;
    durationMod = player:getMod(MOD_CHOCOBO_TIME) * 60;
    local price = 100;

	if (csid == 0x2713 and option == 0) then
        if (player:delGil(price)) then
            if (player:getMainLvl() >= 20) then
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(1800 + durationMod),true);
            else
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(900 + durationMod),true);
            end
            player:setPos(340,24,608,0x70,0x6e);
        end
	end

end;