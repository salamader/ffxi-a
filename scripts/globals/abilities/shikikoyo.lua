-------------------------
-- Shikikoyo
-------------------------
require("scripts/globals/settings");
require("scripts/globals/status");

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
  selftp = player:getTP();
  targettp = target:getTP();

  if (selftp <= 100) then
    newttp = targettp;
    newstp = selftp;
    addtp = 0;
  end
  if (selftp >= 100) then
    addtp = selftp - 100;
    newttp = targettp + addtp;
    newstp = 100;
  end

  if (targettp >= 300) then
    newttp = targettp;
    newstp = selftp;
    addtp = 0;
  end
  if (selftp <= 100) then
    ability:setMsg(323);
    ability:setResult(addtp);
  else
    ability:setMsg(452);
    ability:setResult(addtp);
  end

  player:setTP(newstp);
  target:setTP(newttp);
end;