-----------------------------------
-- 	Fortilace
-- 	Teleports Players to Ruhotz Silvermines (D-9) for Campaign Ops
-----------------------------------
package.loaded["scripts/zones/Rolanberry_Fields_[S]/TextIDs"] = nil;
-----------------------------------
require("scripts/zones/Rolanberry_Fields_[S]/TextIDs");
require("scripts/globals/settings");
require("scripts/globals/teleports");

function onTrigger(player,npc)
	player:startEvent(0x00C8);
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
	if ((csid == 0x00C8) and (option == 1)) then
		--player:setPos(); -- MISSING CORDS
	end
end;