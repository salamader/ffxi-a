-----------------------------------------
-- ID: 4153
-- Item: Antacid
-- Item Effect: This medicine helps remove meal effects.
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
return 0;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)

   if(target:hasStatusEffect(EFFECT_FOOD) == true) then
	target:delStatusEffect(EFFECT_FOOD);
   end
   if(target:hasStatusEffect(EFFECT_HASTE) == true) then
   	target:delStatusEffect(EFFECT_HASTE);
   end;
   if(target:hasStatusEffect(EFFECT_REGEN) == true) then
   	target:delStatusEffect(EFFECT_REGEN);
   end;
   if(target:hasStatusEffect(EFFECT_REFRESH) == true) then
   	target:delStatusEffect(EFFECT_REFRESH);
   end
   if(target:hasStatusEffect(EFFECT_MEDICINE) == true) then
      	target:delStatusEffect(EFFECT_MEDICINE);
   end
end;


