-----------------------------------------
-- ID: 4159
-- Item: Flask of Paralyze Potion
-- Item Effect: This potion induces paralysis.
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
    if(target:hasStatusEffect(EFFECT_PARALYSIS) == false) then
        target:addStatusEffect(EFFECT_PARALYSIS,20,0,180);
    else
        target:messageBasic(423);
    end
end;

