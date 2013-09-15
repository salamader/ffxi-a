-----------------------------------
--  Area: Meriphataud Mountains (119)
--   Mob: Coo_Keja_the_Unseen
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Coo_Keja_the_Unseen's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));

end;

