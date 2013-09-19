-----------------------------------
-- Area: Uleguerand_Range
-- NPC:  Geush Urvan
-- @zone 5
-- @pos 563.638, -35.719, 110.362
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
	GetNPCByID(16798094):hideNPC(900);
end;
