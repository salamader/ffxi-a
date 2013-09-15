-----------------------------------
--	[Command name]: shop
--	[Author      ]: 
--	[Description ]: 
-----------------------------------
--http://ffxi.gamerescape.com/wiki/Celebratory_Chest
-- NOTE: commented out the HQ crystals. and Serene serinette , and Joyous serinette  as these last 2 items are not coded and im not sure how to code them.http://ffxi.gamerescape.com/wiki/Serene_serinette || and  http://ffxi.gamerescape.com/wiki/Joyous_serinette
-----------------------------------
-- Action
-----------------------------------

function onTrigger(player,npc)
stock =
	{
		4167,231,		--Cracker
		4168,275,		--Twinkle Shower
		4215,440,		--Popstar
		4216,252,		--Brilliant Snow
		4256,459,		--Ouka Ranman
		4169,275,		--Little Comet
		5769,650,		--Popper
		4170,1000,		--Wedding Bell
		--5424,6000,		--Serene serinette
		--5425,6000,		--Joyous serinette
		4441,1116,		--Grape Juice
		--4238,3000,		--Inferno Crystal
		--4240,3000,		--Cyclone Crystal
		--4241,3000, 		--Terra Crystal
	};

	showShop(player, STATIC, stock);
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
end;
