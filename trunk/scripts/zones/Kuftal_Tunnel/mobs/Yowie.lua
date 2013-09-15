----------------------------------
-- Area: Kuftal Tunnel
--   NM: Yowie
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)

    -- Set Yowie's Window Open Time
    wait = math.random((1440),(3600)); -- 24min-1hr
    SetServerVariable("[POP]Yowie", os.time(t) + wait);
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Yowie");
    SetServerVariable("[PH]Yowie", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;