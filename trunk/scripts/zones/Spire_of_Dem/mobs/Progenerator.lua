-----------------------------------
--  Area: Spire of Dem (19)
--   Mob: Progenerator
-----------------------------------

-- require("scripts/zones/Spire_of_Dem/MobIDs");

-----------------------------------
-- onMobInitialize
-----------------------------------

function onMobInitialize(mob)	
end;

-----------------------------------
-- onMobSpawn
-----------------------------------

function onMobSpawn(mob)	
end;

-----------------------------------
-- onMobEngaged
-----------------------------------

function onMobEngaged(mob,target)	
end;

-----------------------------------
-- onMobFight
-----------------------------------

function onMobFight(mob,target)	
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)
	killer:setVar("PD",3);
end;

