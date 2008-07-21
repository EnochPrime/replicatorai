PANEL = {};

function PANEL:Init()
	self.VGUI = {
		BT_Load = vgui.Create("DButton",self);
		BT_Cancel = vgui.Create("DButton",self);
		
		LV_Files = vgui.Create("DListView",self);
		TE_File = vgui.Create("DTextEntry",self);
	};

	self:SetSize(300,200);
	self:SetMinimumSize(300,200);
	self:SetPos(100,100);
	
	self.VGUI.BT_Load:SetText("Load");
	self.VGUI.BT_Load:SetPos(150,165);
	self.VGUI.BT_Load.DoClick = 
		function()
			self:SetVisible(false);
			local parent = self:GetParent();
			parent:SetCode(self.VGUI.TE_File:GetValue());
		end
		
	self.VGUI.BT_Cancel:SetText("Cancel");
	self.VGUI.BT_Cancel:SetPos(225,165);
	self.VGUI.BT_Cancel.DoClick =
		function()
			self:SetVisible(false);
		end
		
	self.VGUI.LV_Files:SetPos(10,35);
	self.VGUI.LV_Files:SetSize(self:GetWide()-20,self:GetTall()-75);
	self.VGUI.LV_Files:SetMultiSelect(false);
	self.VGUI.LV_Files:AddColumn("Name");
	self.VGUI.LV_Files.OnRowSelected =
		function(ListView,Row)
			local selected = ListView:GetSelectedLine()
			local text = ListView:GetLine(selected):GetColumnText(1);
			self.VGUI.TE_File:SetText(text);
		end
	self.VGUI.LV_Files.DoDoubleClick =
		function(ListView,Row)
			local selected = ListView:GetSelectedLine()
			local text = ListView:GetLine(selected):GetColumnText(1);
			self:SetVisible(false);
			local parent = self:GetParent();
			parent:SetCode(text);
		end
	
	self:SetUpFileList();
	
	self.VGUI.TE_File:SetPos(10,165);
	self.VGUI.TE_File:SetSize(135,self.VGUI.TE_File:GetTall());
	
end

--############### Keeps buttons in the correct position when resizing
function PANEL:PerformLayout()
	local w,h = self:GetSize();
	self.VGUI.LV_Files:SetSize(w-20,h-75);
	self.VGUI.BT_Load:SetPos(w-150,h-35);
	self.VGUI.BT_Cancel:SetPos(w-75,h-35);
	self.VGUI.TE_File:SetPos(10,h-35);
	self.VGUI.TE_File:SetSize(w-165,self.VGUI.TE_File:GetTall());
end

--############### Draws the panel
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Load File","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### think
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

function PANEL:SetUpFileList()
	for _,v in pairs(file.Find("replicators/*.txt")) do
		self.VGUI.LV_Files:AddLine(v);
	end
end

vgui.Register("RepLoadFile",PANEL,"Frame");