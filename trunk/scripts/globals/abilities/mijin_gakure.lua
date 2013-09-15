-----------------------------------
-- Ability: Mijin Gakure
-- Sacrafices your own life to deal
-- damage to the enemy.
-----------------------------------

require("scripts/globals/monstertpmoves");
require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	return 0,0;
end;

function OnUseAbility(player, target, ability)

    local dmg = (player:getHP() * 0.8) + (player:getMainLvl() / 0.5);
	local resist = applyPlayerResistance(player, nil, target, player:getStat(MOD_INT)-target:getStat(MOD_INT), 0, ELE_NONE);
	
	dmg = dmg * resist;

    if (target:getEquipID(SLOT_AMMO) == 19211) then
    	dmg = dmg * 1.1;
    end
    
    local main = player:getEquipID(SLOT_MAIN);
    local sub = player:getEquipID(SLOT_SUB);
    local reraise = 0;
    if(main == 19003 or sub == 19003) then -- Nagi Lvl 75
    	reraise = 1;
    elseif(main == 19072 or sub == 19072) then -- Nagi Lvl 80
    	reraise = 1;
    elseif(main == 19092 or sub == 19092) then -- Nagi Lvl 85
    	reraise = 1;
    elseif(main == 19624 or sub == 19624) then -- Nagi Lvl 90
    	reraise = 1;
    elseif(main == 19722 or sub == 19722) then -- Nagi Lvl 95
    	reraise = 1;
    elseif(main == 19831 or sub == 19831) then -- Nagi Lvl 99
    	reraise = 1;
    elseif(main == 19960 or sub == 19960) then -- Nagi Lvl 99-2
    	reraise = 1;
    end
    
    if(reraise == 1) then
    	player:addStatusEffect(EFFECT_RERAISE,4,0,3600);
    end
    
    player:setHP(0);
    
    target:delHP(dmg);

    return dmg;
end;
