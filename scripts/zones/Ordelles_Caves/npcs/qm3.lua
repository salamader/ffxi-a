-----------------------------------
-- Area: Ordelle's Caves
-- NPC:  ???
-- Involved in Quest: A Squire's Test II
-- @zone 193
-- @pos -139 0 264
-------------------------------------
package.loaded["scripts/zones/Ordelles_Caves/TextIDs"] = nil;
-------------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/teleports");
require("scripts/zones/Ordelles_Caves/TextIDs");

----------------------------------- 
-- onTrade Action 
----------------------------------- 

function onTrade(player,npc,trade) 
end;

----------------------------------- 
-- onTrigger Action 
-----------------------------------
 
function onTrigger(player,npc) 
	local HasDew = player:hasKeyItem(STALACTITE_DEW);

	if(os.time() - player:getVar("SquiresTestII") <= 60 and HasDew == false) then
		player:messageSpecial(A_SQUIRE_S_TEST_II_DIALOG_II);
		player:addKeyItem(STALACTITE_DEW);
		player:messageSpecial(KEYITEM_OBTAINED, STALACTITE_DEW);
		player:setVar("SquiresTestII",0);
		debugTeleport(player,17719359); -- Balasiel, zone 230, -138 x
	elseif(HasDew)then
		player:messageSpecial(A_SQUIRE_S_TEST_II_DIALOG_III);
	else
		player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
		player:setVar("SquiresTestII",0);
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