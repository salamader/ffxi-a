----------------------------------	
-- Area: Gustav Tunnel
--   NM: Goblinsavior Heronox
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Goblinsavior Heronox's Window Open Time
    wait = math.random((3600),(14400));  -- 1-4 hours
    SetServerVariable("[POP]Goblinsavior_Heronox", os.time(t) + wait);
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Goblinsavior_Heronox");
    SetServerVariable("[PH]Goblinsavior_Heronox", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;