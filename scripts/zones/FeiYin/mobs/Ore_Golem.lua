-----------------------------------
-- Area: FeiYin
-- NPC:  Ore Golem
-----------------------------------
-----------------------------------

require("scripts/globals/keyitems");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	
	-- Curses, Foiled A-Golem!?
	if(killer:hasKeyItem(SHANTOTTOS_NEW_SPELL)) then
		killer:delKeyItem(SHANTOTTOS_NEW_SPELL);
		killer:addKeyItem(SHANTOTTOS_EXSPELL);
	end
	
end;