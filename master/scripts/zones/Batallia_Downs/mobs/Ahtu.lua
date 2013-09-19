-----------------------------------
--  Area: Batallia Downs (105)
--   Mob: Ahtu
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Ahtu's spawnpoint and respawn time (24 min to 1 hour)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((1440),(3600)));

end;

