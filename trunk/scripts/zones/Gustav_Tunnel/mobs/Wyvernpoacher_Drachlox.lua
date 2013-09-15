----------------------------------	
-- Area: Gustav Tunnel
--   NM: Wyvernpoacher Drachlox
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Wyvernpoacher Drachlox's Window Open Time
    wait = math.random((1440),(3600));  -- 24min-1hr
    SetServerVariable("[POP]Wyvernpoacher_Drachlox", os.time(t) + wait);
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Wyvernpoacher_Drachlox");
    SetServerVariable("[PH]Wyvernpoacher_Drachlox", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;