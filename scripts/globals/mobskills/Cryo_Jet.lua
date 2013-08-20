---------------------------------------------------
--  Cryo_Jet
--  Description: 
--  Type: Magical
--  additional effect : Paralyze

---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
 local mobID = mob:getID();   --(16908295 ,16908302 ,16908309 =omega ,          16928966=proto-ultima   )
 local mobhp = mob:getHPP();
   if (mobID == 16928966)then
      if(mobhp < 70 and mobhp > 40)then
	     return 0;
	  end
   elseif(mobID == 16908295 or mobID == 16908302 or mobID == 16908309)then
      if(mobhp < 80 and mobhp > 40)then
	     return 0;
	  end	  
   end
   return 1;
end;

function OnMobWeaponSkill(target, mob, skill)

	local typeEffect = EFFECT_PARALYSIS;
    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 3, 60);
	
    local dmgmod = 2;
	local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*3,ELE_ICE,dmgmod,TP_MAB_BONUS,1);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_ICE,MOBPARAM_IGNORE_SHADOWS);
    target:delHP(dmg);
    return dmg;
end
