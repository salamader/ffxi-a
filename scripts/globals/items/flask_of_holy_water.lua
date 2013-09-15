-----------------------------------------
-- ID: 4154
-- Item: Flask of Holy Water
-- Item Effect: Removes curse
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

    local curse = target:getStatusEffect(EFFECT_CURSE_I);
    local curse2 = target:getStatusEffect(EFFECT_CURSE_II);
    local bane = target:getStatusEffect(EFFECT_BANE);
	local final = 0;
    local ring1 = target:getEquipID(SLOT_RING1);
    local ring2 = target:getEquipID(SLOT_RING2);
    local pEquipMods = 0.25;
    
    	if(ring1 == 10795 or ring2 == 10795) then -- Blenmot's & +1 Ring
    		pEquipMods = pEquipMods + .10
    	end
    	if(ring1 == 10794 or ring2 == 10794) then
    		pEquipMods = pEquipMods + .05
	end

    if(curse ~= nil and curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(EFFECT_CURSE_I);
        target:delStatusEffect(EFFECT_CURSE_II);
        target:delStatusEffect(EFFECT_BANE);
        final = EFFECT_CURSE_II;
    elseif(curse ~= nil and bane ~= nil) then
        target:delStatusEffect(EFFECT_CURSE_I);
        target:delStatusEffect(EFFECT_BANE);
        final = EFFECT_CURSE_I;
    elseif(curse2 ~= nil and bane ~= nil) then
        target:delStatusEffect(EFFECT_CURSE_II);
        target:delStatusEffect(EFFECT_BANE);
        final = EFFECT_CURSE_II;
    elseif(curse ~= nil) then
        target:delStatusEffect(EFFECT_CURSE_I);
        final = EFFECT_CURSE_I;
    elseif(curse2 ~= nil) then
        target:delStatusEffect(EFFECT_CURSE_II);
        final = EFFECT_CURSE_II;
    elseif(bane ~= nil) then
        target:delStatusEffect(EFFECT_BANE);
        final = EFFECT_BANE;
    elseif(target:hasStatusEffect(EFFECT_DOOM) and math.random() <= pEquipMods) then
        -- remove doom
        target:delStatusEffect(EFFECT_DOOM);
        target:messageBasic(359);
    else
        target:messageBasic(283);
    end

end;