-----------------------------------------
-- ID: 4394
-- Item: ginger_cookie
-- Food Effect: 5Hrs, All Races
-----------------------------------------
-- Magic Regen While Healing 7
-- Health Regen While Healing 7
-- Plantoid Killer 5
-- Slow Resist 10
-- Virus Resist 10
-- Sleep Resist 10
-- Stun Resist 10
-- Paralyze Resist 10
-- Petrify Resist 10
-- HP 100
-- MP 100
-- Character Stats 17
-- Attack 17
-- Defense 17
-- Accuracy 17
-- Evasion 17
-- Store TP 17
-- Haste 40%
-- Regen 150 3Tic
-- Refresh 150 3Tic
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,18000,4394);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_PLANTOID_KILLER, 5);
	target:addMod(MOD_SLOWRES, 10);
	target:addMod(MOD_VIRUSRES, 10);
	target:addMod(MOD_SLEEPRES, 10);
	target:addMod(MOD_STUNRES, 10);
	target:addMod(MOD_PARALYZERES, 10);
	target:addMod(MOD_PETRIFYRES, 10);
	target:addMod(MOD_FOOD_HPP, 10);
	target:addMod(MOD_MP, 100);
	target:addMod(MOD_STR, 17);
	target:addMod(MOD_DEX, 17);
	target:addMod(MOD_AGI, 17);
	target:addMod(MOD_VIT, 17);
	target:addMod(MOD_INT, 17);
	target:addMod(MOD_MND, 17);
	target:addMod(MOD_CHR, 17);
	target:addMod(MOD_HPHEAL, 7);
	target:addMod(MOD_MPHEAL, 7);
	target:addMod(MOD_ATT, 17);
	target:addMod(MOD_DEF, 17);
	target:addMod(MOD_ACC, 17);
	target:addMod(MOD_RACC, 70);
	target:addMod(MOD_EVA, 17);
	target:addMod(MOD_STORETP, 17);
	if(target:hasStatusEffect(EFFECT_HASTE) == false) then
		target:addStatusEffect(EFFECT_HASTE,400,0,18000)
	end;
	if(target:hasStatusEffect(EFFECT_REGEN) == false) then
		target:addStatusEffect(EFFECT_REGEN,50,3,18000);
	end;
	if(target:hasStatusEffect(EFFECT_REFRESH) == false) then
		target:addStatusEffect(EFFECT_REFRESH,50,3,18000);
	end;
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_PLANTOID_KILLER, 5);
	target:delMod(MOD_SLOWRES, 10);
	target:delMod(MOD_VIRUSRES, 10);
	target:delMod(MOD_SLEEPRES, 10);
	target:delMod(MOD_STUNRES, 10);
	target:delMod(MOD_PARALYZERES, 10);
	target:delMod(MOD_PETRIFYRES, 10);
	target:delMod(MOD_FOOD_HPP, 10);
	target:delMod(MOD_MP, 100);
	target:delMod(MOD_STR, 17);
	target:delMod(MOD_DEX, 17);
	target:delMod(MOD_AGI, 17);
	target:delMod(MOD_VIT, 17);
	target:delMod(MOD_INT, 17);
	target:delMod(MOD_MND, 17);
	target:delMod(MOD_CHR, 17);
	target:delMod(MOD_HPHEAL, 7);
	target:delMod(MOD_MPHEAL, 7);
	target:delMod(MOD_ATT, 17);
	target:delMod(MOD_DEF, 17);
	target:delMod(MOD_ACC, 17);
	target:delMod(MOD_RACC, 70);
	target:delMod(MOD_EVA, 17);
	target:delMod(MOD_STORETP, 17);
end;
