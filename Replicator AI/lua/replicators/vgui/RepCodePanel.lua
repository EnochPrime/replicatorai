/*
	RepCodePanel for GarrysMod10
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
PANEL.AI = "";
PANEL.CODE = "";
PANEL.ENT = nil;

--############### Initializes the panel @JDM12989
function PANEL:Init()
	self.VGUI = {
		BT_Upload = vgui.Create("DButton",self);
		BT_Refresh = vgui.Create("DButton",self);
		BT_Clear = vgui.Create("DButton",self);
		BT_Load = vgui.Create("DButton",self);
		
		PL_Code = vgui.Create("DPanelList",self);
		P_LoadFile = vgui.Create("RepLoadFile",self);
	};
	
	self:SetSize(460,210);
	self:SetMinimumSize(460,210);
	self:Center();
	
	self.VGUI.BT_Upload:SetText("Upload");
	self.VGUI.BT_Upload:SetPos(400,35);
	self.VGUI.BT_Upload.DoClick =
		function()
			self.CODE = self:CompileCode("test");
			LocalPlayer():ConCommand("Rep_Upload");
		end
		
	self.VGUI.BT_Refresh:SetText("Refresh");
	self.VGUI.BT_Refresh:SetPos(400,60);
	self.VGUI.BT_Refresh.DoClick =
		function()
			self:SetCode(self.AI);
		end
	
	self.VGUI.BT_Clear:SetText("Clear");
	self.VGUI.BT_Clear:SetPos(400,85);
	self.VGUI.BT_Clear.DoClick =
		function()
			self.VGUI.PL_Code:Clear();
			self.VGUI.PL_Code:AddItem(self:CreateAddButton());
		end
		
	self.VGUI.BT_Load:SetText("Load");
	self.VGUI.BT_Load:SetPos(400,135);
	self.VGUI.BT_Load.DoClick =
		function()
			self.VGUI.P_LoadFile = vgui.Create("RepLoadFile",self);
			self.VGUI.P_LoadFile:SetVisible(true);
		end
	
	self.VGUI.PL_Code:SetPos(10,35);
	self.VGUI.PL_Code:SetSize(self:GetWide()-90,self:GetTall()-45);
	self.VGUI.PL_Code:SetSpacing(5);
	self.VGUI.PL_Code:EnableHorizontal(false);
	self.VGUI.PL_Code:EnableVerticalScrollbar(true);
end

--############### Keeps buttons in the correct position when resizing @JDM12989
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Code:SetSize(w-90,h-45);
	self.VGUI.BT_Upload:SetPos(w-75,35);
	self.VGUI.BT_Refresh:SetPos(w-75,60);
	self.VGUI.BT_Clear:SetPos(w-75,85);
	self.VGUI.BT_Load:SetPos(w-75,135);
end

--############### Draws the panel @JDM12989
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Replicator Controller","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### Thinking... @JDM12989
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
	local CI = self.VGUI.PL_Code:GetItems();
	if (#CI > 0 and not CI[#CI].IsAdd) then
		self.VGUI.PL_Code:AddItem(self:CreateAddButton());
	end
end

--############### Sets the replicator that was selected @JDM12989
function PANEL:SetEnt(e)
	self.ENT = e;
end

--############### Replaces item at index i with item @JDM12989
function PANEL:Replace(item,i)
	local CI = self.VGUI.PL_Code:GetItems();
	self.VGUI.PL_Code:Clear();
	for k,v in pairs(CI) do
		if (k == i) then
			self.VGUI.PL_Code:AddItem(item);
		else
			self.VGUI.PL_Code:AddItem(v);
		end
	end
end

--############### Create the add command button for the code panel @JDM12989
function PANEL:CreateAddButton()
	BT_AddCommand = vgui.Create("DButton",self);
	BT_AddCommand:SetText("Add Command");
	BT_AddCommand.IsAdd = true;
	BT_AddCommand.Frame = vgui.Create("RepAddCommand",self);
	BT_AddCommand.DoClick =
		function()
			BT_AddCommand.Frame:SetVisible(true);
		end
	return BT_AddCommand;
end

--############### Gets all the button text and puts it into a text document @JDM12989
function PANEL:CompileCode(fn)
	local code = "";
	local code_items = self.VGUI.PL_Code:GetItems();
	for k,v in pairs(code_items) do
		if (k ~= #code_items) then
			code = code..v.Text;
			-- add a ';' to only lines that need them
			if (string.find(code,";") == nil) then
				code = code..";";
			end
			-- append a new line
			if (k < #code_items - 1) then
				code = code..string.char(10);
			end
		end
	end
	file.Write("replicators/"..fn..".txt",code);
	return s;
end

--############### Sets up the gui with the specified code @JDM12989
function PANEL:SetCode(fn)
	if (not fn or fn == nil) then return end;
	self.VGUI.PL_Code:Clear();
	local file = file.Read("replicators/"..fn..".txt");
	local lines = string.Explode(string.char(10),file);
	for _,v in pairs(lines) do
		-- create button for the panel
		local button = vgui.Create("DButton",self);
		button:SetText(v);
		button.Text = v;
		button.Frame = vgui.Create("RepAddCommand",self);
		button.DoClick =
			function()
				button.Frame:SetVisible(true);
			end
		button.Values = {};

		-- get the function name and all the args and insert into the table button.Values
		local v_temp = v;
		local i;
		v_temp = string.Replace(v_temp,"self:Rep_AI_","");
		i = string.find(v_temp,"(",1,true);
		table.insert(button.Values,string.sub(v_temp,1,i-1));
		v_temp = string.sub(v_temp,i+1);
		i = string.find(v_temp,"}",1,true);
		if (i ~= nil) then
			table.insert(button.Values,string.sub(v_temp,1,i));
			v_temp = string.Replace(v_temp,i+1);
		end
		repeat
			i = string.find(v_temp,",",1,true);
			if (i ~= nil) then
				table.insert(button.Values,string.sub(v_temp,1,i-1));
				v_temp = string.sub(v_temp,i+1);
			end
		until (i == nil);
		i = string.find(v_temp,")",1,true);
		if (i ~= nil and v_temp ~= ");") then
			table.insert(button.Values,string.sub(v_temp,1,i-1));
		end
		
		MsgN(table.ToString(button.Values,"values",false));
		
		--[[	move this into the actually frame	button.Frame:Setup(button.Values);
		local f_pl = button.frame.VGUI.PL_Constructor;
		-- add other multi-choice boxes
		if (button.values[1] == "Attack") then
			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to attack.");
			f_pl:AddItem(text);
			f_pl:AddItem(button.frame:AddVariableMC());
		elseif (button.values[1] == "Follow") then
			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to follow.");
			f_pl:AddItem(text);
			f_pl:AddItem(button.frame:AddVariableMC());
		elseif (button.values[1] == "Gather") then
			text = vgui.Create("DLabel",self);
			text:SetText("Choose what to follow.");
			f_pl:AddItem(text);
			f_pl:AddItem(button.frame:AddVariableMC());
		end
		
		f_items = f_pl:GetItems();
		
		for i=3,#f_items,2 do
			-- set up multichoice
			local text = button.values[i];
			f_items[i]:SetText(button.values[i]);
		end
		]]
		self.VGUI.PL_Code:AddItem(button);
	end
	self.AI = fn;
end

vgui.Register("RepCodePanel",PANEL,"Frame");

--############### Brings up the panel @JDM12989
usermessage.Hook("Show_RepCodePanel",
	function(data)
		if (not Window) then
			Window = vgui.Create("RepCodePanel");
		end
		ent = data:ReadEntity();
		ai = data:ReadString();
		Window:SetEnt(ent);
		Window:SetCode(ai);
		Window:SetVisible(true);
	end
);
