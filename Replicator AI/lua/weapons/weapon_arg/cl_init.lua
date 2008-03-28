include("shared.lua");
-- Inventory Icon
if(file.Exists("../materials/weapons/hand_inventory.vmt")) then
	SWEP.WepSelectIcon = surface.GetTextureID("weapons/hand_inventory");
end
-- Kill Icon
if(file.Exists("../materials/weapons/hand_killicon.vmt")) then
	killicon.Add("weapon_hand_device","weapons/hand_killicon",Color(255,255,255));
end
language.Add("Battery_ammo","Naquadah");
language.Add("weapon_hand_device","Hand Device");

--################### Tell a player how to use this @aVoN
function SWEP:DrawHUD()
	local mode = "Push";
	local int = self.Weapon:GetNWInt("Mode",1);
	if(int == 1) then
		mode = "1.57 THz"; -- these are arbitrary numbers
	elseif(int == 2) then
		mode = "2.03 THz";
	elseif(int == 3) then
		mode = "2.78 THz";
	elseif(int == 4) then
		mode = "3.19 THz";
	end
	draw.WordBox(8,ScrW()-188,ScrH()-120,"Primary: "..mode,"Default",Color(0,0,0,80),Color(255,220,0,220));
end
