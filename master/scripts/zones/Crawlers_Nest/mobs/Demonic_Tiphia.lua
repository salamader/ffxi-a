-----------------------------------
--  Area: Crawlers' Nest (197)
--   Mob: Demonic_Tiphia
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Demonic_Tiphia's Window Open Time
    wait = math.random((3600),(14400));
    SetServerVariable("[POP]Demonic_Tiphia", os.time(t) + wait); -- 1-4 hours
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Demonic_Tiphia");
    SetServerVariable("[PH]Demonic_Tiphia", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

