----------------------------------	
-- Area: Gustav Tunnel
--   NM: Ungur
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Ungur's Window Open Time
    SetServerVariable("[POP]Ungur", os.time(t) + math.random((2700),(3600))); -- 45min-1hr
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Ungur");
    SetServerVariable("[PH]Ungur", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;