-----------------------------------
--  Area: Windurst Waters
--   NPC: Kipo-Opo
--  Type: Head Craftsman
-- @zone: 238
--  @pos: -119.750 -5.239 64.500
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
	
	rank     = player:getSkillRank(56);
	price    = 30*rank;
	member   = player:getVar("GuildMember-Cooking");
	support  = 0;
	advanced = 0;
	
	if(player:hasStatusEffect(EFFECT_COOKING_IMAGERY) == true) then
		support = 1;
	end
	
	player:startEvent(0x271f,price,0,advanced,member*256,0,support,0,0);
	
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
	
	rank     = player:getSkillRank(56);
	price    = 30*rank;
	
	if(csid == 0x271f and option == 1) then
		player:delGil(price);
		player:addStatusEffect(EFFECT_COOKING_IMAGERY,3,0,480);
	end
end;

