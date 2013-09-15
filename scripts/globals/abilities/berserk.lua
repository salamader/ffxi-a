-----------------------------------
-- Ability: Berserk
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

	local feet = target:getEquipID(SLOT_FEET);
	local weapon = target:getEquipID(SLOT_MAIN);
	local defMod = -25;
	local atkMod = 25;
	local critMod = 0;

	duration = 180;
	if (feet == 10730) then -- Warriors Calligae +2
		duration = duration + 10;
	end
	
	if (feet == 15132 or feet == 15665 or feet == 10730) then -- Warriors Calligae /+1/+2
		defMod = defMod + 10	
	end
	if (weapon == 18991) then -- Conqueror Lvl 75
		defMod = defMod - 5;
		atkMod = atkMod + 5;
		critMod = 5;
	elseif (weapon == 19060) then -- Conqueror Lvl 80
		defMod = defMod - 6;
		atkMod = atkMod + 6;
		critMod = 7;
	elseif (weapon == 19080) then  -- Conqueror Lvl 85
		defMod = defMod - 7;
		atkMod = atkMod + 7;
		critMod = 9;
	elseif (weapon == 19612 or weapon == 19710) then -- Conqueror Lvl 90-95
		defMod = defMod - 8;
		atkMod = atkMod + 8;
		critMod = 11;
	elseif (weapon == 19819 or weapon == 19948) then -- Conqueror Lvl 99-99
		defMod = defMod - 9;
		atkMod = atkMod + 9;
		critMod = 14;
	end	

	player:addStatusEffect(EFFECT_BERSERK,defMod,0,duration,0,aktMod,critMod);

    return EFFECT_BERSERK;
end;