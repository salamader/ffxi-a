-----------------------------------
-- Area: King Ranperres Tomb
-- NPC:  Cemetery Cherry
-- @zone 190
-- @pos 33.000, 0.500, -287.000
-----------------------------------
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	killer:addTitle(MON_CHERRY);
end;