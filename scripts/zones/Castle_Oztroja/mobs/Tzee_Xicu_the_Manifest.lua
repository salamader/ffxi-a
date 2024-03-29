-----------------------------------
-- Area: Castle Oztroja
-- NPC:  Tzee Xicu the Manifest
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
	killer:addTitle(DEITY_DEBUNKER);
    
    -- Set Tzee_Xicu_the_Manifest's Window Open Time
    wait = 8 * 3600
    SetServerVariable("[POP]Tzee_Xicu_the_Manifest", os.time(t) + wait); -- 8 hours

    -- Set Yagudo_Avatar's spawnpoint and respawn time (1-4 hours)
    SetServerVariable("[PH]Tzee_Xicu_the_Manifest", 0);
    Yagudo_Avatar = 17396134;
    DeterMob(Yagudo_Avatar, false);
    UpdateNMSpawnPoint(Yagudo_Avatar);
    GetMobByID(Yagudo_Avatar):setRespawnTime(math.random((3600),(14400)));
    
end;