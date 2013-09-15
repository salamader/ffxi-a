-----------------------------------
-- Area: Eastern Altepa Desert
-- NPC: Lokpix
-- Quests: Open Sesame
-- @zone 114
-- @pos -68.847, 3.595, 215.485
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	if(player:getVar("openSesameVar") == 1) then
		local count = trade:getItemCount();
		local Tremorstone = trade:hasItemQty(2796,1);
		local Meteorite = trade:hasItemQty(582,1);
		local Soilgem = trade:hasItemQty(3319,1);
		local Soilgeode = trade:hasItemQty(3300,12);
		if(Tremorstone == true and Meteorite == true and count == 2) then -- Trade Tremorstone & Meteorite
			player:startEvent(22);
		elseif(Tremorstone == true and Soilgem == true and count == 2) then -- Trade Tremorstone & Soil Gem
			player:startEvent(22);
		elseif(Tremorstone == true and Soilgeode == true and count == 2) then -- Trade Tremorstone & Soil Geodes
			player:startEvent(22);
		else
			player:startEvent(23);
		end
	end
end;


-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local openSesame = player:getQuestStatus(OUTLANDS,OPEN_SESAME);
	local osVar = player:getVar("openSesameVar");
	if(openSesame == QUEST_ACCEPTED) then
		player:startEvent(21);
	elseif(openSesame == QUEST_COMPLETED) then
		player:startEvent(24);
	else
		player:startEvent(20);
	end;
end;

  
-----------------------------------
-- onEventFinish Action
-----------------------------------
function onEventFinish(player,csid,option)
--print("CSID:",csid);
--print("OPTION:",option);

	if(csid == 20 and option == 1) then
		player:setVar("openSesameVar",1);
		player:addQuest(OUTLANDS,OPEN_SESAME);
	elseif(csid == 22) then
		player:tradeComplete();
		player:addKeyItem(LOADSTONE); -- Give the Loadstone
		player:messageSpecial(KEYITEM_OBTAINED,LOADSTONE);
		player:addFame(SANDORIA,SAN_FAME*10);
		player:addFame(BASTOK,BAS_FAME*10);
		player:completeQuest(OUTLANDS,OPEN_SESAME);
		player:setVar("openSesameVar",0);
	end

end;