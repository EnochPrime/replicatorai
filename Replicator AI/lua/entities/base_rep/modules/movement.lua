include("activities.lua");

local schdMove = ai_schedule.New();

function ENT:Move(e)
	schdMove = ai_schedule.New();
	local pos = self:GetPos();
	if (e ~= nil) then
		self:SetTarget(e);
		schdMove:EngTask("TASK_GET_PATH_TO_TARGET",0);
		schdMove:EngTask("TASK_FACE_PATH",0);
		schdMove:EngTask("TASK_MOVE_TO_TARGET_RANGE",0);	-- don't know how to set range
		if (e and ValidEntity(e)) then
			local d = (pos - e:GetPos()):Length();
			local t = util.QuickTrace(pos,e:GetPos(),self);
			local t_d = (pos - t.HitPos):Length();
			t_d = 1000;
			if ((d <= 50 or t_d <= 50) and ValidEntity(e)) then
				self:Activity(e);
			end
		end
	else
		pos.x = math.random(-1000,1000);
		pos.y = math.random(-1000,1000);
		self:SetLastPosition(pos);
		schdMove:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
		schdMove:EngTask("TASK_FACE_PATH",0);
		schdMove:EngTask("TASK_RUN_PATH",0);
		schdMove:EngTask("TASK_WAIT_FOR_MOVEMENT",0);
		schdMove:EngTask("TASK_WAIT",math.random(0,5));
	end
	return schdMove;
end

function ENT:Find(c)
	local e = nil;
	local color = {};
	local d = 5000;
	local dis = 0;
	local pos = self:GetPos();
	for _,v in pairs(ents.FindInSphere(pos,d)) do
		color = {v:GetColor()};
		if (v:GetClass() == c and color[4] == 255) then
			dis = (pos - v:GetPos()):Length();
			if (dis < d) then
				d = dis;
				e = v;
			end
		end
	end
	return e;
end
