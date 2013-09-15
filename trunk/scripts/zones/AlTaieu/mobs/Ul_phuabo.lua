-----------------------------------
-- Area: 
-- NPC:  
-----------------------------------

require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/globals/conquest");
require("scripts/globals/status");
require("scripts/globals/settings");


-----------------------------------
-- onMobSpawn
-----------------------------------

function onMobSpawn(mob)
end;
-----------------------------------
-- onMobEngaged
-----------------------------------
function onMobEngaged(mob,target)
mob:AnimationSub(1);
mob:AnimationSub(2);
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
end;
