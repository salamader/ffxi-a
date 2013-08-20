---------------------------------------------
--  Swift Blade
--
--  Description: Delivers a three-hit attack. Accuracy varies with TP.
--  Type: Physical
--  Number of hits
--  Range: Melee
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

-- TODO: Skillchain

	local numhits = 3;
	local accmod = 1;
	local dmgmod = 2;
	local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_ACC_VARIES,1,2,3);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_SLASH,info.hitslanded);

	-- Around 700 damage from AA HM
   target:delHP(dmg);
	return dmg;
end;
