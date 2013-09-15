-----------------------------------
-- Area: Temple of Uggalepih
-- NPC:  Rompaulion S Ciralle
-- Involved with San d'Oria quest "Knight Stalker"
-----------------------------------

-- require("scripts/zones/Temple_of_Uggalepih/MobIDs");

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

function onMobDeath(mob, killer)
	local Cleuvarion = GetMobAction(17428807);
	-- Get credit if other NM is dead/despawned or in the process of dieing/fading out
	if (killer:getVar("KnightStalker_Progress") == 4 and (Cleuvarion == 0 or (Cleuvarion >= 20 and Cleuvarion <= 23))) then
		killer:setVar("KnightStalker_Kill",1);
	end
end;