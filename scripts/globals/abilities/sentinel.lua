-----------------------------------
-- Ability: Sentinel
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
   -- Whether feet have to be equipped before using ability, or if they can be swapped in
   -- is disputed.  Source used: http://wiki.bluegartr.com/bg/Sentinel
	local sFeet = player:getEquipID(SLOT_FEET);
	local power = 90;
	local duration = 30;
	local merit = player:getMerit(MERIT_GUARDIAN);
	if(sFeet == 15138 or sFeet == 15671 or sFeet == 10736) then
		power = power + 13;
	end
	if(sFeet == 10736) then
		duration = duration + (2 * merit);
	end

	player:addStatusEffect(EFFECT_SENTINEL,power,3,duration);

end;