-----------------------------------
--  Area: Bostaunieux Oubliette (167)
--   Mob: Sewer_Syrup
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Sewer_Syrup's Window Open Time
    wait = math.random((1440),(3600));
    SetServerVariable("[POP]Sewer_Syrup", os.time(t) + wait); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Sewer_Syrup");
    SetServerVariable("[PH]Sewer_Syrup", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

