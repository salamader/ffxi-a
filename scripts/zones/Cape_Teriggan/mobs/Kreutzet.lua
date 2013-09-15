----------------------------------	
-- Area: Cape Teriggan	
--   NM: Kruetzet
-----------------------------------	
require("scripts/globals/weather");
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Kruetzet's spawnpoint and respawn time (1-4 hours)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((3600),(14400)));

end;

function onMobDisengage(mob, weather)
	
	if(weather ~= WEATHER_WIND and weather ~= WEATHER_GALE) then
		DespawnMob(mob:getID());
	end
	
end;