
utils = {};

function utils.clamp(input, min_val, max_val)
    if input < min_val then
        input = min_val;
    elseif input > max_val then
        input = max_val;
    end
    return input;
end;

function utils.manawall(target, dmg)
    --handling mana wall
    wall = target:getMP();
    if(wall > 0) then
        if(wall > ((dmg / 2) - (dmg * (target:getMod(MOD_MANA_WALL_DMG) / 100)))) then --absorb full half damage
            target:delMP(dmg / 2);
            return 0;
        else --absorbs some damage based on MP
            target:delMP(wall);
			target:delStatusEffect(EFFECT_MANA_WALL);
            return (((dmg / 2) - (dmg * (target:getMod(MOD_MANA_WALL_DMG) / 100))) - wall);
        end
		updateEnmity(target,-180,0);
    end

    return dmg;
end;

function utils.sacrosanctityDmg(target, dmg)

    dmg = dmg * .25;

    return dmg;
end;

function utils.scarletDelirium(target, dmg)
	if (dmg > 0) then
		scarletDeliriumBonus = ((dmg / target:getMaxHP()) / 2) * 100;
		target:delStatusEffect(EFFECT_SCARLET_DELIRIUM_I);
		target:addStatusEffect(EFFECT_SCARLET_DELIRIUM_II,scarletDeliriumBonus,0,60);
	end

    return;
end;

function utils.stoneskin(target, dmg)
    --handling stoneskin
    skin = target:getMod(MOD_STONESKIN);
    if(skin > 0) then
        if(skin > dmg) then --absorb all damage
            target:delMod(MOD_STONESKIN,dmg);
            return 0;
        else --absorbs some damage then wear
            target:delStatusEffect(EFFECT_STONESKIN);
            target:setMod(MOD_STONESKIN, 0);
            return dmg - skin;
        end
    end

    return dmg;
end;

function utils.takeShadows(target, dmg, shadowbehav)
    if(shadowbehav == nil) then
        shadowbehav = 1;
    end

    local targShadows = target:getMod(MOD_UTSUSEMI);
    local shadowType = MOD_UTSUSEMI;

    if(targShadows == 0) then --try blink, as utsusemi always overwrites blink this is okay
        targShadows = target:getMod(MOD_BLINK);
        shadowType = MOD_BLINK;
    end

    if(targShadows > 0) then
    --Blink has a VERY high chance of blocking tp moves, so im assuming its 100% because its easier!

        if(targShadows >= shadowbehav) then --no damage, just suck the shadows

            local shadowsLeft = targShadows - shadowbehav;

            target:setMod(shadowType, shadowsLeft);

            if(shadowsLeft > 0 and shadowType == MOD_UTSUSEMI) then --update icon
                effect = target:getStatusEffect(EFFECT_COPY_IMAGE);
                if(effect ~= nil) then
                    if(shadowsLeft == 1) then
                        effect:setIcon(EFFECT_COPY_IMAGE);
                    elseif(shadowsLeft == 2) then
                        effect:setIcon(EFFECT_COPY_IMAGE_2);
                    elseif(shadowsLeft == 3) then
                        effect:setIcon(EFFECT_COPY_IMAGE_3);
                    end
                end
            end
            -- remove icon
            if(shadowsLeft <= 0) then
                target:delStatusEffect(EFFECT_COPY_IMAGE);
                target:delStatusEffect(EFFECT_BLINK);
            end

            return 0;
        else --less shadows than this move will take, remove all and factor damage down
            target:delStatusEffect(EFFECT_COPY_IMAGE);
            target:delStatusEffect(EFFECT_BLINK);
            return dmg * ((shadowbehav-targShadows)/shadowbehav);
        end
    end

    return dmg;
end;

-- returns true if taken by third eye
function utils.thirdeye(target)
    --third eye doesnt care how many shadows, so attempt to anticipate, but reduce
    --chance of anticipate based on previous successful anticipates.
    local teye = target:getStatusEffect(EFFECT_THIRD_EYE);

    if(teye == nil) then
        return false;
    end

    local prevAnt = teye:getPower();

    if( prevAnt == 0 or (math.random()*100) < (80-(prevAnt*10)) ) then
        --anticipated!
        target:delStatusEffect(EFFECT_THIRD_EYE);
        return true;
    end

    return false;
end

function utils.dmgTaken(target, dmg)

    local resist = 1 + (target:getMod(MOD_DMG) / 100);

    if(resist < 0.5) then
        resist = 0.5;
    end

    return dmg * resist;
end;

function utils.absorbMagicDmg(target, dmg) -- Elemental Sachets
	target:addHP(dmg);
    if(dmg > 0) then
		target:messageBasic(24,0,dmg);
	end
	dmg = 0;
	return dmg;
