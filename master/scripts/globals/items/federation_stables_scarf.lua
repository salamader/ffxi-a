-------------------------------------------	ID: 13181--	Item: Federation Stables Scarf--  	Enchantment: "Teleport" (Windurst Chocobo Stables)-----------------------------------------require("scripts/globals/teleports");require("scripts/globals/settings");require("scripts/globals/status");------------------------------------------- OnItemCheck-----------------------------------------function onItemCheck(target)	result = 0;	if (target:isZoneVisited(241) == false) then        result = 56;    endreturn result;end;------------------------------------------- OnItemUse-----------------------------------------function onItemUse(target)	federationStablesScarf(target);end;