-----------------------------------
--  Area: Castle Oztroja
--   NPC: Kaa Toru the Just
--  Type: Mission NPC
-- @zone: 151
--  @pos: -100.188 -62.125 145.422
--
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Castle_Oztroja/TextIDs"] = nil;
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
	if(player:getCurrentMission(WINDURST) == SAINTLY_INVITATION and player:getVar("WINDURST62") == 2 and player:hasKeyItem(BALGA_CHAMPION_CERTIFICATE))then
		player:startEvent(0x002D,0,200);
	elseif(player:getVar("WINDURST62") ==3) then
		player:startEvent(0x002E);
	else
		player:messageSpecial(7383);
	end
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
	if(csid == 0x002d)then
		player:delKeyItem(BALGA_CHAMPION_CERTIFICATE);
		player:setVar("WINDURST62",3);
		player:addItem(13134,1);
		player:messageSpecial(6563,13134);
		player:addKeyItem(HOLY_ONES_OATH);
		player:messageSpecial(6566,HOLY_ONES_OATH);
	end
end;

