-----------------------------------------
-- ID: 4145
-- Item: Elixir
-- Item Effect: Instantly restores 100% of HP and MP
-----------------------------------------

require("scripts/globals/settings");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
local mHP = target:getMaxHP();
local cHP = target:getHP();
local mMP = target:getMaxMP();
local cMP = target:getMP();


if (mHP == cHP and mMP == cMP) then
    result = 56; -- Does not let player use item if their hp and mp are full
end

return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
    target:addHP(target:getMaxHP());
    target:addMP(target:getMaxMP());
    target:messageBasic(26);
end;