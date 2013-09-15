-----------------------------------
-- Ability: Meditate
-----------------------------------
 
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local amount = 12;
	if(player:getMainJob()==12) then
		amount = 20;
	end
	--TODO: Meditate doesnt actually give an icon, it's not regain as such.

	local tick = 15;
	tick = tick + target:getMod(MOD_MEDITATE_DUR);

	player:addStatusEffectEx(EFFECT_REGAIN,0,amount,3,tick);
end;
