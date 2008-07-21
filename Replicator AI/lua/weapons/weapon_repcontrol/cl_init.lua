include("shared.lua");
-- Inventory Icon
if(file.Exists("../materials/weapons/arg_inventory.vmt")) then
	SWEP.WepSelectIcon = surface.GetTextureID("weapons/arg_inventory");
end

language.Add("Battery_ammo","Naquadah");
language.Add("weapon_hand_device","Hand Device");

PANEL = {};

function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
	local CP = self.VGUI.LS_Code:GetItems();
	if (#CP == 0) then return end;
	if (CP[#CP].TextEntry:GetValue() ~= MC_Options[1]) then
		local item = vgui.Create("DMultiChoice");
		for _,v in pairs(MC_Options) do
			item:AddChoice(v);
		end
		item:ChooseOptionID(1);
		item:SetEditable(false);
		self.VGUI.LS_Code:AddItem(item);
	elseif (#CP > 1 and CP[#CP-1].TextEntry:GetValue() == MC_Options[1]) then
		self.VGUI.LS_Code:RemoveItem(CP[#CP]);
	else
		return;
	end
end

function PANEL:SetCode(s)
	self.VGUI.LS_Code:Clear();
	if (s == "" or s == nil) then
		local item = vgui.Create("DMultiChoice");
		for _,v in pairs(MC_Options) do
			item:AddChoice(v);
		end
		item:ChooseOptionID(1);
		item:SetEditable(false);
		self.VGUI.LS_Code:AddItem(item);
	else
		local str = file.Read("replicators/"..s..".txt");
		local sep = string.Explode(";",str);
		for _,v in pairs(sep) do
			local item = vgui.Create("DMultiChoice");
			for _,w in pairs(MC_Options) do
				item:AddChoice(w);
			end
			item:ChooseOptionID(self:CodeCheck(string.Trim(v)));
			item:SetEditable(false);
			self.VGUI.LS_Code:AddItem(item);
		end
	end
	Code = s;
end

function PANEL:CodeCheck(s)
	for k,v in pairs(MC_Options) do
		if (string.find(s,v) ~= nil) then
			return k;
		end
	end
	return 1;
end

function PANEL:CompileCode()
	local code = "";
	local txt = "";
	local items = self.VGUI.LS_Code:GetItems();
	for i=1,#items-1 do
		txt = items[i].TextEntry:GetValue();
		for i=3,7 do
			if (txt == MC_Options[i]) then
				txt = "self:Rep_AI_" .. txt .. "()";
			end
		end
		if (txt == "if") then
			txt = "if (";
		elseif (txt == "then") then
			txt = ") then";
		elseif (txt == "Materials") then
			txt = "self.materials";
		elseif (txt == "Max Materials") then
			txt = "self.max_materials";
		elseif (txt == "Replicators Amount") then
			txt = "#Replicators.Reps";
		end
		code = code .. txt .. ";";
	end
	file.Write("replicators/test.txt",code);
	return "test";
end