-----------------------------------
-- Ability: Chi Blast
-- Release Chi to attack an enemy.
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)
	local sHands = player:getEquipID(SLOT_HANDS);
	local main = player:getEquipID(SLOT_MAIN);
	local boost = player:getStatusEffect(EFFECT_BOOST);
	local multiplier = 1.0;
	if(boost ~= nil) then
		multiplier = (boost:getPower()/100) * 4; --power is the raw % atk boost
		if(sHands == 13962 or sHands == 14891) then -- Temple Gloves / +1
			multiplier = multiplier + (multiplier * .25);
		end
		if(main == 18779) then -- Taurine Cesti
			multiplier = multiplier + (multiplier * .25);
		end
	end
	end
	
	local dmg = math.floor(player:getStat(MOD_MND)*(0.5+(math.random()/2))) * multiplier;

	dmg = utils.stoneskin(target, dmg);
	
	target:delHP(dmg);
    target:updateEnmityFromDamage(player,dmg);
	player:delStatusEffect(EFFECT_BOOST);
	return dmg;
end;
