-----------------------------------
--  Area: Eastern Altepa Desert (114)
--    NM: Centurio_XII-I
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Centurio XII-I's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));
    
end;

