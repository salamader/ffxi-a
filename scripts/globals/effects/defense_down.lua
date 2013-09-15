-----------------------------------
--
-- EFFECT_DEFENSE_DOWN
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	omod = target:getMod(MOD_PIERCERES);
	omod1 = target:getMod(MOD_SLASHRES);
	omod2 = target:getMod(MOD_IMPACTRES);
	omod3 = target:getMod(MOD_HTHRES);
	if(effect:getPower()>100 and effect:getPower()< 500) then
		effect:setPower(50);
		target:addMod(MOD_DEFP,-effect:getPower());
	end
	if(effect:getPower()<100) then
		target:addMod(MOD_DEFP,-effect:getPower());
	end
	if(effect:getPower() == 500) then
			target:addMod(MOD_PIERCERES,(omod * .5));
			target:addMod(MOD_SLASHRES,(omod1 * .5));
			target:addMod(MOD_IMPACTRES,(omod2 * .5));
			target:addMod(MOD_HTHRES,(omod3 * .5));
	end
	if(effect:getPower() == 525) then
			target:addMod(MOD_PIERCERES,(omod * .535));
			target:addMod(MOD_SLASHRES,(omod1 * .535));
			target:addMod(MOD_IMPACTRES,(omod2 * .535));
			target:addMod(MOD_HTHRES,(omod3 * .535));
	end
	if(effect:getPower() == 550) then
			target:addMod(MOD_PIERCERES,(omod * .57));
			target:addMod(MOD_SLASHRES,(omod1 * .57));
			target:addMod(MOD_IMPACTRES,(omod2 * .57));
			target:addMod(MOD_HTHRES,(omod3 * .57));
	end
	if(effect:getPower() == 575) then
			target:addMod(MOD_PIERCERES,(omod * .605));
			target:addMod(MOD_SLASHRES,(omod1 * .605));
			target:addMod(MOD_IMPACTRES,(omod2 * .605));
			target:addMod(MOD_HTHRES,(omod3 * .605));
	end
	if(effect:getPower() == 600) then
			target:addMod(MOD_PIERCERES,(omod * .703));
			target:addMod(MOD_SLASHRES,(omod1 * .703));
			target:addMod(MOD_IMPACTRES,(omod2 * .703));
			target:addMod(MOD_HTHRES,(omod3 * .703));
	end
	if(effect:getPower() == 625) then
			target:addMod(MOD_PIERCERES,(omod * .738));
			target:addMod(MOD_SLASHRES,(omod1 * .738));
			target:addMod(MOD_IMPACTRES,(omod2 * .738));
			target:addMod(MOD_HTHRES,(omod3 * .738));
	end
	if(effect:getPower() == 650) then
			target:addMod(MOD_PIERCERES,(omod * .773));
			target:addMod(MOD_SLASHRES,(omod1 * .773));
			target:addMod(MOD_IMPACTRES,(omod2 * .773));
			target:addMod(MOD_HTHRES,(omod3 * .773));
	end
	if(effect:getPower() == 675) then
			target:addMod(MOD_PIERCERES,(omod * .808));
			target:addMod(MOD_SLASHRES,(omod1 * .808));
			target:addMod(MOD_IMPACTRES,(omod2 * .808));
			target:addMod(MOD_HTHRES,(omod3 * .808));
	end
	if(effect:getPower() == 700) then
			target:addMod(MOD_PIERCERES,(omod * .969));
			target:addMod(MOD_SLASHRES,(omod1 * .969));
			target:addMod(MOD_IMPACTRES,(omod2 * .969));
			target:addMod(MOD_HTHRES,(omod3 * .969));
	end
	if(effect:getPower() == 725 or effect:getPower() == 750 or effect:getPower() == 775) then
			target:addMod(MOD_PIERCERES,omod);
			target:addMod(MOD_SLASHRES,omod1);
			target:addMod(MOD_IMPACTRES,omod2);
			target:addMod(MOD_HTHRES,omod3);
	end
	if(effect:getPower() == 825 or effect:getPower() == 850 or effect:getPower() == 875) then
			target:addMod(MOD_PIERCERES,omod);
			target:addMod(MOD_SLASHRES,omod1);
			target:addMod(MOD_IMPACTRES,omod2);
			target:addMod(MOD_HTHRES,omod3);
	end
	if(effect:getPower() == 925 or effect:getPower() == 950 or effect:getPower() == 975) then
			target:addMod(MOD_PIERCERES,omod);
			target:addMod(MOD_SLASHRES,omod1);
			target:addMod(MOD_IMPACTRES,omod2);
			target:addMod(MOD_HTHRES,omod3);
	end
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
	if(effect:getPower()>100 and effect:getPower()<500)then
		target:delMod(MOD_DEFP,-effect:getPower());
	end
	if(effect:getPower()<100) then
		target:delMod(MOD_DEFP,-effect:getPower());
	end
	if(effect:getPower() == 500) then -- Banish I
		target:delMod(MOD_PIERCERES,(omod * .5));
		target:delMod(MOD_SLASHRES,(omod1 * .5));
		target:delMod(MOD_IMPACTRES,(omod2 * .5));
		target:delMod(MOD_HTHRES,(omod3 * .5));
	end
	if(effect:getPower() == 525) then -- Banish I with Ring or Mitts /+1
		target:delMod(MOD_PIERCERES,(omod * .535));
		target:delMod(MOD_SLASHRES,(omod1 * .535));
		target:delMod(MOD_IMPACTRES,(omod2 * .535));
		target:delMod(MOD_HTHRES,(omod3 * .535));
	end
	if(effect:getPower() == 550) then -- Banish I with Ring and Mitts /+1
		target:delMod(MOD_PIERCERES,(omod * .57));
		target:delMod(MOD_SLASHRES,(omod1 * .57));
		target:delMod(MOD_IMPACTRES,(omod2 * .57));
		target:delMod(MOD_HTHRES,(omod3 * .57));
	end
	if(effect:getPower() == 575) then -- Banish I with Ring and Mitts +2
		target:delMod(MOD_PIERCERES,(omod * .605));
		target:delMod(MOD_SLASHRES,(omod1 * .605));
		target:delMod(MOD_IMPACTRES,(omod2 * .605));
		target:delMod(MOD_HTHRES,(omod3 * .605));
	end
	if(effect:getPower() == 600) then -- Banish II
		target:delMod(MOD_PIERCERES,(omod * .703));
		target:delMod(MOD_SLASHRES,(omod1 * .703));
		target:delMod(MOD_IMPACTRES,(omod2 * .703));
		target:delMod(MOD_HTHRES,(omod3 * .703));
	end
	if(effect:getPower() == 625) then -- Banish II with Ring or Mitts /+1
		target:delMod(MOD_PIERCERES,(omod * .738));
		target:delMod(MOD_SLASHRES,(omod1 * .738));
		target:delMod(MOD_IMPACTRES,(omod2 * .738));
		target:delMod(MOD_HTHRES,(omod3 * .738));
	end
	if(effect:getPower() == 650) then -- Banish II with Ring and Mitts /+1
		target:delMod(MOD_PIERCERES,(omod * .773));
		target:delMod(MOD_SLASHRES,(omod1 * .773));
		target:delMod(MOD_IMPACTRES,(omod2 * .773));
		target:delMod(MOD_HTHRES,(omod3 * .773));
	end
	if(effect:getPower() == 675) then -- Banish II with Ring and Mitts /+1
		target:delMod(MOD_PIERCERES,(omod * .805));
		target:delMod(MOD_SLASHRES,(omod1 * .805));
		target:delMod(MOD_IMPACTRES,(omod2 * .805));
		target:delMod(MOD_HTHRES,(omod3 * .805));
	end
	if(effect:getPower() == 700) then -- Banish II
		target:delMod(MOD_PIERCERES,(omod * .969));
		target:delMod(MOD_SLASHRES,(omod1 * .969));
		target:delMod(MOD_IMPACTRES,(omod2 * .969));
		target:delMod(MOD_HTHRES,(omod3 * .969));
	end
	if(effect:getPower() == 725 or effect:getPower() == 750 or effect:getPower() == 775) then -- Banish III with Ring and Mitts
		target:delMod(MOD_PIERCERES,omod);
		target:delMod(MOD_SLASHRES,omod1);
		target:delMod(MOD_IMPACTRES,omod2);
		target:delMod(MOD_HTHRES,omod3);
	end
	if(effect:getPower() == 825 or effect:getPower() == 850 or effect:getPower() == 875) then -- Banish IV with Ring and Mitts
		target:delMod(MOD_PIERCERES,omod);
		target:delMod(MOD_SLASHRES,omod1);
		target:delMod(MOD_IMPACTRES,omod2);
		target:delMod(MOD_HTHRES,omod3);
	end
	if(effect:getPower() == 925 or effect:getPower() == 950 or effect:getPower() == 975) then -- Banish V with Ring and Mitts
		target:delMod(MOD_PIERCERES,omod);
		target:delMod(MOD_SLASHRES,omod1);
		target:delMod(MOD_IMPACTRES,omod2);
		target:delMod(MOD_HTHRES,omod3);
	end
end;