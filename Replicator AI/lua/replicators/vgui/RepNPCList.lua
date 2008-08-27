/*
	RepNPCList for GarrysMod10
	Copyright (C) 2008  JDM12989

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

PANEL = {}

function PANEL:Init()
	self.VGUI = {
		BT_Submit = vgui.Create("DButton",self);
		
		PL_NPCs = vgui.Create("DPanelList",self);
	};
	
	self:SetSize(110,200);
	self:SetMinimumSize(110,200);
	self:SetPos(250,100);
	
	self.VGUI.BT_Submit:SetText("Submit");
	self.VGUI.BT_Submit:SetPos(20,175);
	self.VGUI.BT_Submit.DoClick =
		function()
			self:SetVisible(false);
			parent = self:GetParent();
			p_items = parent.VGUI.PL_Constructor:GetItems();
			s_items = self.VGUI.PL_NPCs:GetItems();
			text = "{";
			for k,v in pairs(s_items) do
				if (v:GetChecked()) then
					text = text .. v.text;
				end
				if (k+1 <= #s_items) then
					text = text .. ",";
				end
			end
			text = text .. "}";
			p_items[#p_items]:SetText(text);
		end
		
	self.VGUI.PL_NPCs:SetPos(10,35);
	self.VGUI.PL_NPCs:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.PL_NPCs:SetSpacing(5);
	self.VGUI.PL_NPCs:EnableHorizontal(false);
	self.VGUI.PL_NPCs:EnableVerticalScrollbar(true);
	
	self:SetUpNPCList()
end

--############### Keeps buttons in the correct position when resizing
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_NPCs:SetSize(w-20,h-75);
	self.VGUI.BT_Submit:SetPos((w/2)-30,h-35);
end

--############### Draws the panel
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("NPC List","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

function PANEL:SetUpNPCList()
	npcs = ents.GetAll();
	for _,v in pairs(npcs) do
		if (ValidEntity(v) and v:IsNPC()) then
			CB_NPC = vgui.Create("DCheckBoxLabel",self);
			CB_NPC:SetText(v:GetClass()..": "..v:EntIndex());
			CB_NPC.text = v:GetClass()..": "..v:EntIndex();
			self.VGUI.PL_NPCs:AddItem(CB_NPC);
		end
	end
end

vgui.Register("RepNPCList",PANEL,"Frame");