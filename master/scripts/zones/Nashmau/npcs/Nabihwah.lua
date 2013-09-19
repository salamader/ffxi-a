------------------------------------------------------
--  Area: Al Zahbi
--  NPC: Famatar
--  Type: Imperial Officer
--  @zone: 48
--  @pos: -105.538 0.999 75.456
--
-- 	Grants Sanction, sells items for imperial standing.
------------------------------------------------------
package.loaded["scripts/zones/Nashmau/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/globals/besieged");

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	merc_rank = getMercenaryRank(player);
	if (merc_rank == 0) then
		player:startEvent(0x00fe,npc);
	else
		maps = getMapBitmask(player);
		if (getAstralCandescence() == 1) then
			maps = maps + 0x80000000;
		end;
		IS = player:getPoint(3);
		x,y,z,w = getImperialDefenseStats();
		player:startEvent(0x00fd,IS,maps,merc_rank,0,x,y,z,w);
	end;
end; 
 
function onEventSelection(player,csid,option)
	if (csid == 0x00FD and option>= 1 and option <= 2049) then
		itemid = getISPItem(option);
		player:updateEvent(0,0,0,canEquip(player, itemid));
	end;
end;

function onTrade(player,npc,trade)
end; 

function onEventFinish(player,csid,option)
if (csid == 0x00FD) then
	if (option == 0 or option == 16 or option == 32 or option == 48) then -- player chose sanction.
		if (option ~=0) then
			player:delPoint(3,100);
		end;
		player:delStatusEffect(EFFECT_SIGIL);
		player:delStatusEffect(EFFECT_SANCTION);
		player:delStatusEffect(EFFECT_SIGNET);
		duration = getSanctionDuration(player);
		if (option == 16) or (option == 32) then -- refresh and regen sanction
			tick = 3; 
		else
			tick = 0;
		end;
		player:addStatusEffect(EFFECT_SANCTION,option / 16,tick,duration); -- effect size 1=regen, 2=refresh, 3=food.
		player:messageSpecial(SANCTION);
	elseif (option % 256 == 17) then -- player bought one of the maps
		id = MapOfMamook + (option-17)/256;
		player:addKeyItem(id);
		player:messageSpecial(KEYITEM_OBTAINED,id);
		player:delPoint(3,1000);
	elseif (option <= 2049) then -- player bought item
		item, price = getISPItem(option);
		if (player:getFreeSlotsCount() > 0) then
			player:addItem(item);
			player:messageSpecial(ITEM_OBTAINED,item);
			player:delPoint(3,price);
		else
			player:messageSpecial(ITEM_CANNOT_BE_OBTAINED,item);
		end;
	end;
end;
end;
