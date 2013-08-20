---------------------------------------------
--  Stygian Vapor
--
--  Description: AoE Powerful plague
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------

function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
    local typeEffect = EFFECT_PLAGUE;

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 5, 0, 60));


    return typeEffect;
end;
