----------------------------------	
-- Area: Labyrinth of Onzozo
--   NM: Hellion
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Hellion's Window Open Time
    wait = math.random((3600),(7200));
    SetServerVariable("[POP]Hellion", os.time(t) + wait); -- 1-2 hours
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Hellion");
    SetServerVariable("[PH]Hellion", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;