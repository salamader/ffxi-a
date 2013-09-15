-----------------------------------
-- Death Blossom     
-- Sword weapon skill
-- Skill level: ??? (RDM ONRY!)
-- Delivers a three-hit attack. MEva down chance varies with TP.
-- Modifiers: STR:30% ; MND:50% 
-- 100%TP 	200%TP 	300%TP
-- 1.50 	1.50	1.50
-----------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/weaponskills");
require("scripts/globals/weaponskills");
function OnUseWeaponSkill(player, target, wsID)
	local params = {};
	params.numHits = 3;
	--ftp damage mods (for Damage Varies with TP; lines are calculated in the function
	params.ftp100 = 1.125; params.ftp200 = 1.125; params.ftp300 = 1.125;
	--wscs are in % so 0.2=20%
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.5; params.chr_wsc = 0.0;
	--critical mods, again in % (ONLY USE FOR critICAL HIT VARIES WITH TP)
	params.crit100 = 0.0; params.crit200=0.0; params.crit300=0.0;
	params.canCrit = false;
	--accuracy mods (ONLY USE FOR accURACY VARIES WITH TP) , should be the acc at those %s NOT the penalty values. Leave 0 if acc doesnt vary with tp.
	params.acc100 = 0.0; params.acc200=0.0; params.acc300=0.0;
	--attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
	params.atkmulti = 1;
	
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 then
		local tp = player:getTP();
		local duration = (tp/100 * 20) - 5;
		if(target:hasStatusEffect(EFFECT_MAGIC_EVASION_DOWN) == false) then
			target:addStatusEffect(EFFECT_MAGIC_EVASION_DOWN, 10, 0, duration);
		end
	end
	
	local main = player:getEquipID(SLOT_MAIN);
	local sub = player:getEquipID(SLOT_SUB);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local subpower = 0;
	
	if (main == 18995 or sub == 18995) then
		aftermath = 1;
	elseif (main == 19064 or sub == 19064) then
		aftermath = 1;
	elseif (main == 19084 or sub == 19084) then
		aftermath = 1;
	elseif (main == 19616 or sub == 19616) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19714 or sub == 19714) then
		aftermath = 1;
		damage = damage * 1.15;
	elseif (main == 19823 or sub == 19823) then
		aftermath = 1;
		damage = damage * 1.3;
	elseif (main == 19952 or sub == 19952) then
		aftermath = 1;
		damage = damage * 1.3;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			if (main == 18995 or sub == 18995) then
				duration = 120;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,40);
			elseif ((main == 19064 or sub == 19064) or (main == 19084 or sub == 19084) or (main == 19616  or sub == 19616)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,14,0,duration,0,60);
			elseif ((main == 19714 or sub == 19714) or (main == 19823 or sub == 19823) or (main == 19952 or sub == 19952)) then
				duration = 180;
				player:addStatusEffect(EFFECT_AFTERMATH_LV3,15,0,duration,0,20);
			end
		elseif (tp >= 200) then
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				if (main == 18995 or sub == 18995) then
					duration = 180;
					subpower = math.floor((tp / 10) - 10);
				elseif ((main == 19064 or sub == 19064) or (main == 19084 or sub == 19084) or (main == 19616  or sub == 19616)) then
					duration = 270;
					subpower = math.floor((tp / 5) - 20);
				elseif ((main == 19714 or sub == 19714) or (main == 19823 or sub == 19823) or (main == 19952 or sub == 19952)) then
					duration = 270;
					subpower = math.floor((tp / 5) - 10);
				end
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,16,0,duration,0,subpower);
			end
		else
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					if (main == 18995 or sub == 18995) then
						duration = 180;
						subpower = math.floor(tp / 10);
					elseif ((main == 19064 or sub == 19064) or (main == 19084 or sub == 19084) or (main == 19616  or sub == 19616)) then
						duration = 270;
						subpower = math.floor(tp / 10);
					elseif ((main == 19714 or sub == 19714) or (main == 19823 or sub == 19823) or (main == 19952 or sub == 19952)) then
						duration = 270;
						subpower = math.floor(tp / 10);
					end
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,15,0,duration,0,subpower);
				end
			end
		end
	end
	
	return tpHits, extraHits, criticalHit, damage;
end
