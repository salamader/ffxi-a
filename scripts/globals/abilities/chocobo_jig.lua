-----------------------------------
-- 	Chocobo Jig
-- 	Increases movement speed.
-----------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	  -- Lasts for 120 seconds
	  duration = 120;
	  -- Jig Duration Bonus
	  duration = duration + player:getMod(MOD_JIG_TIME);

	  if (player:getStatusEffect(EFFECT_QUICKENING)) then
		player:removeStatusType(EFFECT_QUICKENING);
	  end

	  -- No effect if Flee or Mazurka is active
	  if (player:getStatusEffect(EFFECT_FLEE) or player:getStatusEffect(EFFECT_MAZURKA)) then
		ability:setMsg(323);
	  else
		player:addStatusEffect(EFFECT_QUICKENING,25,0,duration);
		ability:setMsg(126);
	  end
end;
