-----------------------------------
-- Ability: Scavenge
-- Player will have a default 10%
-- chance of finding items.
-- Hunter's Socks equipped will
-- increase chance by 5%.
-- Items found are up to 49% of
-- ammo spent in the zone. Up to 1
-- stack of each ammo type.
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)

	-- RNG AF2 quest check
	local FireAndBrimstoneCS = player:getVar("fireAndBrimstone");		
	
	if (player:getZone() == 151 and FireAndBrimstoneCS == 5 and -- zone + quest match
		player:getYPos() > -43 and player:getYPos() < -38 and -- Y match
	    player:getXPos() > -85 and player:getXPos() < -73 and -- X match
		player:getZPos() > -85 and player:getZPos() < -75 and -- Z match		
		math.random(100) < 50) then
		
		if (player:getFreeSlotsCount() == 0) then 
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,1113);
		else 
			player:addItem(1113);
			player:messageSpecial(ITEM_OBTAINED,1113);
		end
		
	end

-- OLD SCAVENGE ABILITY
--	-----------------------------------
--	--	zoneSet contains an array of zoneIds and corresponding setId
--	--	(zoneId,setId,zoneId,setId,zoneId,setId,...)
--	-----------------------------------
--	zoneSet = {2,2,4,6,5,9,7,6,9,8,11,5,12,5,24,6,25,6,27,7,28,8,29,8,30,7,
--		  33,9,34,9,35,9,51,8,52,8,54,9,57,9,61,9,62,9,65,9,68,9,72,9,79,
--		  8,81,7,82,8,83,9,84,9,85,9,88,7,89,9,90,9,91,8,92,9,95,7,96,9,
--		  97,9,98,9,99,9,100,1,101,1,102,2,103,4,104,5,105,5,106,1,107,1,
--		  108,2,109,5,110,5,111,6,112,7,113,9,114,6,115,2,116,1,117,2,118,4,
--		  119,5,120,5,121,5,122,9,123,6,124,6,125,7,126,5,127,7,128,9,130,9,
--		  136,9,137,7,140,1,141,2,142,2,143,1,145,1,147,5,148,7,149,5,150,7,
--		  151,5,152,7,153,9,154,9,157,6,158,6,159,8,160,9,161,8,162,8,164,9,
--		  166,6,167,8,169,7,171,9,172,1,173,5,174,8,175,9,176,7,177,9,178,9,
--		  184,5,190,4,191,1,192,1,193,4,194,2,195,7,196,4,197,7,198,4,200,7,
--		  204,8,205,9,208,8,212,9,213,8};
--	-----------------------------------
--	--	itemSet contains an array of setIds and corresponding item
--	--	tables (setId,{itemlist})
--	-----------------------------------
--	itemSet = {0,{0X0000},
--		  1,{0x04BB,0x04BE,0x02CB,0x02C1,0x04C5,0x1064,0x1065},
--		  2,{0x04BF,0x04DA,0x02CB,0x02C1,0x04C6,0x1064,0x1065,0x1496,0x149E},
--		  3,{0x04DB,0x05EB,0x02CB,0x02C1,0x04C6,0x1064,0x1065,0x1496,0x149E},
--		  4,{0x04DB,0x05EB,0x02CB,0x02C1,0x04C6,0x1064,0x1065,0x1496,0x149E,0x03B3},
--		  5,{0x04C1,0x04DD,0x04C6,0x02CB,0x02C1,0x1064,0x1065,0x1496,0x149E,0x14A4,0x03B3},
--		  6,{0x04E1,0x04DC,0x04C7,0x02CB,0x02C1,0x1064,0x1065,0x1496,0x149E,0x14A4,0x03B3},
--		  7,{0x04BC,0x04E2,0x02CB,0x02C1,0x04C8,0x1064,0x1065,0x1496,0x149E,0x14A4,0x03B3},
--		  8,{0x065B,0x04BD,0x02CB,0x02C1,0x04E6,0x1064,0x1065,0x1496,0x149E,0x14A4,0x03B3},
--		  9,{0x04E3,0x04BD,0x04E6,0x02CB,0x02C1,0x1064,0x1065,0x1496,0x149E,0x14A4,0x03B3}};
--
--	-----------------------------------
--	--	Determine the current zone's setId
--	-----------------------------------	
--	currZone = player:getZone();	
--	setId = 0;	
--	i = 1;
--	while i <= (table.getn(zoneSet)-1) do
--		if (zoneSet[i] == currZone) then 
--			setId = zoneSet[i+1];
--			break; 
--		end
--		i = i+2;
--	end;
--
--	-----------------------------------
--	--	Set itemList array based on setId
--	-----------------------------------	
--	itemList = {0X0000};
--	j = 1
--	while j <= (table.getn(itemSet))do
--		if (itemSet[j] == setId) then
--			itemList = itemSet[j+1];
--			break;
--		end
--		j = j+2;
--	end;
--
--	-----------------------------------
--	--	Determine found item and if player gets the item
--	--	Player will receive item 10% of the time
--	--	Hunter's Socks & Hunter's Socks +1 increase rate by 5%
--	-----------------------------------	
--	rate = SCAVENGE_RATE * 100;
--	if (player:getEquipID(SLOT_FEET) == 0x3713 or player:getEquipID(SLOT_FEET) == 0x3C02) then
--		rate = rate + 5;
--	end;
--	if (rate > 100) then rate = 100; end
--	
--	rand = math.random(1,table.getn(itemList));
--	item = itemList[rand];
--	
--	rand = math.random(0,99);
--	if (rand >= rate) then
--		item = 0x0000;
--	end;
--
--	-----------------------------------
--	--	Compensate for multiple itemIDs for the same item (Old Ammo)
--	-----------------------------------
--	oldAmmo = {0x1496,0x1497,0x1498,0x1499,0x149A,0x149B,0x149C,0x149D,
--		  0x149E,0x149F,0x14A0,0x14A1,0x14A2,0x14A3,0x14A4,0x14A5};	
--	
--	if (item == 0x1496 or item == 0x149E or item == 0x14A4) then
--		if (item == 0x1496) then
--			min = 1;
--			max = 8;
--		
--		elseif (item == 0x149E) then
--			min = 9;
--			max = 14;
--		else
--			min = 15;
--			max = 16;
--		end;
--		rand = math.random(min,max);
--		item = oldAmmo[rand];
--	end;	

	local feet = player:getEquipID(SLOT_FEET);
	local rate = SCAVENGE_RATE * 100;
	local item = 1;
	
	if (feet == 0x3713 or feet == 0x3C02) then
		rate = rate + 5;
	end;
	if (rate > 100) then 
		rate = 100;
	end
	
	local rand = math.random(0,99);
	if (1 >= rate) then
		item = 0;
		printf("Fail Item: %u", item);
	end;
	
	local rangedAmmo =
	{
		-- Arrows
		21307, 21306, 19195, 18154, 18178, 17319, 21309, 18181, 18182, 18183, 18184, 18185, 18186, 18187, 18188,
		18159, 18699, 17332, 17322, 19800, 17317, 18156, 17323, 17320, 17325, 17324, 21308, 18697, 18730, 17331,
		18696, 17334, 18157, 19182, 18155, 17321, 18158, 17330, 21305, 18698, 18700, 17318, 17326, 17327, 17329,
		17333, 19193, 18738, 18740, 
		-- Bolts
		21321, 18148, 19801, 21320, 19200, 18150, 18151, 17339, 17336, 21322, 19196, 17338, 19183, 19197, 18153,
		21324, 17337, 21323, 17335, 18149, 21319, 18152, 18198, 18190, 18191, 18192, 18193, 18194, 17328, 17327,
		18379, 19194,
		-- Bullets
		21337, 19803,  21336, 18195, 17276, 17343, 17340, 18713, 18235, 21338, 19184, 19198, 19201, 17278, 17312,
		21339, 19199,  19820, 19228, 17300, 17341, 18160, 18723, 19229, 21335, 21334, 19214, 19236, 19180,
		-- Shells
		17342, 18255
	}
	
	local rangedAmmo99 =
	{
		-- Arrows
		"21307", "21306", "19195", "18154", "18178", "17319", "21309", "18181", "18182", "18183", "18184", "18185", "18186", "18187", " 18188",
		"18159", "18699", "17332", "17322", "19800", "17317", "18156", "17323", "17320", "17325", "17324", "21308", "18697", "18730", " 17331",
		"18696", "17334", "18157", "19182", "18155", "17321", "18158", "17330", "21305", "18698", "18700", "17318", "17326",
		-- Bolts
		"21321", "18148", "19801", "21320", "19200", "18150", "18151", "17339", "17336", "21322", "19196", "17338", "19183", "19197", "18153",
		"21324", "17337", "21323", "17335", "18149", "21319", "18152", "18198", "18190", "18191", "18192", "18193", "18194",
		-- Bullets
		"21337", "19803", " 21336", "18195", "17276", "17343", "17340", "18713", "18235", "21338", "19184", "19198", "19201", "17278", "17312",
		"21339", "19199", " 19820", "19228", "17300", "17341", "18160", "18723", "19229", "21335"
	}
		
	local rangedAmmo12 =
	{
		-- Arrows
		"17327", "17329", "17333",
		-- Bolts
		"17328", "17327",
		-- Shells
		"17342"
	}
		
	local rangedAmmo1 =
	{
		-- Arrows
		"19193", "18738", "18740", 
		-- Bolts
		"18379", "19194",
		-- Shells
		"18255", 
		-- Bullets
		"21334", "19214", "19236", "19180"
	}
			
	local amount =  0; 
	local extra scavengeEffect = 0;
	
	if (feet == 0x3713 or feet == 0x3C02) then
		scavengeEffect = 5;
	end;
	
	local z = 1;
	
	-----------------------------------
	--	Give player the scavenged item
	-----------------------------------
	if (player:getFreeSlotsCount() == 0) then
		ability:setMsg(356);
		return;
	elseif (item ~= 0) then
		ability:setMsg(140);
		z = 1;
		while z <= 112 do
			-- printf("Start Loop Ammo: %u Amount: %u /n", rangedAmmo[z], player:getVar("Ammo" .. tostring(rangedAmmo[z])));
			amount = math.ceil((player:getVar("Ammo" .. tostring(rangedAmmo[z]))) * (((player:getMainLvl() / 200) + ((scavengeEffect + player:getMerit(MERIT_SCAVENGE_EFFECT)) / 100))) - 1);
			if (amount < 0) then
				amount = 0;
			end
			-- printf("Amount: %u /n", amount);
			if (amount < 1 and amount > 0) then
				amount = 1;
			end
			-- printf("Amount: %f /n", amount);
			-- printf("Multiplier: %f /n", ((player:getMainLvl() / 200) + ((scavengeEffect + player:getMerit(MERIT_SCAVENGE_EFFECT)) / 100)));
			
			if (amount > 0) then
				item = rangedAmmo[z];
				-- printf("Ammo greater than zero: %u Amount: %f /n", rangedAmmo[z], amount);
			end
				
			local a = 1;
			while a <= 96 do
				if(rangedAmmo[z] == rangedAmmo99[a]) then
					if(amount > 99) then
						amount = 99;
					end
				end
				a = a + 1;
			end
			a = 1;
			while a <= 6 do
				if(rangedAmmo[z] == rangedAmmo12[a]) then
					if(amount > 12) then
						amount = 12;
					end
				end
				a = a + 1;
			end
			a = 1;
			while a <= 10 do
				if(rangedAmmo[z] == rangedAmmo1[a]) then
					if(amount > 1) then
						amount = 1;
					end
				end
				a = a + 1;
			end
			if (amount > 0) then
				-- printf("Amount: %u ", amount);
				-- printf("Set Item to 0: %u ", rangedAmmo[z]);
				player:addItem(rangedAmmo[z], amount);
				player:setVar("Ammo" .. tostring(rangedAmmo[z]), 0);
			end
			z = z + 1;
		end
		if (item == 1) then
			ability:setMsg(139);
			return;
		else
			return item;
		end
	else
		ability:setMsg(139);
		return;
	end
end;
