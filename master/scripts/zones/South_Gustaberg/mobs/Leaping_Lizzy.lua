----------------------------------	
-- Area: South Gustaberg	
-- NM:  Leaping Lizzy	
-----------------------------------	

-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	

    -- Set LL's ToD
    SetServerVariable("[POP]Leaping_Lizzy", os.time(t) + math.random((1440),(3600))); -- 24min-1hr
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Leaping_Lizzy");
    SetServerVariable("[PH]Leaping_Lizzy", 0);
    DeterMob(PH, false);
    GetMobByID(PH):setRespawnTime(GetMobRespawnTime(PH));
  
end;