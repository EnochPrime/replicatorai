include('shared.lua')

function ENT:Draw()
	self.Alpha = self.Alpha or 255;
	if(self.Entity:GetNWBool("fade_out")) then
		self.Alpha = math.Clamp(self.Alpha-FrameTime()*80,0,255);
		self.Entity:SetColor(255,255,255,self.Alpha);
	end
	self.Entity:DrawModel();
end
