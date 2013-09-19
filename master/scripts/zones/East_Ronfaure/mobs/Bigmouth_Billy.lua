-----------------------------------
--  Area: East Ronfaure (101)
--   Mob: Bigmouth_Billy
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Bigmouth_Billy's Window Open Time
    wait = math.random((1440),(3600));
    SetServerVariable("[POP]Bigmouth_Billy", os.time(t) + wait); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Bigmouth_Billy");
    SetServerVariable("[PH]Bigmouth_Billy", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));

end;

