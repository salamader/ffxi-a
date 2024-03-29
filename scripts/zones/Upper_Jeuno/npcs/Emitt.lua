-----------------------------------
-- Area: Upper Jeuno
-- NPC:  Emitt
-- @pos -95 0 160 244
-------------------------------------
package.loaded["scripts/zones/Upper_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/conquest");
require("scripts/zones/Upper_Jeuno/TextIDs");

guardnation = OTHER;	-- SANDORIA, BASTOK, WINDURST, OTHER(Jeuno).
guardtype	= 1;		-- 1: city, 2: foreign, 3: outpost, 4: border

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
   tradeConquestGuard(player,npc,trade,guardnation,guardtype);
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	Menu1 = getArg1(guardnation,player);
	Menu3 = conquestRanking();
	Menu6 = getArg6(player);
	Menu7 = player:getCP();
	
	player:startEvent(0x7ffb,Menu1,0,Menu3,0,0,Menu6,Menu7,0); 
	
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("onUpdateCSID: %u",csid);
--printf("onUpdateOPTION: %u",option);
	
	if(player:getNation() == 0) then 
		inventory = SandInv;
		size = table.getn(SandInv);
	elseif(player:getNation() == 1) then 
		inventory = BastInv;
		size = table.getn(BastInv);
	else 
		inventory = WindInv;
		size = table.getn(WindInv);
	end
	
	if(option >= 32768 and option <= 32944) then
		for Item = 1,size,3 do
			if(option == inventory[Item]) then
				CPVerify = 1;
				if(player:getCP() >= inventory[Item + 1]) then
					CPVerify = 0;
				end;
				
				player:updateEvent(2,CPVerify,inventory[Item + 2]); -- can't equip = 2 ?
				break;
			end;
		end;
	end;
	
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("onFinishCSID: %u",csid);
--printf("onFinishOPTION: %u",option);
	
	if(option == 1) then
		duration = (player:getRank() + getNationRank(player:getNation()) + 3) * 3600;
		player:delStatusEffect(EFFECT_SIGNET);
		player:addStatusEffect(EFFECT_SIGNET,0,0,duration); -- Grant Signet
	elseif(option >= 32768 and option <= 32944) then
		for Item = 1,size,3 do
			if(option == inventory[Item]) then
				
				if(player:hasItem(inventory[Item + 2]) == 1) then
					if(inventory[Item + 2] == 0x3D91) then 			-- Chariot Band
						cannotObtain = 1;
					elseif(inventory[Item + 2] == 0x3D92) then		-- Empress Band
						cannotObtain = 1;
					elseif(inventory[Item + 2] == 0x3D93) then		-- Emperor Band
						cannotObtain = 1;
					end
				else
					cannotObtain = 0;
				end
				
				if(player:getFreeSlotsCount() >= 1 and cannotObtain == 0) then
               -- Logic to impose limits on exp bands
               if (option >= 32933 and option <= 32935) then
                  if (checkConquestRing(player) > 0) then
                     player:messageSpecial(CONQUEST+60,0,0,inventory[Item+2]);
                     break;
                  else
                     player:setVar("CONQUEST_RING_TIMER",getConquestTally());
                  end
               end
					itemCP = inventory[Item + 1];
					player:delCP(itemCP);
					player:addItem(inventory[Item + 2],1);
					player:messageSpecial(ITEM_OBTAINED,inventory[Item + 2]);
				else
					player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,inventory[Item + 2]);
				end;
				break;
			end;
		end;
	end;
	
end;