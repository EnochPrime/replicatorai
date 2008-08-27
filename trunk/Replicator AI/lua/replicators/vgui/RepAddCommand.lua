/*
	RepAddCommand for GarrysMod10
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

PANEL = {};
--[[
MC_Options_Commands = {
	"Select Command...",
	"Attack",
	"Disassemble",
	"Follow",
	"Gather",
	"Wander"
};

MC_Options_Variables = {
	"Select Variable...",
	"Materials",
	"Max Materials",
	"NPC",
	"Number",
	"Player",
	"Replicator Amount",
	"Replicator Limit"
};
]]
MC_Options_Commands = {
	"Select Command...",
	"Disassemble",
	"Gather",
	"Wander"
};

MC_Options_Variables = {
	"Select Variable..."
};

--############### Initializes the panel and buttons
function PANEL:Init()
	self.VGUI = {
		BT_Submit = vgui.Create("DButton",self);
		BT_Cancel = vgui.Create("DButton",self);
		
		PL_Constructor = vgui.Create("DPanelList",self);
		MC_Commands = vgui.Create("DMultiChoice",self);
		P_PlayerList = vgui.Create("RepPlayerList",self);
		P_NPCList = vgui.Create("RepNPCList",self);
	};
	
	self:SetSize(210,400);
	self:SetMinimumSize(210,210);
	self:SetPos(100,100);
	
	self.VGUI.BT_Submit:SetText("Submit");
	self.VGUI.BT_Submit:SetPos(40,175);
	self.VGUI.BT_Submit.DoClick =
		function()
			local parent = self:GetParent();
			local mc_items = self.VGUI.PL_Constructor:GetItems();
			local p_items = parent.VGUI.PL_Code:GetItems();
			self:SetVisible(false);
			parent.VGUI.PL_Code:RemoveItem(p_items[#p_items]);
			local button = vgui.Create("DButton",parent);
			button.values = {};
			for i=1,#mc_items,2 do
				table.insert(button.values,mc_items[i].TextEntry:GetValue());
			end
			label = "self:Rep_AI_" .. button.values[1] .. "(";
			for i=2,#button.values do
				label = label .. button.values[i];
				if (i+1 <= #button.values) then
					label = label .. ",";
				end
			end
			label = label .. ");";
			button:SetText(label);
			button.text = label;
			button.frame = self;
			button.DoClick = 
				function()
					button.frame:SetVisible(true);
				end
			parent.VGUI.PL_Code:AddItem(button);
			parent.VGUI.PL_Code:AddItem(parent:CreateAddButton());
		end
		
	self.VGUI.BT_Cancel:SetText("Cancel");
	self.VGUI.BT_Cancel:SetPos(110,175);
	self.VGUI.BT_Cancel.DoClick =
		function()
			self:SetVisible(false);
		end

	self.VGUI.MC_Commands:SetEditable(false);
	for _,v in pairs(MC_Options_Commands) do
		self.VGUI.MC_Commands:AddChoice(v);
	end
	self.VGUI.MC_Commands:ChooseOptionID(1);
		
	self.VGUI.PL_Constructor:SetPos(10,35);
	self.VGUI.PL_Constructor:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.PL_Constructor:SetSpacing(5);
	self.VGUI.PL_Constructor:EnableHorizontal(false);
	self.VGUI.PL_Constructor:EnableVerticalScrollbar(true);
	self.VGUI.PL_Constructor:AddItem(self.VGUI.MC_Commands);
end

--############### Keeps buttons in the correct position when resizing
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Constructor:SetSize(w-20,h-75);
	self.VGUI.BT_Submit:SetPos((w/2)-65,h-35);
	self.VGUI.BT_Cancel:SetPos((w/2)+5,h-35);
end

--############### Draws the panel
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Add Command","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### think
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
	local CI = self.VGUI.PL_Constructor:GetItems();
	if (#CI == 1) then
		mc_text = CI[1].TextEntry:GetValue();
		if (mc_text == "Select Command...") then
			--self.VGUI.PL_Constructor:Clear();
			--self.VGUI.PL_Constructor:AddItem(self:AddCommandsMC());
		elseif (mc_text == "Attack") then
			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to attack.");
			self.VGUI.PL_Constructor:AddItem(text);
			self.VGUI.PL_Constructor:AddItem(self:AddVariableMC());
		elseif (mc_text == "Follow") then
			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to follow.");
			self.VGUI.PL_Constructor:AddItem(text);
			self.VGUI.PL_Constructor:AddItem(self:AddVariableMC());
		elseif (mc_text == "Gather") then
--[[			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to gather.");
			self.VGUI.PL_Constructor:AddItem(text);
			self.VGUI.PL_Constructor:AddItem(self:AddVariableMC());		]]
		end
	end
	for i=3,#CI,2 do
		local text = CI[i].TextEntry:GetValue();
		if (text == "Player") then
			if (not self.VGUI.P_PlayerList:IsVisible()) then
				self.VGUI.P_PlayerList:SetVisible(true);
			end
		elseif (text == "NPC") then
			if (not self.VGUI.P_NPCList:IsVisible()) then
				self.VGUI.P_NPCList:SetVisible(true);
			end
		--elseif (text == "Number") then
		end
	end
end

--############### creates a multichoice with commands
function PANEL:AddCommandsMC()
	local item = vgui.Create("DMultiChoice",self);
	item:SetEditable(false);
	for _,v in pairs(MC_Options_Commands) do
		item:AddChoice(v);
	end
	item:ChooseOptionID(1);
	return item;
end

--############### creates a multichoice with variables
function PANEL:AddVariableMC()
	local item = vgui.Create("DMultiChoice",self);
	item:SetEditable(false);
	for _,v in pairs(MC_Options_Variables) do
		item:AddChoice(v);
	end
	item:ChooseOptionID(1);
	return item;
end

vgui.Register("RepAddCommand",PANEL,"Frame");
