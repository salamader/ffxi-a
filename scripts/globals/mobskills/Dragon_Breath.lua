---------------------------------------------
--  Dragon Breath
--
--  Description: Deals Fire damage to enemies within a fan-shaped area.
--  Type: Breath
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
--  Notes: Used only by Fafnir, Nidhogg, Cynoprosopi, and Wyrm. Because of the high damage output from Fafnir/Nidhogg/Wyrm, it is usually avoided by
--        standing on (or near) the wyrm's two front feet. Cynoprosopi's breath attack is much less painful.
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");
require("/scripts/globals/utils");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
 local mobID = mob:getID();
   if (mobID == 16904202 or mobID == 16904203 or mobID == 16904204  )then -- dragon is not ouryu's mission
	  return 1;
   end
    
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.2, 1.25, ELE_FIRE, 1600);

    local dis = ((mob:checkDistance(target)*2) / 20);
    -- lower damage when closer to front feet
    dmgmod = dmgmod * dis;

    utils.clamp(dmgmod, 50, 1600);

	local dmg = MobFinalAdjustments(dmgmod,mob,skill,target,MOBSKILL_BREATH,MOBPARAM_FIRE,MOBPARAM_IGNORE_SHADOWS);
	target:delHP(dmg);
	return dmg;
end;
