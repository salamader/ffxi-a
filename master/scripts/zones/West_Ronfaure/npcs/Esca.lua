-----------------------------------
-- Area: West Ronfaure
-- NPC: Esca
-- NPC for Quest "The Pickpocket", "Chasing Quotas"
-- @pos -623 -51 278 (110)
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/settings");
package.loaded["scripts/globals/quests"] = nil;
require("scripts/globals/quests");
package.loaded["scripts/zones/Port_San_dOria/TextIDs"] = nil;
require("scripts/zones/Port_San_dOria/TextIDs");


-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

	-- "The Pickpocket" Quest status
	thePickpocket = player:getQuestStatus(SANDORIA, THE_PICKPOCKET);
		
	-- "The Pickpocket" Trading Esca for Gilt Glasses
	local count = trade:getItemCount();
	local freeSlot = player:getFreeSlotsCount();
	local eagleButton = trade:hasItemQty(578, 1);
	local hasGiltGlasses = player:hasItem(579);
	if(eagleButton == true and hasGiltGlasses == false) then
		if (count == 1 and freeSlot > 0) then
			player:tradeComplete();
			player:startEvent(0x0079);
			player:setVar("thePickpocketGiltGlasses", 1); -- used to get eventID 0x0080
		else
			player:messageSpecial(6378, 579); -- CANNOT_OBTAIN_ITEM
		end;
	end;
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	-- "The Pickpocket" Quest status
	thePickpocket = player:getQuestStatus(SANDORIA, THE_PICKPOCKET);
	chasingQuota = player:getQuestStatus(SANDORIA, CHASING_QUOTA);

	-- "The Pickpocket" Quest Dialog
	if (thePickpocket == 1 and player:getVar("thePickpocketGiltGlasses") == 1)  then
		player:startEvent(0x0080);
	elseif (thePickpocket == 1) then
		player:startEvent(0x0078);
	elseif (thePickpocket == 2 and chasingQuota ~= QUEST_COMPLETED) then
		player:startEvent(0x007b);
	elseif(player:getVar("chasingQuotas_Event") == 6) then
		player:startEvent(0x0089);
	else
		player:startEvent(0x0077);
	end;
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

	-- "The Pickpocket" recieving Gilt Glasses
	if (csid == 0x0079) then
		player:addItem(579);
		player:messageSpecial(6381, 579);
	elseif(csid == 0x0089) then -- Chasing Quotas -- Remove key item Shiny Earring
		player:delKeyItem(SHINY_EARRING);
		player:setVar("chasingQuotas_Event",7);
	end;
end;

--119 - 0x0077 - What do you want? I'm busy, so make it quick.
--123 - 0x007B - What is it!? If you've no further business here, leave!
--120 - 0x0078 - Me, a pickpocket? Is this the way of adventurers today, chasing down and accusing ladies of crimes? And without proof, I might add! Just who do you think you are?  Look, let's just forget this little meeting ever happened.  Good day! What!? If you insist on playing the sheriff, I suggest you bring evidence!
--121 - 0x0079 - What's that? Say, that eagle button, that's mine! I must have dropped it when I ran into you at the dock... Whoops, I've gone and said it now.  Fine.  Here's that worthless gilt glasses back.  Satisfied? Good.  Now off with you!
--122 - 0x007A - What's this? You should know better than to drop whatever you please in someone's residence!
--128 - 0x0080 - What? You lost the glasses!?  I may be a thief, but I'm not the lost and found! Go find them on your own!
--137 - 0x0089 - What do you want? You want to know if I've seen that earring before?  ...! Where did you get that?  Ah, I must have dropped it that time I was... Damn, I'm so clumsy!  Well, I guess you found me out.  I was the one who mugged Brugaire for his father's inheritance.  Even if I am a thief, a lady likes to look her best when doing her job.  By the way, do you have any idea what I stole?  Y/N. (Either choice is fine) The thing I took was a piece of the armor said to have been worn by the legendary last dragoon.  My employer is one of the many people who are after that armor.  The name of the employer?  You know, he never told me.  I was just told to bury the armor in a certain spot in exchange for the small fortune in gil.  I've already been paid for the job, so I'll tell you where I buried it.  But on one condition:  You can't tell Brugaire that I was the thief.  I don't need him breathing down my neck when I'm trying to work.  Right.  The armor is buried on a small island that can be reached through the Eldieme Necropolis.  A monster has been put on guard over the spot though, so don't think you can just waltz in and scoop it up.  Oh, and give me back my earring.  I wear those for good luck. 
--138 - 0x008A - The armor is buried on a small island that can be reached through the Eldieme Necropolis.  A monster has been put on guard over the spot though, so don't think you can just waltz in and scoop it up.



