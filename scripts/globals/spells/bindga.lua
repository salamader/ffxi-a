-----------------------------------------
-- Spell: Bindga
-----------------------------------------
require("scripts/globals/status");
require("scripts/globals/magic");
-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)

	--Pull base stats.
	dINT = (caster:getStat(MOD_INT) - target:getStat(MOD_INT));
	bonus = AffinityBonus(caster,spell:getElement());

	--Duration, including resistance.  May need more research.
	duration = math.random(5,60);

	--Resist
	resist = applyResistance(caster,spell,target,dINT,35,bonus);
	
	local resistMod = 100 * math.random();
	local body = caster:getEquipID(SLOT_BODY);
	if (body == 11088) then -- Estoquers Sayon +2
		resistMod = resistMod + 10;
	end
	
	if(resistMod >= target:getMod(MOD_BINDRES)) then
		if(resist >= 0.5) then --Do it!
			--Try to erase a weaker bind.
			if(target:addStatusEffect(EFFECT_BIND,target:speed(),0,duration)) then
						spell:setMsg(236);
					else
						spell:setMsg(75);
			end
		end
	else
		spell:setMsg(85);
	end


	return EFFECT_BIND;

end;