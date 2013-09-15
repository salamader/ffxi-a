----------------------------------	
-- Area: Gustav Tunnel	
--   NM: Bune
-----------------------------------	

-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	

    -- Set Bune's spawnpoint and respawn time (4-8 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((14400),(28800)));
  
end;