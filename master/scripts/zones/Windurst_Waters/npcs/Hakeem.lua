-----------------------------------
--  Area: Windurst Waters
--   NPC: Hakeem
--  Type: Craftsman
-- @zone: 238
--  @pos: -123.120 -2.999 65.472
-----------------------------------
package.loaded["scripts/zones/Windurst_Waters/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	--ARGUMENT 1: Charge for advanced support.
	--ARGUMENT 3: Set to 1 for him to offer regular support, or 0 for advanced support.
	--ARGUMENT 4: Set to 256 for him to offer any service at all.
	--ARGUMENT 6: Set to 1 if the player already recieved synth support.

	member   = player:getVar("GuildMember-Cooking");
	support  = 0;
	advanced = 1;

	if(player:hasStatusEffect(EFFECT_COOKING_IMAGERY) == true) then
		support = 1;
	end

	player:startEvent(0x2721,price,0,advanced,member*256,0,support,0,0);

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
	
	if(csid == 0x2721 and option == 1) then
		player:addStatusEffect(EFFECT_COOKING_IMAGERY,1,0,120);
	end
end;
