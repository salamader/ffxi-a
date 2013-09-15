-----------------------------------
-- Area: Pso'xja
-- NPC:  Golden-Tongued Culberry 
-- @zone 9
-- @pos -271.214, 31.838, 260.258
-----------------------------------



-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	GetNPCByID(16814434):hideNPC(900);
end;
