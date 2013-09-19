-----------------------------------
--  Area: Korroloka Tunnel (173)
--   Mob: Dame_Blanche
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Dame_Blanche's Window Open Time
    wait = math.random((1440),(3600));
    SetServerVariable("[POP]Dame_Blanche", os.time(t) + wait); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Dame_Blanche");
    SetServerVariable("[PH]Dame_Blanche", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

