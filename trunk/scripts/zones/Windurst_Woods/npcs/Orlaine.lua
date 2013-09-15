-----------------------------------
-- Area: Windurst Woods
-- NPC: Orlaine
-- Chocobo Vendor
-- @pos 136.107, -5.250, -131.865
-- @zone 241
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

price = 100;
gil = player:getGil();
hasLicense = player:hasKeyItem(CHOCOBO_LICENSE);
level = player:getMainLvl();

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
    local price = 100;

	if (csid == 0x2712 and option == 0) then
        if (player:delGil(price)) then
            if (player:getMainLvl() >= 20) then
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(1800 + durationMod),true);
            else
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,(900 + durationMod),true);
            end
            player:setPos(-122,-4,-520,0,0x74);
        end
	end

end;