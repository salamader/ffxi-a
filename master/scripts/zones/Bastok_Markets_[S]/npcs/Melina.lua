-----------------------------------
-- Area: Bastok Markets (S)
-- NPC: NPC
-----------------------------------

require("scripts/globals/shop");
package.loaded["scripts/zones/Bastok_Markets_[S]/TextIDs"] = nil;
require("scripts/zones/Bastok_Markets_[S]/TextIDs");

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
		player:startEvent(0x0008);
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
	            player:setPos(380,0,147,192,88);
	        end
	end
end;



