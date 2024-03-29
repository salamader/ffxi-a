-----------------------------------
-- Ability: Dark Shot
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	--ranged weapon/ammo: You do not have an appropriate ranged weapon equipped.
	--no card: <name> cannot perform that action.
	if (player:getWeaponSkillType(SLOT_RANGED) ~= SKILL_MRK or player:getWeaponSkillType(SLOT_AMMO) ~= SKILL_MRK) then
		return 216,0;
	end
	if (player:hasItem(2183, 0) or player:hasItem(2974, 0)) then
		return 0,0;
	else
		return 71, 0;
	end
end;

function OnUseAbility(player, target, ability)
	
	local duration = 60;
	local resist = applyResistanceAbility(player,target,ELE_DARK,SKILL_MRK);
	
	if(resist < 0.25) then
		ability:setMsg(324);--resist message
		return 0;
	end
	
	duration = duration * resist;
	
	local effects = {};
	local counter = 1;
	local bio = target:getStatusEffect(EFFECT_BIO);
	if (bio ~= nil) then
		effects[counter] = bio;
		counter = counter + 1;
	end
	local threnody = target:getStatusEffect(EFFECT_THRENODY);
	if (threnody ~= nil and threnody:getSubPower() == MOD_LIGHTRES) then
		effects[counter] = threnody;
		counter = counter + 1;
	end
	
	if counter > 1 then
		local effect = effects[math.random(1, counter-1)];
		local duration = effect:getDuration();
		local startTime = effect:getStartTime();
		local tick = effect:getTick();
		local power = effect:getPower();
		local subpower = effect:getSubPower();
		local tier = effect:getTier();
		local effectId = effect:getType();
		local subId = effect:getSubType();
		power = power * 1.5;
		subpower = subpower * 1.5;
		target:delStatusEffectSilent(effectId);
		target:addStatusEffect(effectId, power, tick, duration, subId, subpower, tier);
		local newEffect = target:getStatusEffect(effectId);
		newEffect:setStartTime(startTime);
	end
	
	ability:setMsg(321);
	local dispelledEffect = target:dispelStatusEffect();
	if(dispelledEffect == EFFECT_NONE) then
		-- no effect
		ability:setMsg(323);
	end
	
	return dispelledEffect;
end;