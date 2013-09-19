-----------------------------------
--  Area: Eastern Altepa Desert (114)
--    NM: Dune_Widow
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Dune_Widow's Window Open Time
    wait = math.random((3600),(14400))
    SetServerVariable("[POP]Dune_Widow", os.time(t) + wait); -- 24min-1hr
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Dune_Widow");
    SetServerVariable("[PH]Dune_Widow", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
    
end;

