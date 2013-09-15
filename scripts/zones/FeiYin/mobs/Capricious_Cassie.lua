-----------------------------------
-- Area: Fei'Yin
--  Mob: Capricious_Cassie
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)
	
	if(mob:getBattleTime() == 1800) then
		mob:rageMode();
	end
	
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

    killer:addTitle(CASSIENOVA);
    
    -- Set Capricious_Cassie's spawnpoint and respawn time (4-8 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((14400),(28800)));
    
end;