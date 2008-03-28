include('act.lua');
local schdFollow = ai_schedule.New();

function ENT:Move(ent)
	schdFollow = ai_schedule.New();
	local pos = self:GetPos();
	if (ent ~= nil) then
		self:SetTarget(ent);
		schdFollow:EngTask("TASK_GET_PATH_TO_TARGET",0);
		schdFollow:EngTask("TASK_FACE_PATH",0);
		schdFollow:EngTask("TASK_MOVE_TO_TARGET_RANGE",0);	-- don't know how to set range
		if (ent and ent:IsValid()) then
			local dist = (pos - ent:GetPos()):Length();
			local trace = StarGate.Trace:New(pos,(pos-ent:GetPos()):Normalize()*50,self);
			if ((dist <= 50 or trace.Entity == ent) and ent:IsValid()) then
				self:Activity(ent);
			end
		end
	else
		pos.x = math.random(-1000,1000);
		pos.y = math.random(-1000,1000);
		self:SetLastPosition(pos);
		schdFollow:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
		schdFollow:EngTask("TASK_FACE_PATH",0);
		schdFollow:EngTask("TASK_RUN_PATH",0);
		schdFollow:EngTask("TASK_WAIT_FOR_MOVEMENT",0);
		schdFollow:EngTask("TASK_WAIT",math.random(0,5));
	end
	return schdFollow;
end

function ENT:Find(class)
	local c = nil;
	local color = {};
	local d = 10000;
	local dist = 0;
	local pos = self:GetPos();
	local t = ents.FindInSphere(pos,d);
	if (t and #t > 0) then
		for _,v in pairs(t) do
			color = {v:GetColor()};
			if (v:GetClass() == class and color[4] == 255) then
				dist = (pos - v:GetPos()):Length();
				if (dist < d) then
					d = dist;
					c = v;
				end
			end
		end
	end
	return c;
end
