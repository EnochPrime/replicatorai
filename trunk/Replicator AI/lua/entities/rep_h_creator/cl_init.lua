include("shared.lua");

PANEL = {};
PANEL.Ent = nil;

function PANEL:Init()
	self.VGUI = {
		BT_Submit = vgui.Create("DButton",self);
		MC_Gender = vgui.Create("DMultiChoice",self);
		MC_Person = vgui.Create("DMultiChoice",self);
		MC_Outfit = vgui.Create("DMultiChoice",self);
		IM_Model = vgui.Create("DImage",self);
	};
	self.Gender = "";
	self.Person = "";
	self.Outfit = "";
	
	self:SetSize(260,330);
	self:SetMinimumSize(260,330);
	self:Center();
	
	self.VGUI.BT_Submit:SetText("Start Creation Process");
	self.VGUI.BT_Submit:SetPos(10,300);
	self.VGUI.BT_Submit:SetSize(230,20);
	self.VGUI.BT_Submit.DoClick =
		function()
			self:SetVisible(false);
			RunConsoleCommand("Rep_Create_Start","models/gman.mdl");
		end

	self.VGUI.MC_Gender:SetPos(148,30);
	self.VGUI.MC_Gender:SetSize(100,20);
	self.VGUI.MC_Gender:SetEditable(false);
	self.VGUI.MC_Gender:AddChoice("Select Gender...");
	self.VGUI.MC_Gender:AddChoice("Female");
	self.VGUI.MC_Gender:AddChoice("Male");
	self.VGUI.MC_Gender:ChooseOptionID(1);
	self.VGUI.MC_Gender.OnSelect = 
		function(MultiChoice)
			local text = MultiChoice.TextEntry:GetValue();
			self.Gender = text;
		end
	
	self.VGUI.MC_Person:SetPos(148,60);
	self.VGUI.MC_Person:SetSize(100,20);
	self.VGUI.MC_Person:SetEditable(false);
	self.VGUI.MC_Person:AddChoice("Select Person...");
	self.VGUI.MC_Person:AddChoice("Person 01");
	self.VGUI.MC_Person:AddChoice("Person 02");
	self.VGUI.MC_Person:AddChoice("Person 03");
	self.VGUI.MC_Person:AddChoice("Person 04");
	self.VGUI.MC_Person:AddChoice("Person 05");
	self.VGUI.MC_Person:AddChoice("Person 06");
	self.VGUI.MC_Person:AddChoice("Person 07");
	self.VGUI.MC_Person:AddChoice("Person 08");
	self.VGUI.MC_Person:AddChoice("Person 09");
	self.VGUI.MC_Person:ChooseOptionID(1);
	self.VGUI.MC_Person.OnSelect = 
		function(MultiChoice)
			local text = MultiChoice.TextEntry:GetValue();
			-- remove person to just get the number.
			self.Person = text;
		end
		
	self.VGUI.MC_Outfit:SetPos(148,90);
	self.VGUI.MC_Outfit:SetSize(100,20);
	self.VGUI.MC_Outfit:SetEditable(false);
	self.VGUI.MC_Outfit:AddChoice("Select Outfit...");
	self.VGUI.MC_Outfit:AddChoice("Citizen");
	self.VGUI.MC_Outfit:AddChoice("Medic");
	self.VGUI.MC_Outfit:AddChoice("Rebel");
	self.VGUI.MC_Outfit:ChooseOptionID(1);
	self.VGUI.MC_Outfit.OnSelect = 
		function(MultiChoice)
			local text = MultiChoice.TextEntry:GetValue();
			self.Outfit = text;
		end
		
	self.VGUI.IM_Model:SetSize(128,256);
	self.VGUI.IM_Model:SetPos(10,30);
	self.VGUI.IM_Model:SetImage("JDM12989/Rep_Creator/female_01_01");
end

--############### Keeps buttons in the correct position when resizing @JDM12989
function PANEL:PerformLayout()
	local w,h = self:GetSize();
end

--############### Draws the panel @JDM12989
function PANEL:Paint()
	draw.RoundedBox(10,0,0,self:GetWide(),self:GetTall(),Color(16,16,16,255));
	draw.DrawText("Custom Replicator","ScoreboardText",30,8,Color(255,255,255,255),0);
	return true;
end

--############### Thinking... @JDM12989
function PANEL:Think()
	if (not Window or not Window:IsVisible()) then return end;
end

function PANEL:SetEnt(e)
	self.Ent = e;
end

vgui.Register("RepCustomHuman",PANEL,"Frame");

--############### Brings up the panel @JDM12989
usermessage.Hook("Show_RepHumanCtrl",
	function(data)
		if (not Window) then
			Window = vgui.Create("RepCustomHuman");
		end
		local e = data:ReadEntity();
		Window:SetEnt(e);
		Window:SetVisible(true);
	end
);
