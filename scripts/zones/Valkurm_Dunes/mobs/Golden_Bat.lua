-----------------------------------
--  Area: Valkurm Dunes (103)
--   Mob: Golden_Bat
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Golden_Bat's Window Open Time
    wait = math.random((1440),(3600));
    SetServerVariable("[POP]Golden_Bat", os.time(t) + wait); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Golden_Bat");
    SetServerVariable("[PH]Golden_Bat", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

