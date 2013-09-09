-----------------------------------
-- Area: Riverne - Site B01
-- NPC:  Unstable Cluster
-- @pos 307.500 -1.500 -706.500 29
-----------------------------------

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	GetNPCByID(16896175):hideNPC(900);
end;