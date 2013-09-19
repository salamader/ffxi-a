---------------------------------------------------
-- Mountain Buster M=12
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/summon");

---------------------------------------------------

function OnAbilityCheck(player, target, ability)
    return 0,0;
end;

function OnPetAbility(target, pet, skill)
	local numhits = 1;
	local accmod = 1;
	local dmgmod = 12;
	local dmgmodsubsequent = 0;
	local totaldamage = 0;
	local damage = AvatarPhysicalMove(pet,target,skill,numhits,accmod,dmgmod,dmgmodsubsequent,TP_NO_EFFECT,1,2,3);
	totaldamage = AvatarFinalAdjustments(damage.dmg,pet,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_SLASH,numhits);
	target:delHP(totaldamage);
	target:updateEnmityFromDamage(pet,totaldamage);

	return totaldamage;
end