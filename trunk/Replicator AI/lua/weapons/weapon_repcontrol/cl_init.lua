include("shared.lua");
-- Inventory Icon
if(file.Exists("../materials/weapons/arg_inventory.vmt")) then
	SWEP.WepSelectIcon = surface.GetTextureID("weapons/arg_inventory");
end

language.Add("Battery_ammo","Naquadah");
language.Add("weapon_repcontrol","Replicator Control PC");