-----------------------------------
-- Area: Halvung
-- NPC:  Big Bomb
-- @zone 62
-- @pos -231.830, 13.613, 286.714
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
	GetNPCByID(17031608):hideNPC(900);
end;
