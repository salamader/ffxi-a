----------------------------------	
-- Area: Gustav Tunnel
--   NM: Taxim
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Taxim's Window Open Time
    SetServerVariable("[POP]Taxim", os.time(t) + math.random((1440),(3600))); -- 24min-1hr
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Taxim");
    SetServerVariable("[PH]Taxim", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;