-----------------------------------
-- Area: Riverne - Site B01
-- NPC:  Boroka
-- @zone 29
-- @pos -360.140, -31.428, 484.944
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
	killer:addTitle(BOROKA_BELEAGUERER);
	mob:setRespawnTime(math.random((3600),(14400))); -- 1-4 hour respawn
end;