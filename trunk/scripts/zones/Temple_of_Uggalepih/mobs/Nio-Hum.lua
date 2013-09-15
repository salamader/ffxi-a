-----------------------------------
-- Area: Temple of Uggalepih (159)
-- Mob: Nio-Hum
-- Involved in Mission: Lightbringer
-- (Sandoria 8-2)
-- @zone 159
-- @pos -52.853, -17.000, -143.869
-----------------------------------

require("scripts/zones/Temple_of_Uggalepih/MobIDs");
require("scripts/globals/missions");
require("scripts/globals/keyitem");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	
	if(killer:getCurrentMission(SANDORIA) == LIGHTBRINGER and killer:getVar("Mission8-2Kills") < 2) then
		local kills = killer:getVar("Mission8-2Kills");
		killer:setVar("Mission8-2Kills",kills + 1);
	end
end;
