-----------------------------------
--  Area: Castle Zvahl Baileys (161)
--    NM: Marquis_Amon
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Marquis_Amon's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));

end;

