----------------------------------	
-- Area: Labyrinth of Onzozo
--   NM: Ose
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Ose's Window Open Time
    SetServerVariable("[POP]Ose", os.time(t) + math.random((1440),(3600))); -- 24min-1hr
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Ose");
    SetServerVariable("[PH]Ose", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;