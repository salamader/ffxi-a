-----------------------------------
-- 	Cavernous Maw
-- 	Teleports Players to North Gustaberg
-----------------------------------
package.loaded["scripts/zones/North_Gustaberg_[S]/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/North_Gustaberg_[S]/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/teleports");

function onTrigger(player,npc)
	if (player:getVar("MAWS_GUSTABERG") == 1) then
		player:startEvent(0x0065);
	else
		player:startEvent(0x0064);
		player:setVar("MAWS_GUSTABERG",1)
	end
end;

function onEventUpdate(player,csid,menuchoice) 
--print("CSID:",csid);
--print("RESULT:",option);
end;

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
end; 
   
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
	if ((csid == 0x0065 or csid == 0x0064) and (option == 1)) then
		toMaw(player,12);
	end
end;