-----------------------------------
--  Area: Castle Zvahl Baileys (161)
--    NM: Grand_Duke_Batym
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Grand_Duke_Batym's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));

end;
