----------------------------------	
-- Area: Kuftal Tunnel	
--   NM: Amemet
-- ToDo: Amemet should walk in a big circle
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	

    -- Set Amemet's Window Open Time
    wait = math.random((1440),(3600)); -- 24min-1hr
    SetServerVariable("[POP]Amemet", os.time(t) + wait);
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Amemet");
    SetServerVariable("[PH]Amemet", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;