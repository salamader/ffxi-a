-----------------------------------
-- Area: King Ranperre's Tomb
-- NPC:  Vrtra
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- OnMobInitialize Action
-----------------------------------

function onMobInitialize(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
    killer:addTitle(VRTRA_VANQUISHER);
    
    -- Set Vrtra's spawnpoint and respawn time (4-8 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((14400),(28800)));
    
end;