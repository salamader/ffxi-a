-----------------------------------
--  Area: Castle Zvahl Baileys (161)
--    NM: Duke_Haborym
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Duke_Haborym's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random(3600),(14400));

end;