end;

function utils.dmgToMP(target, dmg)

    if(target:getObjType() == TYPE_PC) then
		local etherealMP = 0;
		local percentMP = 0;
    	if(target:getEquipID(SLOT_EAR1) == 15965 or target:getEquipID(SLOT_EAR2) == 15965) then -- Ethereal Earring
    		percentMP = percentMP + .03;
		end
    	if(target:getEquipID(SLOT_HEAD) == 11170) then -- Creed Armet +1
    		percentMP = percentMP + .03;
		end
    	if(target:getEquipID(SLOT_HEAD) == 11070) then -- Creed Armet +2
    		percentMP = percentMP + .03;
		end
		etherealMP = math.floor(dmg * percentMP);
		target:addMP(etherealMP);
    	if(etherealMP > 0) then
			target:messageBasic(25,0,etherealMP);
		end
		-- printf("MP Gained %u",etherealMP);
    end
	
end;

function utils.dmgToTP(target, dmg)

    if(target:getObjType() == TYPE_PC) then
		local dmgTP = 0;
		local percentTP = 0;
    	if(target:getEquipID(SLOT_SUB) == 28671) then -- Butznard Shield
    		percentTP = percentTP + .005;
		end
    	if(target:getEquipID(SLOT_SUB) == 28669) then -- Butznard Shield +1
    		percentTP = percentTP + .006;
		end
		if(target:getEquipID(SLOT_BODY) == 11868) then -- Mekira Meikogai
    		percentTP = percentTP + .014;
		end
		if(target:getEquipID(SLOT_BODY) == 11865) then -- Mekira Toshugai
    		percentTP = percentTP + .01;
		end
		if(target:getEquipID(SLOT_BODY) == 11871) then -- Mekira Toshugai +1
    		percentTP = percentTP + .012;
		end
		dmgTP = math.floor(dmg * percentTP);
		target:addTP(dmgTP);
		-- printf("TP Gained %u",dmgTP);
    end
	
end;

function utils.breathDmgTaken(target, breathDmg)

    local resist = 1 + (target:getMod(MOD_UDMGBREATH) / 100);

    breathDmg = breathDmg * resist;

    resist = 1 + (target:getMod(MOD_DMGBREATH) / 100);

    if(resist < 0.5) then
        resist = 0.5;
    end

    return breathDmg * resist;
end;

function utils.magicDmgTaken(target, magicDmg)

	local ring1 = target:getEquipID(SLOT_RING1);
	local ring2 = target:getEquipID(SLOT_RING2);
    -- MDT is stored in amount/256
    local resist = ((256 + target:getMod(MOD_UDMGMAGIC))/256);

    magicDmg = magicDmg * resist;

    resist = ((256 + target:getMod(MOD_DMGMAGIC))/256);

    if(resist < 0.5) then
        resist = 0.5;
    end
	
	if(target:getObjType() == TYPE_PC) then
		if(((ring1 == 14646) or (ring2 == 14646)) -- Shadow Ring
		and (math.random(100) <= 13)) then
			magicDmg = 0;
		end
	
		if((((magicDmg * resist) / target:getMaxHP()) * 100) > 50) then
			if(((ring1 == 11647) or (ring2 == 11647)) -- Archon Ring
			and (math.random(100) <= 5)) then
				magicDmg = 0;
			end
		end
	end

    return magicDmg * resist;
end;

function utils.physicalDmgTaken(target, dmg)

    local resist = 1 + (target:getMod(MOD_UDMGPHYS) / 100);

    dmg = dmg * resist;

    resist = 1 + (target:getMod(MOD_DMGPHYS) / 100);

    if(resist < 0.5) then
        resist = 0.5;
    end
	
	if(target:getObjType() == TYPE_PC) then
		if(target:getEquipID(SLOT_HEAD) == 14646 and (math.random(100) <= 5)) then -- Nocturnus Helm
			target:addHP(dmg);
			if(dmg > 0) then
				target:messageBasic(24,0,dmg);
			end
			dmg = 0;
		end
		if((((dmg * resist) / target:getMaxHP()) * 100) > 50) then
			if(target:getEquipID(SLOT_BACK) == 14646 and (math.random(100) <= 5)) then -- Archon Cape
				dmg = 0;
			end
		end
	end

    return dmg * resist;
end;

function utils.rangedDmgTaken(target, dmg)

    local resist = 1 + (target:getMod(MOD_UDMGRANGE) / 100);

    dmg = dmg * resist;

    resist = 1 + (target:getMod(MOD_DMGRANGE) / 100);

    if(resist < 0.5) then
        resist = 0.5;
    end

    return dmg * resist;
end;