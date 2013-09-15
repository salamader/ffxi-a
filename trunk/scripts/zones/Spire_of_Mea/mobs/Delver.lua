-----------------------------------
--  Area: Spire of Mea (21)
--   Mob: Delver
-----------------------------------

-- require("scripts/zones/Spire_of_Mea/MobIDs");

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
	killer:setVar("PM",3);
end;

