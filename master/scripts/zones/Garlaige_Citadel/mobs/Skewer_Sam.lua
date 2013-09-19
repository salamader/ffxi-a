-----------------------------------
--  Area: Garlaige Citadel (200)
--    NM: Skewer_Sam
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)

    -- Set Skewer_Sam's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));
    
end;

