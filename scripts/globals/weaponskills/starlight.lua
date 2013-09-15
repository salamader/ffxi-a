------------------------
--      Starlight     --
------------------------
require("scripts/globals/status");
require("scripts/globals/settings");
require("scripts/globals/weaponskills");

function OnUseWeaponSkill(player, target, wsID)
	local lvl = player:getSkillLevel(11); --get club skill
	local damage = (lvl-10)/9;
	local damagemod = damage * (player:getTP()/100);
	if (player:getEquipID(SLOT_MAIN) == 18887 or player:getEquipID(SLOT_SUB) == 18887) then
		damagemod = damage * (player:getTP()/100) * 3;
	end
	return 1, 0, false, damagemod;
end
