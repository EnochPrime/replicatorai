-- make rep wander about a 1000 unit radius with random 0-5 second wait
function ENT:Rep_AI_Wander()	
	local pos = self:GetPos();
	pos.x = math.random(-1000,1000);
	pos.y = math.random(-1000,1000);
	self:SetLastPosition(pos);
	local s = ai_schedule.New();
	s:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
	s:EngTask("TASK_FACE_PATH",0);
	s:EngTask("TASK_RUN_PATH",0);
	s:EngTask("TASK_WAIT_FOR_MOVEMENT",0);
	s:EngTask("TASK_WAIT",math.random(0,5));
	self:StartSchedule(s);
end

-- make rep move to pos and wait for give time (both = rand)
function ENT:Rep_AI_MoveToPos(pos,t_min,t_max)
	local wait = t_min or 0;
	if (t_max ~= nil) then
		wait = math.random(t_min,t_max);
	end
	
	self:SetLastPosition(pos);
	local s = ai_schedule.New();
	s:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
	s:EngTask("TASK_FACE_PATH",0);
	s:EngTask("TASK_RUN_PATH",0);
	s:EngTask("TASK_WAIT_FOR_MOVEMENT",0);
	s:EngTask("TASK_WAIT",wait);
	self:StartSchedule(s);
end

--########## NOT TESTED BELOW HERE ##########--
-- make rep follow given target (l = loop?)
function ENT:Rep_AI_Follow(e,l)
	if (e == nil or not ValidEntity(e)) then
		self:Rep_AI_Wander();
	else
		self:SetLastPosition(e:GetPos());
		local s = ai_schedule.New();
		s:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
		s:EngTask("TASK_FACE_PATH",0);
		s:EngTask("TASK_RUN_PATH",0);
		if (l) then
			s:AddTask(s);
		end
		self:StartSchedule(s);
	end
end

function ENT:Rep_AI_Attack(e)
	self:StartSchedule(self:Move());
	e:TakeDamage(5,self);
end

function ENT:Rep_AI_AttackNPC()
	local trgt = ents.FindInSphere(self:GetPos(),1000);
	local e = nil;
	for _,v in pairs(trgt) do
		if (v:isNPC()) then
			e = v;
		end
	end
	if (e ~= nil) then
		self:Rep_AI_Attack(e);
	else
		self:Rep_AI_Wander();
	end
end

function ENT:Rep_AI_AttackPlayer()
	local trgt = ents.FindInSphere(self:GetPos(),1000);
	local e = nil;
	for _,v in pairs(trgt) do
		if (v:isPlayer()) then
			e = v;
		end
	end
	if (e ~= nil) then
		self:Rep_AI_Attack(e);
	else
		self:Rep_AI_Wander();
	end
end

function ENT:Rep_AI_Replicate()

end
