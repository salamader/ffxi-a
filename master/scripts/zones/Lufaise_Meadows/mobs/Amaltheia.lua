-----------------------------------
-- Area: Lufaise Meadows (24)
-- NPC:  Amaltheia
-- @zone 24
-- @pos 347.897, -10.895, 264.382
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
	GetNPCByID(16875854):hideNPC(900);
end;
