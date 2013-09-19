-----------------------------------
--	Author: ReaperX
-- 	??? Jailer of Prudence
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
DeedOfSensibility = 0x74E;
HQHpemdeOrgan = 0x74F;
GhrahMChip = 0x750;


-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0xCA);
end;
  
function onTrade(player,npc,trade)
	if (trade:getItemCount() == 3) and (trade:hasItemQty(ThirdVirtue,1)) and (trade:hasItemQty(DeedOfSensibility,1)) and (trade:hasItemQty(HQHpemdeOrgan,1)) then
	 trade:isComplete();
	 loc = 0x21;
	 loc:spawnMob("JailerofPruden",706, -1.4, 17,0,player:getId());
	end;
end;
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
end;