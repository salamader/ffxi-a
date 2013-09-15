----------------------------------
-- Area: Kuftal Tunnel
--   NM: Arachne
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)

    -- Set Arachne's Window Open Time
    wait = math.random((1440),(3600)); -- 24min-1hr
    SetServerVariable("[POP]Arachne", os.time(t) + wait);
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Arachne");
    SetServerVariable("[PH]Arachne", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;