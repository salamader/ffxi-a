-----------------------------------
-- Area: Batallia Downs
-- NPC:  ???
-- Involved In Quest: Chasing Quotas
-- @zone 
-- @pos 210 14 -612
-----------------------------------
package.loaded["scripts/zones/Eastern_Altepa_Desert/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/zones/Eastern_Altepa_Desert/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	chasingQuotas = player:getVar("chasingQuotas_Event");
	SturmtigerKilled = player:getVar("SturmtigerKilled");
	
	if((chasingQuotas == 7) and (SturmtigerKilled == 0)) then
			SpawnMob(17207696,300):updateEnmity(player);
	elseif((chasingQuotas == 7) and (SturmtigerKilled == 1)) then
			player:addKeyItem(RANCHURIOMES_LEGACY);
			player:setVar("chasingQuotas_Event",8);
			player:setVar("SturmtigerKilled",0);	
	else
		player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
	end
	
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