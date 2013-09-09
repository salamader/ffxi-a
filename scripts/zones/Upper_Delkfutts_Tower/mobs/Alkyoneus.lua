-----------------------------------
-- Area: Upper Delkfutt's Tower
-- NPC:  Alkyoneus
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