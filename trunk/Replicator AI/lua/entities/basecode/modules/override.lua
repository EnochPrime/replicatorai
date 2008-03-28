function ENT:SelectSchedule()
	if (#rep_list < 10 and #rep_list ~= self.limit) then
		self:StartSchedule(self:Move(self:Find("prop_physics")));
end
