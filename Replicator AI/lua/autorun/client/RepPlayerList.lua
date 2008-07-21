PANEL = {}

function PANEL:Init()
	self.VGUI = {
		BT_Submit = vgui.Create("DButton",self);
		
		PL_Players = vgui.Create("DPanelList",self);
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
			s_items = self.VGUI.PL_Players:GetItems();
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