----------------------------------	
-- Area: Gustav Tunnel
--   NM: Baobhan Sith
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Baobhan Sith's Window Open Time
    wait = math.random((1),(4)) * 3600
    SetServerVariable("[POP]Baobhan_Sith", os.time(t) + wait); -- 1-4 hours
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Baobhan_Sith");
    SetServerVariable("[PH]Baobhan_Sith", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;