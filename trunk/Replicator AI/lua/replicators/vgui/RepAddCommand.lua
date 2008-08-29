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
MC_Options = {
	Commands = {
		"Select Command...",
		"Attack",
		"Disassemble",
		"Follow",
		"Gather",
		"Wander"
	},
	Variables_Ents = {
		"Select Variable...",
		"Attackable",
--		"Entities"
	},
	Variables_Numbers = {
		"Select Variable...",
--		"Materials",
--		"Max Materials",
		"Number"--,
--		"Replicator Amount",
--		"Replicator Limit"
	}
};

--############### Initializes the panel and buttons
function PANEL:Init()
	self.VGUI = {
		BT_Submit = vgui.Create("DButton",self);
		BT_Cancel = vgui.Create("DButton",self);
		
		PL_Constructor = vgui.Create("DPanelList",self);
		MC_Commands = vgui.Create("DMultiChoice",self);
		P_AttackableList = vgui.Create("RepAttackableList",self);
		P_NumberPanel = vgui.Create("RepNumberPanel",self);
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
			local index = 0;
			self:SetVisible(false);
			for k,v in pairs(p_items) do
				if (v.Frame == self) then
					index = k;
				end
			end
			local button = vgui.Create("DButton",parent);
			button.Values = {};
			for i=1,#mc_items,2 do
				if (mc_items[i].TextEntry:GetValue() ~= MC_Options.Variables_Ents[1]) then
					table.insert(button.Values,mc_items[i].TextEntry:GetValue());
				end
			end
			label = "self:Rep_AI_" .. button.Values[1] .. "(";
			for i=2,#button.Values do
				label = label..button.Values[i];
				if (i+1 <= #button.Values) then
					label = label..",";
				end
			end
			label = label..");";
			button:SetText(label);
			button.Text = label;
			button.Frame = self;
			button.DoClick = 
				function()
					button.Frame:SetVisible(true);
				end
			parent:Replace(button,index);
		end
		
	self.VGUI.BT_Cancel:SetText("Cancel");
	self.VGUI.BT_Cancel:SetPos(110,175);
	self.VGUI.BT_Cancel.DoClick =
		function()
			self:SetVisible(false);
		end

	self.VGUI.MC_Commands:SetEditable(false);
	for _,v in pairs(MC_Options.Commands) do
		self.VGUI.MC_Commands:AddChoice(v);
	end
	self.VGUI.MC_Commands:ChooseOptionID(1);
	self.VGUI.MC_Commands.OnSelect =
		function()
			self:UpdateGUI();
		end	
		
	self.VGUI.PL_Constructor:SetPos(10,35);
	self.VGUI.PL_Constructor:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.PL_Constructor:SetSpacing(5);
	self.VGUI.PL_Constructor:EnableHorizontal(false);
	self.VGUI.PL_Constructor:EnableVerticalScrollbar(true);
	self.VGUI.PL_Constructor:AddItem(self.VGUI.MC_Commands);
end

--############### Keeps buttons in the correct position when resizing @JDM12989
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Constructor:SetSize(w-20,h-75);
	self.VGUI.BT_Submit:SetPos((w/2)-65,h-35);
	self.VGUI.BT_Cancel:SetPos((w/2)+5,h-35);
end

--############### Draws the panel @JDM12989
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Add Command","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### Updates display when drop down changed @JDM12989
function PANEL:UpdateGUI()
	local CI = self.VGUI.PL_Constructor:GetItems();
	local mc_text = CI[1].TextEntry:GetValue();
	self.VGUI.PL_Constructor:Clear();
	-- rebuild gui with labels and other drop downs
	self.VGUI.PL_Constructor:AddItem(CI[1]);
	if (mc_text == "Attack") then
		text = vgui.Create("DLabel",self);
		text:SetText("Choose what to attack.");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Ents());
	elseif (mc_text == "Follow") then
		text = vgui.Create("DLabel",self);
		text:SetText("Choose what to follow.");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Ents());
	elseif (mc_text == "Gather") then
		text = vgui.Create("DLabel",self);
		text:SetText("Set amount to gather. (Optional)");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Numbers());
	elseif (mc_text == "Wander") then
		text = vgui.Create("DLabel",self);
		text:SetText("Set wander radius. (Optional)");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Numbers());
		text = vgui.Create("DLabel",self);
		text:SetText("Set minimum wait time. (Optional)");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Numbers());
		text = vgui.Create("DLabel",self);
		text:SetText("Set maximum wait time. (Optional)");
		self.VGUI.PL_Constructor:AddItem(text);
		self.VGUI.PL_Constructor:AddItem(self:AddVariableMC_Numbers());
	else
		return;
	end
end

--############### think @JDM12989
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

--############### creates a multichoice with commands
function PANEL:AddCommandsMC()
	local item = vgui.Create("DMultiChoice",self);
	item:SetEditable(false);
	for _,v in pairs(MC_Options.Commands) do
		item:AddChoice(v);
	end
	item:ChooseOptionID(1);
	return item;
end

--############### creates a multichoice with entity variables
function PANEL:AddVariableMC_Ents()
	local item = vgui.Create("DMultiChoice",self);
	item:SetEditable(false);
	for _,v in pairs(MC_Options.Variables_Ents) do
		item:AddChoice(v);
	end
	item:ChooseOptionID(1);
	item.OnSelect =
		function()
			-- open other guis when needed
			local CI = self.VGUI.PL_Constructor:GetItems();
			for i=3,#CI,2 do
				local text = CI[i].TextEntry:GetValue();
				if (text == "Attackable") then
					if (not self.VGUI.P_AttackableList:IsVisible()) then
						self.VGUI.P_AttackableList:SetVisible(true);
					end
				end
			end
		end
	return item;
end

--############### creates a multichoice with number variables
function PANEL:AddVariableMC_Numbers()
	local item = vgui.Create("DMultiChoice",self);
	item:SetEditable(false);
	for _,v in pairs(MC_Options.Variables_Numbers) do
		item:AddChoice(v);
	end
	item:ChooseOptionID(1);
	item.OnSelect =
		function()
			-- open other guis when needed
			local CI = self.VGUI.PL_Constructor:GetItems();
			for i=3,#CI,2 do
				local text = CI[i].TextEntry:GetValue();
				if (text == "Number") then
					if (not self.VGUI.P_NumberPanel:IsVisible()) then
						self.VGUI.P_NumberPanel:SetVisible(true);
						self.VGUI.P_NumberPanel.Index = i;
					end
				end
			end
		end
	return item;
end

vgui.Register("RepAddCommand",PANEL,"Frame");
