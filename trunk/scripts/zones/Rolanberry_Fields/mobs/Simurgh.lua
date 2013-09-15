-----------------------------------
-- Area: Rolanberry Fields (110)
--  HMN: Simurgh
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

	killer:addTitle(SIMURGH_POACHER);
  
    -- Set Simurgh's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));
  
end;