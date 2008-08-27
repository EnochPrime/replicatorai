/*
	RepNumberPanel for GarrysMod10
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
		TE_Number = vgui.Create("DTextEntry",self);
		
		BT_Submit = vgui.Create("DButton",self);
		BT_1 = vgui.Create("DButton",self);
		BT_2 = vgui.Create("DButton",self);
		BT_3 = vgui.Create("DButton",self);
		BT_4 = vgui.Create("DButton",self);
		BT_5 = vgui.Create("DButton",self);
		BT_6 = vgui.Create("DButton",self);
		BT_7 = vgui.Create("DButton",self);
		BT_8 = vgui.Create("DButton",self);
		BT_9 = vgui.Create("DButton",self);
		BT_0 = vgui.Create("DButton",self);
		BT_Decimal = vgui.Create("DButton",self);
		BT_Fraction = vgui.Create("DButton",self);
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
			self.VGUI.TE_Number:GetValue();
		end
		
	self.VGUI.PL_Players:SetPos(10,35);
	self.VGUI.PL_Players:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.PL_Players:SetSpacing(5);
	self.VGUI.PL_Players:EnableHorizontal(false);
	self.VGUI.PL_Players:EnableVerticalScrollbar(true);
	
	self:SetUpPlayerList()
end

--############### Keeps buttons in the correct position when resizing
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Players:SetSize(w-20,h-75);
	self.VGUI.BT_Submit:SetPos((w/2)-30,h-35);
end

--############### Draws the panel
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Player List","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

function PANEL:SetUpPlayerList()
	players = player.GetAll();
	for _,v in pairs(players) do
		CB_Player = vgui.Create("DCheckBoxLabel",self);
		CB_Player:SetText(v:GetName());
		CB_Player.text = v:GetName();
		self.VGUI.PL_Players:AddItem(CB_Player);
	end
end

vgui.Register("RepPlayerList",PANEL,"Frame");