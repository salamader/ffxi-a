-----------------------------------
-- Area: Lower Jeuno
-- NPC: Audee
-- Chocobo Vendor
-- @zone 245
-- @pos -86.651, -0.100, -196.351
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
		player:startEvent(0x2712,price,gil);
	else
		player:startEvent(0x2715,price,gil);
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
price = 100;
level = player:getMainLvl();

	if (csid == 0x2712 and option == 0) then
        if (player:delGil(price)) then
            if (level >= 20) then
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(1800 + durationMod),true);
            else
                layer:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(900 + durationMod),true);
            end
            player:setPos(340,24,608,0x70,0x6e);
        end
	end

end;