-----------------------------------
-- Area: Quicksand Caves (208)
-- Mob: Honor
-- Involved in Mission: Coming of
-- Age (San dOria Mission 8-1)
-- @zone 208
-- @pos 575, 22, -933
-----------------------------------

require("scripts/globals/missions");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)

end;

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)
	
end;

-----------------------------------
-- onMobDeath Action
-----------------------------------

function onMobDeath(mob,killer)
	
	if(killer:getCurrentMission(SANDORIA) == COMING_OF_AGE and killer:getVar("MissionStatus") == 2) then
		killer:setVar("MissionStatus",3);
	end
	
end;