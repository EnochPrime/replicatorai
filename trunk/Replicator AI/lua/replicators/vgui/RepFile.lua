/*
	RepFile for GarrysMod10
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
PANEL.Type = "Custom";
PANEL.Dir = "replicators/";
PANEL.Dir_S = "replicators/";
PANEL.Dir_C = "replicators/";
PANEL.Server = false;
PANEL.Protected = {
	"rep_n.txt",
	"rep_q.txt",
	"rep_h.txt",
};

--############### Initializes the panel @JDM12989
function PANEL:Init()
	self.VGUI = {
		MC_ServerClient = vgui.Create("DMultiChoice",self);
		IBT_Refresh = vgui.Create("DImageButton",self);
		IBT_UpDir = vgui.Create("DImageButton",self);
		IBT_Delete = vgui.Create("DImageButton",self);
		BT_Custom = vgui.Create("DButton",self);
		BT_Cancel = vgui.Create("DButton",self);
		LV_Files = vgui.Create("DListView",self);
		TE_File = vgui.Create("DTextEntry",self);
	};

	self:SetSize(295,225);
	self:SetMinimumSize(295,225);
	self:SetPos(100,100);
	
	-- server/client select
	self.VGUI.MC_ServerClient:SetPos(10,35);
	self.VGUI.MC_ServerClient:SetEditable(false);
	self.VGUI.MC_ServerClient:AddChoice("Client");
	if (not SinglePlayer()) then
		self.VGUI.MC_ServerClient:AddChoice("Server");
	end
	self.VGUI.MC_ServerClient:ChooseOptionID(1);
	self.VGUI.MC_ServerClient.OnSelect = 
		function()
			self.Server = self.VGUI.MC_ServerClient.TextEntry:GetValue() == "Server";
			if (self.Server) then
				self:SetUpFileList(self.Dir_S);
			else
				self:SetUpFileList(self.Dir_C);
			end
		end
	
	-- refreshes window
	self.VGUI.IBT_Refresh:SetSize(16,16);
	self.VGUI.IBT_Refresh:SetPos(230,35);
	self.VGUI.IBT_Refresh:SetImage("gui/silkicons/arrow_refresh");
	self.VGUI.IBT_Refresh:SetToolTip("Refresh window.");
	self.VGUI.IBT_Refresh.DoClick =
		function()
			self:SetUpFileList(self.Dir);
		end
	
	-- move up one folder
	self.VGUI.IBT_UpDir:SetSize(16,16);
	self.VGUI.IBT_UpDir:SetPos(250,35);
	self.VGUI.IBT_UpDir:SetImage("gui/silkicons/folder_go");
	self.VGUI.IBT_UpDir:SetToolTip("Go up one folder.");
	self.VGUI.IBT_UpDir.DoClick = 
		function()
			if (self.Dir == "replicators/") then return end;
			local new_dir = "";
			local dirs = string.Explode("/",self.Dir);
			for k,v in pairs(dirs) do
				if (k >= #dirs-1) then break end;
				new_dir = new_dir..v.."/";
			end
			self.Dir = new_dir;
			if (self.Server) then
				self.Dir_S = self.Dir;
			else
				self.Dir_C = self.Dir;
			end
			self:SetUpFileList(self.Dir);
		end
	
	-- delete selected file
	self.VGUI.IBT_Delete:SetSize(16,16);
	self.VGUI.IBT_Delete:SetPos(270,35);
	self.VGUI.IBT_Delete:SetImage("gui/silkicons/check_off");
	self.VGUI.IBT_Delete:SetToolTip("Delete selected file!");
	self.VGUI.IBT_Delete.DoClick =
		function()
			local text = self.VGUI.TE_File:GetValue();
			if (table.HasValue(self.Protected,text)) then
				MsgN(text.." is protected.");
			else
				file.Delete(self.Dir..self.VGUI.TE_File:GetValue());
				self:SetUpFileList(self.Dir);
			end
		end
	
	-- load/save file
	self.VGUI.BT_Custom:SetText("Custom");
	self.VGUI.BT_Custom:SetPos(150,190);
	self.VGUI.BT_Custom.DoClick = 
		function()
			self:SetVisible(false);
			local parent = self:GetParent();
			local fn = self.VGUI.TE_File:GetValue();
			if (self.Type == "Load") then
				parent:LoadFile(self.Server,self.Dir,fn);
			elseif (self.Type == "Save") then
				if (table.HasValue(self.Protected,fn)) then
					MsgN(fn.." unable to make file with that name.");
				else
					parent:SaveFile(self.Server,self.Dir,fn);
				end
			end
		end
		
	-- cancel
	self.VGUI.BT_Cancel:SetText("Cancel");
	self.VGUI.BT_Cancel:SetPos(220,190);
	self.VGUI.BT_Cancel.DoClick =
		function()
			self:SetVisible(false);
		end
		
	-- list of all files in current dir
	self.VGUI.LV_Files:SetPos(10,60);
	self.VGUI.LV_Files:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.LV_Files:SetMultiSelect(false);
	self.VGUI.LV_Files:AddColumn("Name");
	self.VGUI.LV_Files:AddColumn("Date Modified");
	self.VGUI.LV_Files.OnRowSelected =
		function(ListView,Row)
			local selected = ListView:GetSelectedLine()
			local text = ListView:GetLine(selected):GetColumnText(1);
			self.VGUI.TE_File:SetText(text);
		end
	self.VGUI.LV_Files.DoDoubleClick =
		function(ListView,Row)
			local selected = ListView:GetSelectedLine()
			local fn = ListView:GetLine(selected):GetColumnText(1);
			if (string.find(fn,".txt") ~= nil) then
				self:SetVisible(false);
				local parent = self:GetParent();
				if (self.Type == "Load") then
					parent:LoadFile(self.Server,self.Dir,fn);
				elseif (self.Type == "Save") then
					if (table.HasValue(self.Protected,fn)) then
						MsgN(fn.." unable to make file with that name.");
					else
						parent:SaveFile(self.Server,self.Dir,fn);
					end
				end
			else
				fn = string.Trim(fn);
				self:SetUpFileList(self.Dir..fn.."/");
				self.VGUI.TE_File:SetText("");
			end
		end
	
	RunConsoleCommand("RepInitUserDir");
	self:SetUpFileList(self.Dir..LocalPlayer():GetName().."/");
	
	self.VGUI.TE_File:SetPos(10,190);
	self.VGUI.TE_File:SetSize(135,self.VGUI.TE_File:GetTall());
end

--############### Keeps buttons in the correct position when resizing @JDM12989
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.IBT_Refresh:SetPos(w-65,35);
	self.VGUI.IBT_UpDir:SetPos(w-45,35);
	self.VGUI.IBT_Delete:SetPos(w-25,35);
	self.VGUI.LV_Files:SetSize(w-20,h-100);
	self.VGUI.BT_Custom:SetPos(w-150,h-35);
	self.VGUI.BT_Cancel:SetPos(w-75,h-35);
	self.VGUI.TE_File:SetPos(10,h-35);
	self.VGUI.TE_File:SetSize(w-165,self.VGUI.TE_File:GetTall());
end

--############### Draws the panel @JDM12989
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	local text = self.Type.." File";
	draw.DrawText(text,"ScoreboardText",30,8,Color(255,255,255,255),0);
	draw.DrawText(self.Dir,"DefaultSmall",80,40,Color(255,255,255,255),0);
	return true;
end

--############### Thinking... @JDM12989
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

--############### Changes type to string @JDM12989
function PANEL:SetType(s)
	self.Type = s;
	self.VGUI.BT_Custom:SetText(self.Type);
end

--############### Initialize list setup / adds ai files (client) to list view @JDM12989
function PANEL:SetUpFileList(dir)
	self.VGUI.LV_Files:Clear();
	local s = "";
	local files = {};
	if(self.Server) then
		LocalPlayer().RepFile = self;
		RunConsoleCommand("RepReturnString","DIR",dir);
	else
		files = file.Find(dir.."*");
	
		if (not files) then return end;
		for k,v in pairs(files) do
			local text = v;
			if (string.find(text,".txt") == nil) then
				text = " "..text;	-- if it's not a txt add the " " to beginning for sorting purposes
			end
			self.VGUI.LV_Files:AddLine(text,os.date("%c",file.Time(dir..v)));
		end
		self.VGUI.LV_Files:SortByColumn(1);
		self.Dir = dir;
		self.Dir_C = self.Dir;
	end
end

--############### Adds all ai files (server) to list view @JDM12989
local function RepGetServerData(data)
	local P = LocalPlayer().RepFile;
	local dir = data:ReadString();
	local s = data:ReadString();
	
	if (not s or s == "") then return end;
	files = string.Explode(",",s);
	table.remove(files,#files);
	
	if (not files) then return end;
	for k,v in pairs(files) do
		local text = v;
		if (string.find(text,".txt") == nil) then
			text = " "..text;	-- if it's not a txt add the " " to beginning for sorting purposes
		end
		P.VGUI.LV_Files:AddLine(text,os.date("%c",file.Time(dir..v)));
	end
	P.VGUI.LV_Files:SortByColumn(1);
	P.Dir = dir;
	P.Dir_S = P.Dir;
end
usermessage.Hook("RepSendDirData",RepGetServerData);

vgui.Register("RepFile",PANEL,"Frame");