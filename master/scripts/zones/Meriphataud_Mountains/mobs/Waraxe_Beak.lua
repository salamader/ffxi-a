-----------------------------------
--  Area: Meriphataud Mountains (119)
--   Mob: Waraxe_Beak
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Waraxe_Beak's spawnpoint and respawn time (4-8 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((14400),(28800)));

end;

