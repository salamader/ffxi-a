-----------------------------------
-- Area: Upper Delkfutt's Tower
-- NPC:  Alkyoneus
-- @zone 158
-- @pos -300.000, -175.000, 22.000
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
	GetNPCByID(17424518):hideNPC(900);
end;