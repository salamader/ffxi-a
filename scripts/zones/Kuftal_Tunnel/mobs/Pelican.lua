----------------------------------
-- Area: Kuftal Tunnel
--   NM: Pelican
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)

    -- Set Pelican's Window Open Time
    wait = math.random((3600),(14400)); -- 1-4 hours
    SetServerVariable("[POP]Pelican", os.time(t) + wait); -- 1-4 hours
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Pelican");
    SetServerVariable("[PH]Pelican", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;