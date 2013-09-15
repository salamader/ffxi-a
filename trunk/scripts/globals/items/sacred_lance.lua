-----------------------------------------
--  ID: 16858
--  Item: Sacred Lance
--  Enchantment: "Enlight"
-----------------------------------------

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
    local effect = EFFECT_ENLIGHT;
    doEnspell(target,target,nil,effect);
end;
