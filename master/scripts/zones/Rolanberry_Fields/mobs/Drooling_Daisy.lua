-----------------------------------
--  Area: Rolanberry Fields (110)
--    NM: Drooling_Daisy
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	
  
    -- Set Drooling_Daisy's Window Open Time
    SetServerVariable("[POP]Drooling_Daisy", os.time(t) + math.random((1440),(3600))); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Drooling_Daisy");
    SetServerVariable("[PH]Drooling_Daisy", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

