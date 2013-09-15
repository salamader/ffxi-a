-----------------------------------
-- 	Blade Bash
-- 	Delivers an attack that can plague the target.  Two-handed weapon required.
--
--	Mainly added for enmity, but will also do damage.
-----------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)

	if (player:isWeaponTwoHanded()) then
		final = player:getMainLvl();
		
		if (player:getEquipID(SLOT_EAR1) == 0x39a6 or player:getEquipID(SLOT_EAR2) == 0x39a6) then --Knightly Earring
			final = final+10;
		end
		
		target:removeHP(final);
		ability:setMsg(110);
		ability:setResult(final);
	end
	
end;