PANEL = {};
CODE = "";

--############### Initializes the panel
function PANEL:Init()
	self.VGUI = {
		BT_Upload = vgui.Create("DButton",self);
		BT_Refresh = vgui.Create("DButton",self);
		BT_Clear = vgui.Create("DButton",self);
		BT_Load = vgui.Create("DButton",self);
		
		PL_Code = vgui.Create("DPanelList",self);
		P_AddCommand = vgui.Create("RepAddCommand",self);
		P_LoadFile = vgui.Create("RepLoadFile",self);
	};
	
	self:SetSize(460,210);
	self:SetMinimumSize(460,210);
	self:Center();
	
	self.VGUI.BT_Upload:SetText("Upload");
	self.VGUI.BT_Upload:SetPos(400,35);
	self.VGUI.BT_Upload.DoClick =
		function()
			CODE = self:CompileCode("test");
			--self:SetCode(self:CompileCode());
			--LocalPlayer():ConCommand("Rep_Upload");
		end
		
	self.VGUI.BT_Refresh:SetText("Refresh");
	self.VGUI.BT_Refresh:SetPos(400,60);
	self.VGUI.BT_Refresh.DoClick =
		function()
			--self:SetCode(Code);
		end
	
	self.VGUI.BT_Clear:SetText("Clear");
	self.VGUI.BT_Clear:SetPos(400,85);
	self.VGUI.BT_Clear.DoClick =
		function()
			self.VGUI.PL_Code:Clear();
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

--############### Keeps buttons in the correct position when resizing
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.PL_Code:SetSize(w-90,h-45);
	self.VGUI.BT_Upload:SetPos(w-75,35);
	self.VGUI.BT_Refresh:SetPos(w-75,60);
	self.VGUI.BT_Clear:SetPos(w-75,85);
	self.VGUI.BT_Load:SetPos(w-75,135);
end

--############### Draws the panel
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Replicator Controller","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### Adds an add button if there are no items or last item is not an add button
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
	local CI = self.VGUI.PL_Code:GetItems();
	if (#CI == 0 or not CI[#CI].IsAdd) then
		self.VGUI.PL_Code:AddItem(self:CreateAddButton());
	end
end

--############### create the add command button for the code panel
function PANEL:CreateAddButton()
	BT_AddCommand = vgui.Create("DButton",self);
	BT_AddCommand:SetText("Add Command");
	BT_AddCommand.IsAdd = true;
	BT_AddCommand.DoClick =
		function()
			self.VGUI.P_AddCommand = vgui.Create("RepAddCommand",self);
			self.VGUI.P_AddCommand:SetVisible(true);
		end
		
	return BT_AddCommand;
end

--############### gets all the button text and puts it into a text document
function PANEL:CompileCode(s)
	local code = "";
	local code_items = self.VGUI.PL_Code:GetItems();
	for k,v in pairs(code_items) do
		if (k ~= #code_items) then
			code = code .. v.text;
		end
	end
	file.Write("replicators/" .. s .. ".txt",code);
end

--############### sets up the gui with the specified code
function PANEL:SetCode(fn)
	self.VGUI.PL_Code:Clear();
	local s = file.Read("replicators/"..fn);
	local lines = string.Explode(";",s);
	for k,v in pairs(lines) do
		if (k == #lines) then return end;
		local button = vgui.Create("DButton",self);
		button:SetText(v);
		button.text = v;
		button.frame = vgui.Create("RepAddCommand",self);
		button.DoClick =
			function()
				button.frame:SetVisible(true);
			end
		button.values = {};
		string.Replace(v,"self:Rep_AI_","");
		button.values[1] = string.Left(v,string.find(v,"(")-1);
		self.VGUI.PL_Code:AddItem(button);
	end
end

vgui.Register("RepCodePanel",PANEL,"Frame");

--############### Brings up the panel
usermessage.Hook("Show_RepCodePanel",
	function(data)
		if (not Window) then
			Window = vgui.Create("RepCodePanel");
		end
		Window:SetVisible(true);
	end
);
