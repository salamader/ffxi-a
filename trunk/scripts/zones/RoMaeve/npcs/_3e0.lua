-----------------------------------	
-- Moongate
-- Area: Ro'Maeve
-----------------------------------	
	
require("/scripts/globals/settings");	


--TODO
-- 1. game time must be between 0:00 - 3:00
-- 2. moon must be full 95 - 5%	
	
-----------------------------------	
-- onTrigger Action	
-----------------------------------	
	
function onTrigger(player,npc)	
	if(player:hasKeyItem(MOONGATE_PASS) == true) then
	GetNPCByID(17277171):openDoor(30);
	end

end;	
	
-----------------------------------	
-- onTrade Action	
-----------------------------------	
	
function onTrade(player,npc,trade)	
end;	
	
-----------------------------------	
-- onEventSelection	
-----------------------------------	
	
function onEventUpdate(player,csid,menuchoice)	
end;	
	
-----------------------------------	
-- onEventFinish Action	
-----------------------------------	
	
function onEventFinish(player,csid,option)	
end;	

