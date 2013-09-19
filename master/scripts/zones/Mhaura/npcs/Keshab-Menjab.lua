-----------------------------------
-- Area: Mhaura
-- NPC: Keshab-Menjab
-- Type: Standard NPC
-- @zone: 249
-- @pos: -15.727, -9.032, 54.049
-----------------------------------
package.loaded["scripts/zones/Mhaura/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Mhaura/TextIDs");
require("scripts/globals/settings");

-----------------------------------
-- onTrigger Action
-----------------------------------
function onTrigger(player,npc)
	-----------------------------------
	-- Dialogues,cutscenes,etc. go below.
	-----------------------------------
	local rod = player:getVar("recyclingRods");
	if (rod == 0) then
		player:startEvent(0x139);
	elseif (rod == 1) then
		player:startEvent(0x13b);
	elseif (rod == 2) then
		player:startEvent(0x13a);
	end
end; 
 

-----------------------------------
-- onTrade Action
-----------------------------------
function onTrade(player,npc,trade)
	local rod = player:getVar("recyclingRods");
	bknrods = {0x1d8, 0x1d9, 0x1e2, 0x1e3, 0x1e4, 0x1e5, 0x1e6, 0x1e7, 0x1e8, 0x1e9, 0x1ea, 0x1eb, 0x6be, 0x728, 0x729}; --Other broken rods.
	count = trade:getItemCount();
	--print("count: " .. count);
	for j = 1,table.getn(bknrods) do
		item1 = trade:hasItemQty(bknrods[j],1);
		if (rod == 1 and count == 1 and item1 == true) then
			player:startEvent(0x13c);
		end
	end
	item2 = trade:hasItemQty(0x684,1);
	if (rod == 1 and count == 1 and item2 == true) then
		--Quest complete.
		player:startEvent(0x13d);
		player:removeItem(0x684,1);
		player:addItem(0);
		player:addGil(GIL_RATE*1500);
		player:messageSpecial(GIL_OBTAINED,GIL_RATE*1500);
		player:setVar("recyclingRods",2);
		player:addFame(2,WIN_FAME*40); --Reasonable estimate for a fame level 1 quest.
		--print("Windurst fame adjusted for " .. player:getName() .." by 40 (Total: ".. player:getFame(2) .. ").");
	end
end; 
 
  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("RESULT:",option);
	if (csid == 0x139 and option == 1) then
		player:setVar("recyclingRods",1);
	end
end;