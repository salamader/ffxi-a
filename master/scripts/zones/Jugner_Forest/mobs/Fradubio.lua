----------------------------------	
-- Area: Jugner_Forest
-- NM:  Fradubio
-- @pos 104
-- @pos 76.573, -0.901, -246.241
-----------------------------------	

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Fradubio spawnpoint and respawn time (21-24 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((75600),(86400)));

end;
