-----------------------------------
--	Area: Port Windurst
--	NPC:  Sachetan I.M.

-- X Grant Signet
-- X Recharge Emperor Band, Empress Band, or Chariot Band
-- X Accepts traded Crystals to fill up the Rank bar to open new Missions.
-- X Sells items in exchange for Conquest Points
-- X Start Supply Run Missions and offers a list of already-delivered supplies.
--   Start an Expeditionary Force by giving an E.F. region insignia to you. 
-------------------------------------
package.loaded["scripts/zones/Port_Windurst/TextIDs"] = nil;
package.loaded["scripts/globals/conquestguards"] = nil;
-------------------------------------

require("scripts/globals/settings");
require("scripts/globals/conquestguards");
require("scripts/zones/Port_Windurst/TextIDs");

guardnation = BASTOK;	-- SANDORIA, BASTOK, WINDURST, JEUNO
guardtype	= 2;		-- 1: city, 2: foreign, 3: outpost, 4: border
size 		= table.getn(BastInv);
inventory 	= BastInv;

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
   
	if(player:getNation() == guardnation and player:getVar("supplyQuest_started") > 0 and supplyRunFresh(player) == 0) then
		player:showText(npc,CONQUEST + 40); -- "We will dispose of those unusable supplies."
		region = player:getVar("supplyQuest_region");
		player:delKeyItem(getSupplyKey(region));
		player:messageSpecial(KEYITEM_OBTAINED + 1,getSupplyKey(region));
		player:setVar("supplyQuest_started",0);
		player:setVar("supplyQuest_region",0);
	else
		Menu1 = getArg1(guardnation,player);
		Menu2 = getExForceAvailable(guardnation,player);
		Menu3 = conquestRanking();
		Menu4 = getSupplyAvailable(guardnation,player);
		Menu5 = player:getVar("supplyQuest_BASTOK");
		Menu6 = getArg6(player);
		Menu7 = getCP(player);
		Menu8 = getRewardExForce(guardnation,player);
		
		player:startEvent(0x7ff7,Menu1,Menu2,Menu3,Menu4,Menu5,Menu6,Menu7,Menu8);
	end
	
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("onUpdateCSID: %u",csid);
--printf("onUpdateOPTION: %u",option);

	if(option >= 32768 and option <= 32944) then
		for Item = 1,size,3 do
			if(option == inventory[Item]) then
				CPVerify = 1;
				if(getCP(player) >= inventory[Item + 1]) then
					CPVerify = 0;
				end;
				
				player:updateEvent(2,CPVerify,inventory[Item + 2]);
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
		player:delStatusEffect(EFFECT_SIGIL);
		player:delStatusEffect(EFFECT_SANCTION);
		player:addStatusEffect(EFFECT_SIGNET,0,0,duration); -- Grant Signet
	elseif(option >= 32768 and option <= 32944) then
		myCP = getCP(player);
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
					if(player:getNation() == guardnation) then
						PlayerCP = myCP - inventory[Item + 1];
					else
						if(inventory[Item + 1] <= 8000) then
							PlayerCP = myCP - inventory[Item + 1] * 2;
						else
							PlayerCP = myCP - inventory[Item + 1] + 8000;
						end;
					end;
					setCP(player,PlayerCP);
					player:addItem(inventory[Item + 2],1);
					player:messageSpecial(ITEM_OBTAINED,inventory[Item + 2]);
				else
					player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,inventory[Item + 2]);
				end;
				break;
			end;
		end;
	elseif(option >= 65541 and option <= 65565) then -- player chose supply quest.
		region = option - 65541;
		player:addKeyItem(getSupplyKey(region));
		player:messageSpecial(KEYITEM_OBTAINED,getSupplyKey(region));
		player:setVar("supplyQuest_started",VanadielDayOfTheYear());
		player:setVar("supplyQuest_region",region);
	end;
	
end;