-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/globals/quests");
require("scripts/globals/settings");
require("scripts/globals/shop");
require("scripts/globals/status");
require("scripts/globals/titles");

-----------------------------------
-- onGameIn
-----------------------------------

function onGameIn(player, firstlogin)
    if (firstlogin) then
        CharCreate(player);
    end;



    if (player:getVar("GodMode") == 1) then
	player:addStatusEffect(EFFECT_SENTINEL,100,0,0);
	player:addStatusEffect(EFFECT_MIGHTY_STRIKES,1,0,0);
	player:addStatusEffect(EFFECT_HUNDRED_FISTS,1,0,0);
	player:addStatusEffect(EFFECT_CHAINSPELL,1,0,0);
	player:addStatusEffect(EFFECT_PERFECT_DODGE,1,0,0);
	player:addStatusEffect(EFFECT_INVINCIBLE,1,0,0);
	player:addStatusEffect(EFFECT_MANAFONT,1,0,0);
	player:addStatusEffect(EFFECT_REGAIN,200,1,0);
	player:addStatusEffect(EFFECT_REGEN,50,0,0);
	player:addStatusEffect(EFFECT_REFRESH,50,0,0);
    end
end;

-----------------------------------
-- CharCreate
-----------------------------------

function CharCreate(player)

	local race = player:getRace();
	local body = nil;
	local leg = nil;
	local hand = nil;
	local feet = nil;

	-- ADD RACE SPECIFIC STARTGEAR
	switch(race) : caseof
	{
		-- HUME MALE
 		[1]	= function (x)
	 		body = 0x3157;
	 		hand = 0x31D2;
	 		leg = 0x3253;
			feet = 0x32CD;
  		end,

		-- HUME FEMALE
  		[2]	= function (x)
	  		body = 0x3158;
	  		hand = 0x31D8;
	  		leg = 0x3254;
	  		feet = 0x32D2;
  		end,

		-- ELVAAN MALE
  		[3]	= function (x)
	  		body = 0x3159;
	  		hand = 0x31D3;
	  		leg = 0x3255;
	  		feet = 0x32CE;
  		end,

		-- ELVAAN FEMALE
  		[4]	= function (x)
			body = 0x315A;
			hand = 0x31D7;
			leg = 0x3259;
			feet = 0x32D3;
  		end,

		-- TARU MALE
  		[5]	= function (x)
			body = 0x315B;
			hand = 0x31D4;
			leg = 0x3256;
			feet = 0x32CF;
  		end,

		-- TARU FEMALE
  		[6]	= function (x)
			body = 0x315B;
			hand = 0x31D4;
			leg = 0x3256;
			feet = 0x32CF;
  		end,

		-- MITHRA
  		[7]	= function (x)
			body = 0x315C;
			hand = 0x31D5;
			leg = 0x3257;
			feet = 0x32D0;
  		end,

		-- GALKA
  		[8]	= function (x)
			body = 0x315D;
			hand = 0x31D6;
			leg = 0x3258;
			feet = 0x32D1;
  		end,

  		default = function (x) end,
	}

	-- Add starting gear
	if not(player:hasItem(body)) then
		player:addItem(body);
		player:equipItem(body);
	end

	if not(player:hasItem(hand)) then
		player:addItem(hand);
		player:equipItem(hand);
	end

	if not(player:hasItem(leg)) then
		player:addItem(leg);
		player:equipItem(leg);
	end

	if not(player:hasItem(feet)) then
		player:addItem(feet);
		player:equipItem(feet);
	end

	-- ADD JOB SPECIFIC STARTGEAR
	switch(player:getMainJob()) : caseof
	{
		-- WARRIOR JOB
		[0x01]= function (x)
			if not(player:hasItem(0x4096)) then
				player:addItem(0x4096);
			end
		end,

		-- MONK JOB
		[0x02]= function (x)
			if not(player:hasItem(0x3380)) then
	 			player:addItem(0x3380);
	 		end
		end,

		-- WHITE MAGE
		[0x03]= function(x)
			if not(player:hasItem(0x42AC)) then
				player:addItem(0x42AC);
			end

			if not(player:hasItem(0x1200)) then
			player:addItem(0x1200);
			end
		end,

 		-- BLACK MAGE
		[0x04] = function(x)

			if not(player:hasItem(0x42D0)) then
				player:addItem(0x42D0);
			end

			if not(player:hasItem(0x11FF)) then
				player:addItem(0x11FF);
			end
		end,

 		-- RED MAGE
	 	[0x05]= function (x)
			if not(player:hasItem(0x4062)) then
				player:addItem(0x4062);
			end
			if not(player:hasItem(0x11FE)) then
				player:addItem(0x11FE);
			end
 		end,

 		-- THIEF
		[0x06]= function (x)
			if not(player:hasItem(0x4063)) then
				player:addItem(0x4063);
			end
 		end,

 		default = function (x) end,
	}

	-- ADD NATION SPECIFIC STARTGEAR
 	switch (player:getNation()) : caseof
	{
 		-- SANDY CITIZEN
		[0] = function (x)
			if ((race == 3) or (race == 4))
				then player:addItem(0x34B7);
			end;
			player:addKeyItem(MAP_OF_THE_SANDORIA_AREA);
		end,

 		-- BASTOK CITIZEN
		[1] = function (x)
			if (((race == 1) or (race == 2) or (race == 8)))
				then player:addItem(0x34B9);
			end;
			player:addKeyItem(MAP_OF_THE_BASTOK_AREA);
		end,

 		-- WINDY CITIZEN
	 	[2] = function(x)
			if (((race == 5) or (race == 6) or (race == 7)))
				then player:addItem(0x34B8);
			end;
			player:addKeyItem(MAP_OF_THE_WINDURST_AREA);
 		end,

		default = function (x) end,
	}

   ----- settings.lua Perks -----
   if (ADVANCED_JOB_LEVEL == 0) then
      for i = 6,22 do
         player:unlockJob(i);
      end
	  player:addSpell(296); -- Carbuncle
   end

   if (SUBJOB_QUEST_LEVEL == 0) then
      player:unlockJob(0);
   end

   if (ALL_MAPS == 1) then
      for i=385,447 do
         player:addKeyItem(i);
      end
      for i=1856,1917 do
         player:addKeyItem(i);
      end
      for i=2302,2304 do
         player:addKeyItem(i);
      end
   end

   if (INITIAL_LEVEL_CAP ~= 50) then
      player:levelCap(INITIAL_LEVEL_CAP)
   end

   if (START_INVENTORY > 30) then
      player:changeContainerSize(0,(START_INVENTORY - 30))
      player:changeContainerSize(5,(START_INVENTORY - 30))
   end

   if (UNLOCK_OUTPOST_WARPS >= 1) then
      player:addNationTeleport(0,2097120);
      player:addNationTeleport(1,2097120);
      player:addNationTeleport(2,2097120);
      if (UNLOCK_OUTPOST_WARPS == 2) then -- Tu'Lia and Tavnazia
         player:addNationTeleport(0,10485760);
         player:addNationTeleport(1,10485760);
         player:addNationTeleport(2,10485760);
      end
   end
   
   if (UNLOCK_EXTRA_SPELLS == 1) then
      -- ADD SPELLS MISSING
		player:addSpell(26); -- Dia IV
		player:addSpell(27); -- Dia V
		player:addSpell(31); -- Banish IV
		player:addSpell(32); -- Banish V
		player:addSpell(34); -- Diaga II
		player:addSpell(35); -- Diaga III
		player:addSpell(36); -- Diaga IV
		player:addSpell(36); -- Diaga V
		player:addSpell(40); -- Banishga III
		player:addSpell(41); -- Banishga IV
		player:addSpell(42); -- Banishga V
		player:addSpell(177); -- Firega IV
		player:addSpell(178); -- Firega V
		player:addSpell(182); -- Blizzaga IV
		player:addSpell(183); -- Blizzaga V
		player:addSpell(187); -- Aeroga IV
		player:addSpell(188); -- Aeroga V
		player:addSpell(192); -- Stonega IV
		player:addSpell(193); -- Stonega V
		player:addSpell(197); -- Thunderga IV
		player:addSpell(198); -- Thunderga V
		player:addSpell(202); -- Waterga IV
		player:addSpell(203); -- Waterga V
		player:addSpell(222); -- Poison III
		player:addSpell(223); -- Poison IV
		player:addSpell(224); -- Poison V
		player:addSpell(227); -- Poisonga III
		player:addSpell(228); -- Poisonga IV
		player:addSpell(229); -- Poisonga V
		player:addSpell(232); -- Bio III
		player:addSpell(233); -- Bio IV
		player:addSpell(234); -- Bio V
		player:addSpell(244); -- Meteor II
		player:addSpell(256); -- Virus
		player:addSpell(257); -- Curse
		player:addSpell(265); -- Tractor II
		player:addSpell(273); -- Sleepga
		player:addSpell(287); -- Klimaform
		player:addSpell(308); -- Animus Augeo
		player:addSpell(309); -- Animus Minuo
		player:addSpell(340); -- Utsusemi San
		player:addSpell(342); -- Jubaku Ni
		player:addSpell(343); -- Jubaku San
		player:addSpell(346); -- Hojo San
		player:addSpell(349); -- Kurayami San
		player:addSpell(351); -- Dokumori Ni
		player:addSpell(352); -- Dokumori San
		player:addSpell(355); -- Tonko San
		player:addSpell(356); -- Paralyga
		player:addSpell(357); -- Slowga
		player:addSpell(358); -- Hastega
		player:addSpell(359); -- Silencega
		player:addSpell(360); -- Dispelga
		player:addSpell(361); -- Blindga
		player:addSpell(362); -- Bindga
		player:addSpell(366); -- Graviga
		player:addSpell(367); -- Death
		player:addSpell(375); -- Foe Requiem VIII
		player:addSpell(384); -- Armys Paeon VII
		player:addSpell(385); -- Armys Paeon VIII
		player:addSpell(407); -- Chocobo Hum
		player:addSpell(411); -- Jesters Operetta
		player:addSpell(413); -- Devotee Serenade
		player:addSpell(416); -- Cactaur Fugue
		player:addSpell(417); -- Moogle Rhapsody
		player:addSpell(418); -- Protected Aria
		player:addSpell(423); -- Massacre Elegy
		player:addSpell(478); -- Embrava
		player:addSpell(478); -- Adloquium
		player:addSpell(502); -- Kaustra
   end
   
   if (UNLOCK_TELEPORTATION_ITEMS == 1) then
		-- ADD TRANSPORTATION ITEMS
		player:addKeyItem(8); -- AIRSHIP_PASS
		player:addKeyItem(9); -- AIRSHIP_PASS_FOR_KAZHAM
		player:addKeyItem(138); -- CHOCOBO_LICENSE
		z = 352;
		while z <= 357 do         -- GATE CRYSTALS
			player:addKeyItem(z);
			z = z + 1;
		end;
		player:addKeyItem(963);
		player:addKeyItem(964);
		player:addKeyItem(965);
	
		player:addKeyItem(781); -- BOARDING_PERMIT
		player:addKeyItem(485); -- MOONGATE_PASS
		player:addKeyItem(1550); -- PRISMATIC_HOURGLASS
	end
	
	if (UNLOCK_MERITS == 1) then
		-- UNLOCK MERIT PTS
		player:addKeyItem(606);
	end
	
	if (UNLOCK_CLAIM_SLIPS == 1) then
		-- ADD CLAIM SLIPS
		z = 654;
		while z <= 668 do
			player:addKeyItem(z);
			z = z + 1;
		end
		z = 861;
		while z <= 875 do
			player:addKeyItem(z);
			z = z + 1;
		end
		z = 1054;
		while z <= 1060 do
			player:addKeyItem(z);
			z = z + 1;
		end
		z = 1920;
		while z <= 1972 do
			player:addKeyItem(z);
			z = z + 1;
		end
	end
	
	if (UNLOCK_ALL_EVENT_ITEMS_STORED == 1) then
		player:setVar("eventItemsStored1", 2147483647);
		player:setVar("eventItemsStored2", 1048575);
		player:setVar("eventItemsStored3", 524287);
		player:setVar("eventItemsStored4", 8388607);
		player:setVar("eventItemsStored5", 16777215);
   end
   
   if (ALL_CONFLUX) then
	  player:setVar("ConfluxMask[Konschtat]",255);
	  player:setVar("ConfluxMask[Tahrongi]",255);
	  player:setVar("ConfluxMask[LaTheine]",255);
	  player:setVar("ConfluxMask[Attohwa]",511);
	  player:setVar("ConfluxMask[Misareaux]",511);
	  player:setVar("ConfluxMask[Vunkerl]",511);
	  player:setVar("ConfluxMask[Altepa]",255);
	  player:setVar("ConfluxMask[Uleguerand]",255);
	  player:setVar("ConfluxMask[Grauberg]",255);
  end
   ----- End settings.lua Perks -----

	-- SET START GIL
   --[[For some intermittent reason m_ZoneList ends up empty on characters, which is
   possibly also why they lose key items.  When that happens, CharCreate will be run and
   they end up losing their gil to the code below.  Added a conditional to hopefully
   prevent that until the bug is fixed.  Used the if instead of addGil to prevent abuse
   on servers with very high values of START_GIL, I guess.]]
   if (player:getGil() < START_GIL) then
      player:setGil(START_GIL);
   end

	-- ADD ADVENTURER COUPON
	player:addItem(0x218);

	-- START AHT URHGAN MISSION 1
	player:addMission(4,0);

	--SET TITLE
	player:addTitle(NEW_ADVENTURER);

	-- Needs Moghouse Intro
	player:setVar("MoghouseExplication",1);

   ---- Begin Custom Code ----
   ---- Adding Rings ----
   if not player:hasItem(0x34B7)
      then player:addItem(0x34B7);
   end

   if not player:hasItem(0x34B9)
      then player:addItem(0x34B9);
   end

   if not player:hasItem(0x34B8)
      then player:addItem(0x34B8);
   end
   ---- Adding Missing job gear/spells ----
   if not player:hasItem(17859)
   then player:addItem(17859);
   end
   if not player:hasItem(17809)
   then player:addItem(17809);
   end
   if not player:hasSpell(296)
   then player:addSpell(296);
   end
   ---- Clearing all "Lure of the Wildcat" quests ---
   player:completeQuest(0,113);
   player:completeQuest(1,84);
   player:completeQuest(2,94);
   player:completeQuest(3,90);
   player:delKeyItem(0x2E7);
   player:addKeyItem(0x2F1);   
   player:delKeyItem(0x2E8);
   player:addKeyItem(0x2F2);   
   player:delKeyItem(0x2E9);
   player:addKeyItem(0x2F3);
   player:delKeyItem(0x2EA);
   player:addKeyItem(0x2F4);
   ---- End Custom Code ----

end;