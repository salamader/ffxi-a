-----------------------------------
--  Area: Bostaunieux Oubliette (167)
--   Mob: Drexerion_the_Condemned
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Drexerion_the_Condemned's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));

end;

