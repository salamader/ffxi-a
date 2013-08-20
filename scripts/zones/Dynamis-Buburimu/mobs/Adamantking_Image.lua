-----------------------------------
-- Area: Dynamis Buburimu
-- NPC:  Adamantking_Image
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/dynamis");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)
local mobID = mob:getID();
	if(mobID == 16941458 and alreadyReceived(killer,1) == false)then
		killer:addTimeToDynamis(10);
		addDynamisList(killer,1);
		--print("addtime 10min");
	end
end;