/*
	RepControlPanel for GarrysMod10
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
PANEL.Ent = nil;
PANEL.Dir = "replicators/";
PANEL.Fn = "___.txt";
PANEL.Server = false;
MC_Options = {
	Commands = {
		"Select Command...",
	},
	Variables_Ents = {
		"Select Variable...",
		"Attackable",
		"Entities"
	},
	Variables_Numbers = {
		"Select Variable...",
		"self:GetResource("..string.char(34).."material_metal"..string.char(34)..")",
		"Number",
		"Replicators.Limit"
	}
};

--############### Initializes the panel @JDM12989
function PANEL:Init()	
	self.VGUI = {
		BT_Save = vgui.Create("DButton",self);
		BT_Load = vgui.Create("DButton",self);
		BT_Refresh = vgui.Create("DButton",self);
		BT_Clear = vgui.Create("DButton",self);
		PL_Code = vgui.Create("DPanelList",self);
		P_File = vgui.Create("RepFile",self);
		P_AttackableList = vgui.Create("RepAttackableList",self);
		P_NumberPanel = vgui.Create("RepNumberPanel",self);
	};
	
	self:SetSize(270,210);
	self:SetMinimumSize(270,210);
	self:Center();
	
	self.VGUI.BT_Save:SetText("Save");
	self.VGUI.BT_Save:SetPos(210,35);
	self.VGUI.BT_Save.DoClick =
		function()
			self.VGUI.P_File:SetVisible(true);
			self.VGUI.P_File:SetType("Save");
			self.VGUI.P_File:SetUpFileList(self.VGUI.P_File.Dir);
		end
		
	self.VGUI.BT_Load:SetText("Load");
	self.VGUI.BT_Load:SetPos(210,60);
	self.VGUI.BT_Load.DoClick =
		function()
			self.VGUI.P_File:SetVisible(true);
			self.VGUI.P_File:SetType("Load");
			self.VGUI.P_File:SetUpFileList(self.VGUI.P_File.Dir);
		end
		
	self.VGUI.BT_Refresh:SetText("Refresh");
	self.VGUI.BT_Refresh:SetPos(210,85);
	self.VGUI.BT_Refresh.DoClick =
		function()
			self:LoadFile(self.Server,self.Dir,self.Fn);
		end
	
	self.VGUI.BT_Clear:SetText("Clear");
	self.VGUI.BT_Clear:SetPos(210,110);
	self.VGUI.BT_Clear.DoClick =
		function()
			self.VGUI.PL_Code:Clear();
		end
	
	self.VGUI.PL_Code:SetPos(10,35);
	self.VGUI.PL_Code:SetSize(self:GetWide()-90,self:GetTall()-45);
	self.VGUI.PL_Code:SetSpacing(5);
	self.VGUI.PL_Code:EnableHorizontal(false);
	self.VGUI.PL_Code:EnableVerticalScrollbar(true);
	
	self:InitCommands();
end

--############### Sets up all registered commands @JDM12989
function PANEL:InitCommands()
	for k,v in pairs(Replicators.VGUI) do
		if (not table.HasValue(MC_Options.Commands,k)) then
			table.insert(MC_Options.Commands,2,k);
		end
	end
end

--############### Keeps buttons in the correct position when resizing @JDM12989
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Code:SetSize(w-90,h-45);
	self.VGUI.BT_Save:SetPos(w-75,35);
	self.VGUI.BT_Load:SetPos(w-75,60);
	self.VGUI.BT_Refresh:SetPos(w-75,85);
	self.VGUI.BT_Clear:SetPos(w-75,110);
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
	if (not self.Delay) then
		local items = self.VGUI.PL_Code:GetItems();
		if (#items == 0 or items[#items].Text ~= "Select Command...") then
			self:CreateCommand();
		end
	end
end

--############### Creates a command based on params and adds to panel @JDM12989
function PANEL:CreateCommand(com,args)
	com = com or "Select Command...";
	args = args or {};
	
	local PL_Command = vgui.Create("DPanelList",self);
	PL_Command:SetAutoSize(true);
	
	local MC_Commands = vgui.Create("DMultiChoice",PL_Command);
	MC_Commands:SetEditable(false);
	for _,v in pairs(MC_Options.Commands) do
		MC_Commands:AddChoice(v);
	end
	if (com) then
		MC_Commands.TextEntry:SetText(com);
	end
	MC_Commands.OnSelect =
		function()
			self:RefreshCommand(PL_Command);
		end
		
	PL_Command:AddItem(MC_Commands);
	local mc_text = MC_Commands.TextEntry:GetValue();
	for k,v in pairs(Replicators.VGUI) do
		if (mc_text == k) then
			for j,u in pairs(v) do
				if (j % 2 == 0) then
					local mc = self:CreateVariableMC(u);
					local text = args[j/2] or "Select Variable...";
					mc.TextEntry:SetText(text)
					PL_Command:AddItem(mc);
				else
					label = vgui.Create("DLabel",self);
					label:SetText(u);
					PL_Command:AddItem(label);
				end
			end
		end
	end
	
	local CC_Command = vgui.Create("DCollapsibleCategory",self);
	CC_Command:SetExpanded(0);
	CC_Command:SetLabel(com);
	CC_Command.Text = com;
	CC_Command:SetContents(PL_Command);
	CC_Command.Contents = PL_Command
	self.VGUI.PL_Code:AddItem(CC_Command);
end

--############### Refresh command panel when changed @JDM12989
function PANEL:RefreshCommand(PL)
	local mc_command = PL:GetItems()[1];
	local mc_text = mc_command.TextEntry:GetValue();
	PL:Clear();
	PL:AddItem(mc_command);
	-- setup labels & mc's based from registered vgui's
	for k,v in pairs(Replicators.VGUI) do
		if (mc_text == k) then
			for j,u in pairs(v) do
				if (j % 2 == 0) then
					local mc = self:CreateVariableMC(u,PL);
					local text = "Select Variable...";
					mc.TextEntry:SetText(text)
					PL:AddItem(mc);
				else
					label = vgui.Create("DLabel",self);
					label:SetText(u);
					PL:AddItem(label);
				end
			end
		end
	end
	-- updates title & closes/opens so it expands to correct size
	for _,v in pairs(self.VGUI.PL_Code:GetItems()) do
		if (v.Contents == PL) then
			v:SetLabel(mc_text);
			v.Text = mc_text;
			v:Toggle();
			v:Toggle();
		end
	end
end

--############### Creates a variable multichoice @JDM12989
function PANEL:CreateVariableMC(k,PL)
	local item = vgui.Create("DMultiChoice",PL);
	item:SetEditable(false);
	if (k == "ents") then
		for _,v in pairs(MC_Options.Variables_Ents) do
			item:AddChoice(v);
		end
	elseif (k == "numbers") then
		for _,v in pairs(MC_Options.Variables_Numbers) do
			item:AddChoice(v);
		end
	end
	item:ChooseOptionID(1);
	item.OnSelect =
		function(MultiChoice)
			-- open other guis when needed
			local text = MultiChoice.TextEntry:GetValue();
			if (text == "Attackable") then
				if (not self.VGUI.P_AttackableList:IsVisible()) then
					self.VGUI.P_AttackableList:SetVisible(true);
					self.VGUI.P_AttackableList:SetUpList();
					self.VGUI.P_AttackableList.MC = MultiChoice;
				end
			elseif (text == "Number") then
				if (not self.VGUI.P_NumberPanel:IsVisible()) then
					self.VGUI.P_NumberPanel:SetVisible(true);
					self.VGUI.P_NumberPanel.MC = MultiChoice;
				end
			end
		end
	return item;
end

--############### Initiates loading a file @JDM12989
function PANEL:LoadFile(server,dir,fn)
	if (not fn) then return end;
	self.Delay = true;		-- stops think func from creating a new select command
	self.VGUI.PL_Code:Clear();
	if (server) then
		LocalPlayer().RepControlPanel = self;
		RunConsoleCommand("RepReturnString","CODE",dir..fn);
	else
		self:LoadCode(file.Read(dir..fn));
	end
	
	self.Server = server;
	self.Dir = dir;
	self.Fn = fn;
	self.Ent:SetCode(dir..fn);
end

--############### Gets code from server to load @JDM12989
local function RepGetServerData(data)
	local P = LocalPlayer().RepControlPanel;
	local dir = data:ReadString();
	local code = data:ReadString();
	
	P:LoadCode(code);
end
usermessage.Hook("RepSendLoadData",RepGetServerData);

--############### Loads file to panel @JDM12989
function PANEL:LoadCode(code)
	if (not code or code == "") then self.Delay = false return end;
	local lines = string.Explode(string.char(10),code);
	if (not lines or #lines == 0) then self.Delay = false return end;
	for _,v in pairs(lines) do
		local com = "";
		local args = {};
		
		-- get the function name and all the args and insert into the table button.Values
		local v_temp = v;
		local i;
		v_temp = string.Replace(v_temp,"self:Rep_AI_","");
		i = string.find(v_temp,"(",1,true);
		if (i == nil) then self.Delay = false return end;
		com = string.sub(v_temp,1,i-1);
		v_temp = string.sub(v_temp,i+1);
		i = string.find(v_temp,"}",1,true);
		if (i ~= nil) then
			table.insert(args,string.sub(v_temp,1,i));
			v_temp = string.Replace(v_temp,i+1);
		end
		repeat
			i = string.find(v_temp,",",1,true);
			if (i ~= nil) then
				table.insert(args,string.sub(v_temp,1,i-1));
				v_temp = string.sub(v_temp,i+1);
			end
		until (i == nil);
		i = string.find(v_temp,")",1,true);
		if (i ~= nil and v_temp ~= ");") then
			table.insert(args,string.sub(v_temp,1,i-1));
		end
		
		self:CreateCommand(com,args);
	end
	self.Delay = false;
end

--############### Saves a file @JDM12989
function PANEL:SaveFile(server,dir,fn)
	if (not fn) then return end;
	if (string.find(fn,".txt") == nil) then
		fn = fn..".txt";
	end
	local s = self:CompileCode();
	if (server) then
		RunConsoleCommand("RepSaveFile",dir,fn,s);
	else
		file.Write(dir..fn,s);
	end
	
	self.Server = server;
	self.Dir = dir;
	self.Fn = fn;
	self.Ent:SetCode(dir..fn);
end

--############### Compiles code from gui into string @JDM12989
function PANEL:CompileCode()
	local s = "";
	local commands = self.VGUI.PL_Code:GetItems();
	for k,v in pairs(commands) do
		local args = v.Contents:GetItems();
		for i=1,#args,2 do
			local text = args[i].TextEntry:GetValue();
			if (i == 1) then
				if (text ~= "Select Command...") then
					s = s.."self:Rep_AI_"..text.."(";
				end
			else
				if (text ~= "Select Variable...") then
					s = s..text..",";
				end
				if (i == #args) then
					if (string.Right(s,1) == ",") then
						s = string.sub(s,1,string.len(s)-1);
					end
					s = s..");";
				end
			end
		end
		if (k < #commands-1) then
			s = s..string.char(10);
		end
	end
	return s;
end

vgui.Register("RepControlPanel",PANEL,"Frame");

--############### Brings up the panel @JDM12989
usermessage.Hook("Show_RepCtrl",
	function(data)
		if (not Window) then
			Window = vgui.Create("RepControlPanel");
		end
		local e = data:ReadEntity();
		local s = data:ReadString();
		Window.Ent = e;
		Window:SetVisible(true);
		if (s ~= "") then
			local dir = string.GetPathFromFilename(s);
			local fn = string.Replace(s,dir,"");
			Window:LoadFile(not SinglePlayer(),dir,fn);
		end
	end
);
