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
		local pos = self:GetPos();
		local epos = e:GetPos();
		self:SetLastPosition(epos);
		local s = ai_schedule.New();
		s:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
		s:EngTask("TASK_FACE_PATH",0);
		s:EngTask("TASK_RUN_PATH",0);
		if (l) then
			s:AddTask(s);
		end
		self:StartSchedule(s);
		
		return (pos-epos):Length();
	end
end

function ENT:Rep_AI_Attack(e)
	local d = ENT:Rep_AI_Follow(e);
	if (d <= 50) then
		e:TakeDamage(5,self);
	end
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

-- make rep attack any near by player (s = name of specific player)
function ENT:Rep_AI_AttackPlayer(s)
	local e = nil;
	if (s == nil) then
		local trgt = ents.FindInSphere(self:GetPos(),1000);
		for _,v in pairs(trgt) do
			if (v:isPlayer()) then
				e = v;
			end
		end
	else
		--e = ents.GetPlayerByName(s);
	end
	if (e and ValidEntity(e)) then
		self:Rep_AI_Attack(e);
	else
		self:Rep_AI_Wander();
	end
end

function ENT:Rep_AI_Replicate()

end

-- make rep fall apart
function ENT:Rep_AI_Disassemble()
	--fall apart
	Replicators.Remove(self);
	self:Remove();
	-- MAKE THEM WORK THE CORRECT WAY!!!
	local str = "models/JDM12989/Replicators/"..self:GetClass().."/Gibs/";
	for i=1,#file.Find("../"..str.."*.mdl") do
		local gib = ents.Create("block");
		gib:SetPos(self:GetPos());
		gib:SetAngles(self:GetAngles());
		gib:Spawn();
		gib:SetModel(str..i..".mdl");
		gib:PhysicsInit(SOLID_VPHYSICS);
		gib:GetPhysicsObject():Wake();
		gib.dead = true;
		gib:OnRemove();
	end
end
