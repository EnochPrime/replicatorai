-- follows specific ent and performs specific action when less than 50 units away, when b = true
-- return true	following
-- return false	no ent to follow
function ENT:Rep_AI_Retreat(e,radius)
	e = self:ExtractEnt(e);
	radius = radius or 250;
	if (e == nil or not ValidEntity(e)) then
		self.tasks = false;
	else
		local pos = self:GetPos();
		local epos = e:GetPos();
		self:SetTarget(e);
		local s = ai_schedule.New();
		s:EngTask("TASK_GET_PATH_TO_TARGET",0);
		s:EngTask("TASK_FACE_PATH",0);
		s:EngTask("TASK_RUN_PATH",0);
		local d = (pos-epos):Length();
		if (d <= radius) then
			self:StartSchedule(s);
			self.tasks = true;
		else
			self.tasks = false;
		end
	end
	return self.tasks;
end

local Data = {
	"Choose what to retreat from.",
	"ents",
	"Set how close we can get.",
	"numbers",
};

Replicators.RegisterVGUI("Retreat",Data);