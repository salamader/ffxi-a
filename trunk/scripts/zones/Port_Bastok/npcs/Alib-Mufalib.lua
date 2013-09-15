-----------------------------------
-- 	AlibMufalib
--	Starts and ends quest "Lure of the Wildcat" in Bastok.  
--	After this quest and Aht Urghan mission 2,he will teleport you to Aht Urghan for 300g.
-----------------------------------
--[[
Bitmask Designations:

Port Bastok (East to West)
00001    (J-5) Kaede (northernmost house) 
00002    (F-5) Patient Wheel (north of Warehouse 2) 
00004    (F-6) Paujean (bottom floor of Warehouse 2) 
00008    (E-6) Hilda (Steaming Sheep Restaurant, walks on the top floor and occasionally down. However, she can still be talked to when on second floor) 
00010    (F-8) Tilian (end of a pier west of Air Travel Agency) 

Metalworks (all found on top floor)(Clockwise)
00020    (G-8) Raibaht (Cid's lab) 
00040    (G-8) Invincible Shield (outside Cid's Lab) 
00080    (G-7) Manilam (on top of Cermet Refinery) 
00100    (I-8) Kaela (between Consulate of Windurst & Consulate of Jeuno) 
00200    (K-7) Ayame (Inside north Cannonry) 

Bastok Markets (East to West)
00400    (K-10) Harmodios (Harmodios's Music Shop) 
00800    (J-10) Arawn (west of music store) 
01000    (I-9)  Horatius (Inside Trader's Home) 
02000    (E-10) Ken (outside Mjoll's General Goods) 
04000    (E-11) Pavel (West Gate to South Gustaberg) 

Bastok Mines (Clockwise, starting at Ore Street, upper floor to lower floor)
08000    (H-5) Griselda (upper floor, Bat's Lair Inn) 
10000    (I-6) Goraow (upper floor, in stairwell of Ore Street) 
20000    (I-7) Echo Hawk (lower floor, Ore Street) 
40000    (H-6) Deidogg (lower floor, Ore Street) 
80000    (H-9) Vaghron (southwest of South Auction House)
]]--
-----------------------------------
-- onTrigger Action
-----------------------------------
require("scripts/globals/settings");
package.loaded["scripts/zones/Port_Bastok/TextIDs"] = nil;
require("scripts/zones/Port_Bastok/TextIDs");
function onTrigger(player,npc)
LureoftheWildcatBastok = player:getQuestStatus(1,84);
-----------------------------------
-- Dialogues,cutscenes,etc. go below.
-----------------------------------
if(LureoftheWildcatBastok~=2)then
	if(LureoftheWildcatBastok == 0) then
		player:startEvent(0x165);
	else
		if(player:getVar("lureOfTheWildcat-B-Counter") == 0x0)then
			player:startEvent(0x167);
		elseif(player:getVar("lureOfTheWildcat-B-Counter") == 0xFFFFF)then
			player:startEvent(0x168);
		else
			player:startEvent(0x166);
		end
	end
elseif(player:getMissionStatus(4,1) == 2)then
	player:startEvent(0x17A);
else
	player:startEvent(0x169);
end
end; 
 

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
LureoftheWildcatBastok = player:getQuestStatus(1,84);
gil = trade:getGil();
if(LureoftheWildcatBastok == 2 and player:getMissionStatus(4,2) == 2 and gil == 300)then
-- Needs a check for at least traded an invitation card to Naja Salaheem
	player:startEvent(0x17B);
end
end; 
 
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
if(csid == 0x165)then
	player:addQuest(1,84);
	player:setVar("lureOfTheWildcat-B-Counter",0);
	player:addKeyItem(0x2E8); -- BlueSentinelBadge
elseif(csid == 0x168) then
	player:completeQuest(1,84);
	player:addFame(1,BAS_FAME*150);
	player:setVar("lureOfTheWildcat-B-Counter",0);
	player:delKeyItem(0x2E8);
	player:addKeyItem(0x2F2);
	player:messageSpecial(KEYITEM_OBTAINED,0x2F2);
elseif(csid == 0x17B)then
	player:setPos(16.964,0,18.061,95,0x32); -- Aht Urhgan Whitegate (Pos in not correct needs verify).
end
end;