-----------------------------------
--	Author: ReaperX
-- 	??? Jailer of Love
-----------------------------------
require("scripts/globals/settings");

FifthVirtue = 0x737
FourthVirtue = 0x738;
SixthVirtue = 0x739;
FirstVirtue = 0x73A
DeedOfPlacidity = 0x73B;
HQPhuaboOrgan = 0x73C;
SecondVirtue = 0x73D;
DeedOfModeration = 0x73E;
HQXzomitOrgan = 0x73F;
ThirdVirtue = 0x740;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0xCB);
end;
  
function onTrade(player,npc,trade)
	if (trade:getItemCount() == 3) and (trade:hasItemQty(FourthVirtue,1)) and (trade:hasItemQty(FifthVirtue,1)) and (trade:hasItemQty(SixthVirtue,1)) then
	 trade:isComplete();
	 loc = 0x21;
	 loc:spawnMob("JailerofLove",441, -2, -595,232,player:getId());
	end;
end;
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
end;