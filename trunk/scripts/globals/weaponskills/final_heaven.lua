-------------------------------
-- Auth : Thief
-- Skill: Final Heaven
-- Class: H2H Weapon Skill
-- Level: MNK Relic Only
-- Mods : VIT:60%
-- 100%TP 	200%TP 	300%TP
-- 3.0x		3.0x	3.0x
-- Caestus/Spharai: Temporarily enhances Subtle Blow effect. * +10 Subtle Blow for a short duration after using the weapon skill. (Not implemented)
-------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/weaponskills");
require("scripts/globals/weaponskills");
function OnUseWeaponSkill(player, target, wsID)
	
	local params = {};
	--number of normal hits for ws
	params.numHits = 1;

	--stat-modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
	params.str_wsc = 0.0;		params.dex_wsc = 0.0;
	params.vit_wsc = 0.6;		params.agi_wsc = 0.0;
	params.int_wsc = 0.0;		params.mnd_wsc = 0.0;
	params.chr_wsc = 0.0;

	--ftp damage mods (for Damage Varies with TP; lines are calculated in the function params.ftp)
	params.ftp100 = 3.0; params.ftp200 = 3.0; params.ftp300 = 3.0;

	--critical modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc)
	params.crit100 = 0.0; params.crit200=0.0; params.crit300=0.0;
	params.canCrit = false;

	--accuracy modifiers (0.0 = 0%, 0.2 = 20%, 0.5 = 50%..etc) Keep 0 if ws doesn't have accuracy modification.
	params.acc100 = 0.0; params.acc200=0.0; params.acc300=0.0;

	--attack multiplier (only some WSes use this, this varies the actual ratio value, see Tachi: Kasha) 1 is default.
	params.atkmulti = 1;
	--damage = damage * ftp(player:getTP(), ftp100, ftp200, ftp300);
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	local main = player:getEquipID(SLOT_MAIN);
	local aftermath = 0;
	local tp = player:getTP();
	local duration = 0;
	local zone = player:getZone();
	
	if (main == 18264) then
		aftermath = 1;
	elseif (main == 18265) then
		aftermath = 1;
	elseif (main == 18637) then
		aftermath = 1;
	elseif (main == 18651) then
		aftermath = 1;
	elseif (main == 18665) then
		aftermath = 1;
	elseif (main == 19746) then
		aftermath = 1;
	elseif (main == 19839) then
		aftermath = 1;
	elseif ((main == 18263) and (zone == 39 or zone == 40 or zone == 41 or zone == 42 or zone == 134 or 
		zone ==135 or zone == 185 or zone == 186 or zone == 187 or zone == 188)) then
		aftermath = 1;
	end
		
	if (aftermath == 1) then
		if (tp == 300) then
			duration = 60;
			player:delStatusEffect(EFFECT_AFTERMATH_LV1);
			player:delStatusEffect(EFFECT_AFTERMATH_LV2);
			player:delStatusEffect(EFFECT_AFTERMATH_LV3);
			player:addStatusEffect(EFFECT_AFTERMATH_LV3,2,0,duration);
		elseif (tp >= 200) then
			duration = 40;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				player:delStatusEffect(EFFECT_AFTERMATH_LV1);
				player:delStatusEffect(EFFECT_AFTERMATH_LV2);
				player:addStatusEffect(EFFECT_AFTERMATH_LV2,2,0,duration);
			end
		else
			duration = 20;
			if (player:hasStatusEffect(EFFECT_AFTERMATH_LV3) == false) then
				if (player:hasStatusEffect(EFFECT_AFTERMATH_LV2) == false) then
					player:delStatusEffect(EFFECT_AFTERMATH_LV1);
					player:addStatusEffect(EFFECT_AFTERMATH_LV1,2,0,duration);
				end
			end
		end
	end

	return tpHits, extraHits, criticalHit, damage;
end
