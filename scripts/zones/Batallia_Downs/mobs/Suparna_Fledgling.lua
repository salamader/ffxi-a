-----------------------------------
-- Area: Batallia Downs
-- NPC:  Suparna Fledgling
-- Involved in Mission: Breaking
-- Barriers
-- @zone 105
-- @pos -715.882, -10.75, 65.982
-----------------------------------

require("scripts/globals/missions");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath Action
-----------------------------------

function onMobDeath(mob,killer)

	local kills = killer:getVar("Mission9-1Kills");

	if(killer:getCurrentMission(SANDORIA) == BREAKING_BARRIERS and killer:getVar("MissionStatus") == 3 and kills < 2) then
		killer:setVar("Mission9-1Kills",kills + 1);
	end
	
end;