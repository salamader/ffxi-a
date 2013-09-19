-----------------------------------
-- Area: Upper Delkfutt's Tower
-- NPC:  Pallas
-- @zone 158
-- @pos -300.000, -159.000, 21.000
-----------------------------------

-----------------------------------
-- OnMobSpawn Action
-----------------------------------

function onMobSpawn(mob)
end; 

-----------------------------------
-- OnMobDeath Action
-----------------------------------

function onMobDeath(mob,killer)
	GetNPCByID(17424519):hideNPC(900);
end;
