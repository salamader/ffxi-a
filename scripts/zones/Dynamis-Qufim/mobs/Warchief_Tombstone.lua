-----------------------------------
-- Area: Dynamis Qufim
-- NPC:  Warchief Tombstone
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
	if(mobID == 16945480 and alreadyReceived(killer,4) == false)then
		killer:addTimeToDynamis(10);
		addDynamisList(killer,8);
		--print("addtime 10min");
	end
end;
