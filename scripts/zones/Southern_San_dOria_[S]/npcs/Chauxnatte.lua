-----------------------------------
-- Area: Southern SandOria [S]
-- NPC: Chauxnatte 
-- @zone 80
-- @pos 85 1 -51
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

	hasLicense = player:hasKeyItem(CHOCOBO_LICENSE);
	level = player:getMainLvl();
	price = 100;
	gil = player:getGil();

	if (hasLicense and level >= 15) then
		player:startEvent(0x06A);
	else
		player:startEvent(0x06B);
	end

end;

  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
print("CSID:",csid);
print("OPTION:",option);
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
	            player:setPos(94,-62,266,40,81);
	        end
	end
end;