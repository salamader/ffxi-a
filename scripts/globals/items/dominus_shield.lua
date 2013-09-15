-----------------------------------------
-- ID: 14491
-- Item: Dominus Shield
-- Item Effect: Restores 60-85 MP
-----------------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	local result = 0;
	local mMP = target:getMaxMP();
	local cMP = target:getMP();
 
	if (mMP == cMP) then
		result = 56; -- Does not let player use item if their mp is full
	end
	
	return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
    local mpHeal = math.random(60,85);

    local dif = target:getMaxMP() - target:getMP();
    if(mpHeal > dif) then
        mpHeal = dif;
    end
    target:addMP(mpHeal);
    target:messageBasic(276,0,mpHeal);
end;