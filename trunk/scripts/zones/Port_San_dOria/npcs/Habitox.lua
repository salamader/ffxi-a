-----------------------------------
-- Area: Port Sandoria
-- NPC: Habitox
-- Type: Goblin Mystery Box
-- @zone 232
-- @pos 10.000, -8.000, -130.000
--
-- Menu
-- startEvent(0x031E, Item1, (Item2 or Dial #), Item3, 0, MysteryBoxTally)
--
-- Tally Increase Amount 0: Smidge 1: Someamawhats 2: Gobby-fold 3: Ginormagantic
-- startEvent(0x0199, 0, 0, 0, 0, 0, tallyIncrease)
-----------------------------------
package.loaded["scripts/zones/Port_San_dOria/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Port_San_dOria/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

	local count = trade:getItemCount();
	local tallyIncrease = 1;
	
	if(player:getVar("MysteryBoxTally") == 10000) then
		player:startEvent(0x0323); -- tally points total full
	elseif(player:getVar("MysteryTradeTally") == 10) then
		player:startEvent(0x0322); -- tally points for trades full for day
	elseif(count == 1) then
		player:startEvent(0x0320, 0, 0, 0, 0, 0, tallyIncrease); -- take item add tally points
	else
		player:startEvent(0x0321); -- don't take item
	end
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	foodItems = 
	{
		5680, -- Agaricus
		4511, -- Ambrosia
		4513, -- Bottle of Amrita
		4300, -- Apple Au Lait
		4413, -- Apple Pie
		4542, -- Brain Stew
		5196, -- Buffalo Jerky
		4548, -- Coeurl Sautee
		4411, -- Dhalmel Pie
		4433, -- Dhalmel Stew
		4350, -- Dragon Steak
		4398, -- Fish Mithkabob
		4276, -- Flint Caviar
		4458, -- Goblin Bread
		4495, -- Goblin Chocolate
		4539, -- Goblin Pie
		5143, -- Goblin Stir-fry
		5146, -- Hedgehog Pie
		4325, -- Hobgoblin Pie
		4424, -- Melon Juice
		4421, -- Melon Pie
		5676, -- Mushroom Sautee
		4361, -- Nebimonite
		4422, -- Orange Juice
		4302, -- Pamama Au Lait
		5752, -- Pot-au-feu
		4446, -- Pumpkin Pie
		5685, -- Rabbit Pie
		4410, -- Roast Mushroom
		4414, -- Rolanberry Pie
		5737, -- Salted Hare
		4279, -- Tavnazian Salad
		4425, -- Tomato Juice
		4512, -- Vampire Juice
		5562, -- White Honey
		4387, -- Wild Onion
		4558, -- Yagudo Drink
		5579  -- Yayla Corbasi
	}
	
	medicineItems = 
	{
		4153, -- Antacid
		4148, -- Antidote
		4150, -- Eye Drops
		5411, -- Dawn Mulsum
		4132, -- Hi-Ether
		4134, -- Hi-Ether +2
		5255, -- Hyper Ether
		4173, -- Hi-Reraiser
		4154, -- Holy Water
		4149, -- Panacea
		4112, -- Potion
		4114, -- Potion +2
		4140, -- Pro-Ether
		4155, -- Remedy
		4136, -- Super Ether
		4138, -- Super Ether +2
		5570, -- Super Reraiser
		4174, -- Vile Elixir
		4120, -- X-Potion
		4122, -- X-Potion +2
		4123, -- X-Potion +3
		5355, -- Elixir Vitae
		4145  -- Elixir
	}
	
	scrollItems = 
	{
		4874, -- Absorb-STR
		4990, -- Army's Paeon V
		4820, -- Burst
		4715, -- Erase
		4755, -- Fire IV
		4812, -- Flare
		4814, -- Freeze
		4247, -- Miratete's Memories
		4714, -- Phalanx
		4818, -- Quake
		4748, -- Raise III
		4717, -- Refresh
		4770, -- Stone IV
		4816, -- Tornado
		4947  -- Utsusemi: Ni
	}
	
	synthesisItems = 
	{
		646,  -- Adaman Ore
		2417, -- Aht Urgan Brass
		894,  -- Beetle Jaw
		880,  -- Bone Chip
		694,  -- Chestnut Log
		898,  -- Chicken Bone
		818,  -- Cotton Thread
		645,  -- Darksteel Ore
		857,  -- Dhalmel Hide
		727,  -- Dogwood Log
		1133, -- Dragon Blood
		756,  -- Durium Ore
		690,  -- Elm Log
		893,  -- Giant Femur
		925,  -- Giant Stringer
		2542, -- Goblin Mess Tin
		2543, -- Goblin Weel
		748,  -- Gold Beastcoin
		817,  -- Grass Thread
		732,  -- Kapor Log
		878,  -- Karakul Skin
		685,  -- Khroma Ore
		819,  -- Linen Thread
		2155, -- Lesser Chigoe
		749,  -- Mythril Beastcoin
		739,  -- Orichalcum Ore
		740,  -- Phrygian Ore
		1828, -- Red Grass Thread
		897,  -- Scorpion Claw
		505,  -- Sheepskin
		750,  -- Silver Beastcoin
		637,  -- Slime Oil
		861,  -- Tiger Hide
		915,  -- Toad Oil
		2304, -- Wamoura Silk
		642,  -- Zinc Ore
		2563, -- Karugo Clay
		884,  -- Black Tiger Fang
		2754, -- Ruszor Fang
		700,  -- Mahogany Log
		699,  -- Oak Log
		2151  -- Marid Hide
	}
	
	popItems = 
	{
		3341, -- Beastly Shank
		1873, -- Brigand's Chart
		3343, -- Blue Pondweed
		3344, -- Red Pondweed
		2583, -- Buffalo Corpse
		1847, -- Fifth Virtue
		1848, -- Fourth Virtue
		1418, -- Gem of the East
		1424, -- Gem of the North
		1420, -- Gem of the South
		1422, -- Gem of the West
		2566, -- Gnaty Pellets
		2565, -- Gnole Pellets
		3339, -- Honey Wine
		3340, -- Sweet Tea
		2573, -- Monkey Wine
		2385, -- Moldy Buckler
		2572, -- Pandemonium Key
		2564, -- Peiste Pellets
		1874, -- Pirate's Chart
		3342, -- Savory Shank
		1849, -- Sixth Virtue
		2384, -- Smoky Flask
		1419, -- Springstone
		1421, -- Summerstone
		1425, -- Winterstone
		1423  -- Autumstone
	}

	otherItems = 
	{
		2322,  -- Attuner
		2324,  -- Drum Magazine
		2351,  -- Dynamo
		2325,  -- Equalizer
		2382,  -- Eraser
		2327,  -- Mana Channeler
		14809, -- Novia Earring
		14808, -- Novio Earring
		2353,  -- Optic Fiber
		2347,  -- Reactive Shield
		2329,  -- Smoke Screen
		2323,  -- Tactical Processor
		2326,  -- Target Marker
		1238,  -- Tree Saplings
	}

	peek1 = 0;
	peek2 = 0;
	peek3 = 0;
	var4 = 0;
	var5 = player:getVar("MysteryBoxTally");
	var6 = 0;
	var7 = 0;
	var8 = 0;

	-- Randomize peek items
	if(math.random(2) == 1) then
		peek1 = foodItems[math.random(38)];
	else
		peek1 = medicineItems[math.random(23)];
	end

	if(math.random(2) == 1) then
		peek2 = scrollItems[math.random(15)];
	else
		peek2 = synthesisItems[math.random(42)];
	end

	if(math.random(2) == 1) then
		peek3 = popItems[math.random(27)];
	else
		peek3 = otherItems[math.random(14)];
	end
	
	if(player:getVar("GoblinMysteryBox") == 0) then -- Initial CS tracking
		player:startEvent(0x031D); -- first diagloge explanation
	else
		if(player:getVar("MysteryBox_Day") < tonumber(os.date("%j"))) then
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") + ((tonumber(os.date("%j")) - player:getVar("MysteryBox_Day")) * 10))); -- add 10 points per day
			player:setVar("MysteryBox_Day",tonumber(os.date("%j"))); -- reset day timer
		end
		player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
	end
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
-- printf("CSID2: %u",csid);
-- printf("RESULT2: %u",option);

	local dial1Items = 
	{
		4413, -- Apple Pie
		5196, -- Buffalo Jerky
		4411, -- Dhalmel Pie
		4495, -- Goblin Chocolate
		4424, -- Melon Juice
		4421, -- Melon Pie
		4422, -- Orange Juice
		4446, -- Pumpkin Pie
		5685, -- Rabbit Pie
		4410, -- Roast Mushroom
		5737, -- Salted Hare
		4425, -- Tomato Juice
		5562, -- White Honey
		4387, -- Wild Onion
		4153, -- Antacid
		4148, -- Antidote
		4150, -- Eye Drops
		4112, -- Potion
		884,  -- Black Tiger Fang
		818,  -- Cotton Thread
		880,  -- Bone Chip
		898,  -- Chicken Bone
		857,  -- Dhalmel Hide
		817,  -- Grass Thread
		878,  -- Karakul Skin
		819,  -- Linen Thread
		749,  -- Mythril Beastcoin
		897,  -- Scorpion Claw
		505,  -- Sheepskin
		861,  -- Tiger Hide
		642,  -- Zinc Ore
		1238  -- Tree Saplings
	}
	
	local dial2Items = 
	{
		4300, -- Apple Au Lait
		4542, -- Brain Stew
		4548, -- Coeurl Sautee
		4433, -- Dhalmel Stew
		4276, -- Flint Caviar
		4458, -- Goblin Bread
		5146, -- Hedgehog Pie
		4325, -- Hobgoblin Pie
		4539, -- Goblin Pie
		5680, -- Agaricus
		4398, -- Fish Mithkabob
		4361, -- Nebimonite
		4302, -- Pamama Au Lait
		5752, -- Pot-au-feu
		5579, -- Yayla Corbasi
		4132, -- Hi-Ether
		4154, -- Holy Water
		4114, -- Potion +2
		4155, -- Remedy
		4120, -- X-Potion
		4122, -- X-Potion +2
		4145, -- Elixir
		646,  -- Adaman Ore
		894,  -- Beetle Jaw
		694,  -- Chestnut Log
		727,  -- Dogwood Log
		756,  -- Durium Ore
		690,  -- Elm Log
		925,  -- Giant Stringer
		2543, -- Goblin Weel
		748,  -- Gold Beastcoin
		1828, -- Red Grass Thread
		750,  -- Silver Beastcoin
		2563, -- Karugo Clay
		4874, -- Absorb-STR
		700   -- Mahogany Log
	}
	
	local dial3Items = 
	{
		5143, -- Goblin Stir-fry
		5676, -- Mushroom Sautee
		4414, -- Rolanberry Pie
		4279, -- Tavnazian Salad
		5411, -- Dawn Mulsum
		4134, -- Hi-Ether +2
		5255, -- Hyper Ether
		4173, -- Hi-Reraiser
		4136, -- Super Ether
		4138, -- Super Ether +2
		5570, -- Super Reraiser
		2417, -- Aht Urgan Brass
		645,  -- Darksteel Ore
		1133, -- Dragon Blood
		893,  -- Giant Femur
		2542, -- Goblin Mess Tin
		732,  -- Kapor Log
		685,  -- Khroma Ore
		2155, -- Lesser Chigoe
		637,  -- Slime Oil
		915,  -- Toad Oil
		2754, -- Ruszor Fang
		699,  -- Oak Log
		2151, -- Marid Hide
		4820, -- Burst
		4715, -- Erase
		4812, -- Flare
		4818, -- Quake
		4717, -- Refresh
		4816, -- Tornado
		740   -- Phrygian Ore
	}
	
	local dial4Items = 
	{
		4513, -- Bottle of Amrita
		4350, -- Dragon Steak
		4512, -- Vampire Juice
		4558, -- Yagudo Drink
		4149, -- Panacea
		4140, -- Pro-Ether
		4174, -- Vile Elixir
		4123, -- X-Potion +3
		5355, -- Elixir Vitae
		4755, -- Fire IV
		4814, -- Freeze
		4748, -- Raise III
		4770, -- Stone IV
		739,  -- Orichalcum Ore
		2304, -- Wamoura Silk
		14809, -- Novia Earring
		14808, -- Novio Earring
		2353, -- Optic Fiber
		2347, -- Reactive Shield
		2329, -- Smoke Screen
		2323, -- Tactical Processor
		2385, -- Moldy Buckler
		1418, -- Gem of the East
		1424, -- Gem of the North
		1420, -- Gem of the South
		1422  -- Gem of the West
	}
	
	local dial5Items = 
	{
		4511, -- Ambrosia
		4990, -- Army's Paeon V
		4247, -- Miratete's Memories
		4714, -- Phalanx
		4947, -- Utsusemi: Ni
		3341, -- Beastly Shank
		1873, -- Brigand's Chart
		3343, -- Blue Pondweed
		3344, -- Red Pondweed
		2583, -- Buffalo Corpse
		1847, -- Fifth Virtue
		1848, -- Fourth Virtue
		2566, -- Gnaty Pellets
		2565, -- Gnole Pellets
		3339, -- Honey Wine
		3340, -- Sweet Tea
		2573, -- Monkey Wine
		2572, -- Pandemonium Key
		2564, -- Peiste Pellets
		1874, -- Pirate's Chart
		3342, -- Savory Shank
		1849, -- Sixth Virtue
		2384, -- Smoky Flask
		1419, -- Springstone
		1421, -- Summerstone
		1425, -- Winterstone
		1423, -- Autumstone
		2322, -- Attuner
		2324, -- Drum Magazine
		2351, -- Dynamo
		2325, -- Equalizer
		2382, -- Eraser
		2327, -- Mana Channeler
		2326  -- Target Marker
	}
	
	local prize1 = dial1Items[math.random(32)];
	local prize2 = 0;
	local prize3 = 0;
	local prize4 = 0;
	local prize5 = 0;
	
	if(math.random(2) == 1) then
		prize2 = dial1Items[math.random(32)];
	else
		prize2 = dial2Items[math.random(36)];
	end
	
	local rand1 = math.random(3);
	if(rand1 == 1) then
		prize3 = dial1Items[math.random(32)];
	elseif(rand1 == 2) then
		prize3 = dial2Items[math.random(36)];
	else
		prize3 = dial3Items[math.random(31)];
	end
	
	local rand2 = math.random(8);
	if(rand2 <= 3) then
		prize4 = dial1Items[math.random(32)];
	elseif(rand2 == 4 or rand2 == 5) then
		prize4 = dial2Items[math.random(36)];
	elseif(rand2 == 6 or rand2 == 7) then
		prize4 = dial3Items[math.random(31)];
	else
		prize4 = dial4Items[math.random(26)];
	end
	
	local rand3 = math.random(10);
	if(rand3 <= 3) then
		prize5 = dial1Items[math.random(32)];
	elseif(rand3 == 4 or rand3 == 5) then
		prize5 = dial2Items[math.random(36)];
	elseif(rand3 == 6 or rand3 == 7) then
		prize5 = dial3Items[math.random(31)];
	elseif(rand3 == 8 or rand3 == 9) then
		prize5 = dial4Items[math.random(26)];
	else
		prize5 = dial5Items[math.random(34)];
	end
	
	if(csid == 0x031E) then
		var5 = player:getVar("MysteryBoxTally"); -- refresh point tally
		-- Re-Randomize peek items
		if(option == 4) then
			if(math.random(2) == 1) then
				peek1 = foodItems[math.random(38)];
			else
				peek1 = medicineItems[math.random(23)];
			end

			if(math.random(2) == 1) then
				peek2 = scrollItems[math.random(15)];
			else
				peek2 = synthesisItems[math.random(42)];
			end

			if(math.random(2) == 1) then
				peek3 = popItems[math.random(27)];
			else
				peek3 = otherItems[math.random(14)];
			end
			player:updateEvent(peek1,peek2,peek3,0,var5); -- Update peek at items
		elseif(option == 9) then
			player:updateEvent(0,1,0,0,var5); -- Update 1st param to Dial 1
			if(var5 < 10) then
				player:updateEvent(0,1,1,0,var5); -- Update 2st param say you don't have the points
			end
		elseif(option == 10) then
			player:addItem(prize1);
			player:messageSpecial(ITEM_OBTAINED,prize1);
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") - 10));
			player:updateEvent(0,0,0,0,var5); -- Update so you wanna go again prompt
		elseif(option == 17) then
			player:updateEvent(0,2,0,0,var5); -- Update 1st param to Dial 2
			if(var5 < 20) then
				player:updateEvent(0,2,1,0,var5); -- Update 2st param say you don't have the points
			end
		elseif(option == 18) then
			player:addItem(prize2);
			player:messageSpecial(ITEM_OBTAINED,prize2);
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") - 20));
			player:updateEvent(0,0,0,0,var5); -- Update so you wanna go again prompt
		elseif(option == 25) then
			player:updateEvent(0,3,0,0,var5); -- Update 1st param to Dial 3
			if(var5 < 30) then
				player:updateEvent(0,3,1,var5); -- Update 2st param say you don't have the points
			end
		elseif(option == 26) then
			player:addItem(prize3);
			player:messageSpecial(ITEM_OBTAINED,prize3);
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") - 30));
			player:updateEvent(0,0,0,0,var5); -- Update so you wanna go again prompt
		elseif(option == 33) then
			player:updateEvent(0,4,0,0,var5); -- Update 1st param to Dial 4
			if(var5 < 40) then
				player:updateEvent(0,4,1,0,var5); -- Update 2st param say you don't have the points
			end
		elseif(option == 34) then
			player:addItem(prize4);
			player:messageSpecial(ITEM_OBTAINED,prize4);
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") - 40));
			player:updateEvent(0,0,0,0,var5); -- Update so you wanna go again prompt
		elseif(option == 41) then
			player:updateEvent(0,5,0,0,var5); -- Update 1st param to Dial 5
			if(var5 < 50) then
				player:updateEvent(0,5,1,0,var5); -- Update 2st param say you don't have the points
			end
		elseif(option == 42) then
			player:addItem(prize5);
			player:messageSpecial(ITEM_OBTAINED,prize5);
			player:setVar("MysteryBoxTally",(player:getVar("MysteryBoxTally") - 50));
			player:updateEvent(0,0,0,0,var5); -- Update so you wanna go again prompt
		end
	end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
	if(csid == 0x031D) then -- shown explanation give initial tally points
		player:setVar("GoblinMysteryBox",1); -- set initial CS viewed
		player:setVar("MysteryBoxTally",50); -- set initial points
		player:setVar("MysteryBox_Day",tonumber(os.date("%j"))); -- Day tracker for tally points
	elseif(csid == 0x031E) then
		var5 = player:getVar("MysteryBoxTally"); -- refresh point tally
		-- Replay menu or cutscene will hang ??
		if(option == 10) then
			player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
		elseif(option == 18) then
			player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
		elseif(option == 26) then
			player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
		elseif(option == 34) then
			player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
		elseif(option == 42) then
			player:startEvent(0x031E,peek1,peek2,peek3,var4,var5,var6,var7,var8); -- menu
		end
	end
end;


-- player:startEvent(0x0324); -- transform to blue treasure chest
