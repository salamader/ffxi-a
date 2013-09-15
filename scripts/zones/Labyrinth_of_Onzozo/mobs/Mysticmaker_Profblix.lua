----------------------------------	
-- Area: Labyrinth of Onzozo	
--   NM: Mysticmaker Profblix
-----------------------------------	

-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Mysticmaker's spawnpoint and respawn time (1-2 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(7200)));
  
end;