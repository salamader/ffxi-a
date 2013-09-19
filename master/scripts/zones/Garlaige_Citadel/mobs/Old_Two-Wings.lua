-----------------------------------
--  Area: Garlaige Citadel (200)
--    NM: Old_Two_Wings
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)

    -- Set Old_Two_Wings's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));
    
end;

