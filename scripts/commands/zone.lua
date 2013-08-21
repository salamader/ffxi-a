-----------------------------------
--	[Command name]: zone
--	[Author      ]: 
--	[Description ]: 
-----------------------------------

-----------------------------------
-- zone Action
-----------------------------------

function onTrigger(player,zoneID,eventid)
	player:Zone(zoneID,eventid);
end;