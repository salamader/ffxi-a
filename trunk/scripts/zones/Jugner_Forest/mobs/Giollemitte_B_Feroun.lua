-----------------------------------
-- Area: Jugner Forest
-- Mob: Giollemitte B Feroun
-- Involved in Quest: A Timely Visit
-- ID: 17203666
-----------------------------------

require("scripts/globals/quests");
require("scripts/globals/settings");

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

ATimelyVisit = killer:getQuestStatus(SANDORIA,A_TIMELY_VISIT);

	if (ATimelyVisit == 1 and ATimelyVisitProgress == 9) then
		killer:setVar("ATimelyVisitProgress",10);
	end;
end;

