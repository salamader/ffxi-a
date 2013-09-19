-----------------------------------
-- Area: Windurst Woods
-- NPC: Tih Pikeh
-- Changes dialogue based on mission status.
-- @zone 241
-- @pos 109.464', '-5.000', '-21.996
-----------------------------------

require("scripts/globals/settings");

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
 
	nation = player:getNation();

	--Mission Flags--
	windymission = player:getVar("windurstMissions");
	windyoneone = player:getVar("theHorutotoRuinsExperiment");
	windyonetwo = player:getVar("theHeartOfTheMatter");
	windyonetwoa = player:getVar("theHeartOf-ApururuCS");
	windyonetwoc = player:getVar("theHeartOf-CardianCS");
	windyonethree = player:getVar("thePriceOfPeace");
	-----------------------------------
	-- Dialogues,cutscenes,etc. go below.
	-----------------------------------
	--Standard,non-Windurst player dialogue--
	if (nation ~= 2) then
		player:startEvent(0x6c,0,0,nation);
	else --Windurst player dialogue (most cases)
		if (windymission == 12) then
			--Check status of Windurst Mission 1-2--
			if (windyonetwo == 0) then
				player:startEvent(0x83);
			elseif (windyonetwo == 1 or windyonetwo == 2) then
				player:startEvent(0x87);
			else
				player:startEvent(0x6a);
			end
		elseif (windymission == 13) then
			--Check status of Windurst Mission 1-3--
			if (windyonethree == 0) then
				player:startEvent(0x6a);
			elseif (windyonethree == 1 or windyonethree == 2) then
				player:startEvent(0x98);
			elseif (windyonethree == 3) then
				player:startEvent(0x9c);
			end
		else
			--Check status of Windurst mission 1-1--
			if (windyoneone == 0) then
				player:startEvent(0x6a);
			elseif (windyoneone == 1 or windyoneone == 2) then
				player:startEvent(0x7e); 
			elseif (windyoneone == 3) then
				player:startEvent(0x83);
			end
		end
	end
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
end;