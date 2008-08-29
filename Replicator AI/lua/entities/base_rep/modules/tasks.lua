-- make rep attack specific enemy
-- return true	ent to attack
-- return false	no ent to attack
function ENT:Rep_AI_Attack(e)
	-- type check so it can be passed a table of player names to attack
	if (type(e) == "table") then
		local ents = ents.GetAll();
		local ent_table = {};
		local ent_trgt = ent_trgt or nil;
		
		-- setup of ent_table
		for _,v in pairs(ents) do
			if (v:IsPlayer()) then
				ent_table[v:GetName()] = v;
			elseif (v:IsNPC()) then
				ent_table[v:GetClass()] = v;
			end
		end
		-- find 1st valid and set as target
		for k,v in pairs(ent_table) do
			if (not p_trgt and table.HasValue(e,k) and ValidEntity(v)) then
				p_trgt = v;
				e = p_trgt;
			end
		end
	end
	-- last resort in case the table is not chaged to a player or npc
	if (type(e) == "table") then
		e = nil;
	end
	self.tasks = self:Rep_AI_Follow(e);
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
	self.tasks = true;
end

-- follows specific ent and performs specific action when less than 50 units away
-- return true	following
-- return false	no ent to follow
function ENT:Rep_AI_Follow(e)
	if (e == nil or not ValidEntity(e)) then
		self.tasks = false;
	else
		local pos = self:GetPos();
		local epos = e:GetPos();
		self:SetTarget(e);
		local s = ai_schedule.New();
		s:EngTask("TASK_GET_PATH_TO_TARGET",0);
		s:EngTask("TASK_FACE_PATH",0);
		local d = (pos-epos):Length();
		if (d > 50) then
			s:EngTask("TASK_RUN_PATH",0);
		else
			self:Activity(e);
		end
		self:StartSchedule(s);
		self.tasks = true;
	end
	return self.tasks;
end

-- goes after and gathers materials until reached max_num
-- return true	prop to gather from
-- return false	no prop to gather from
function ENT:Rep_AI_Gather(max_num)
	max_num = max_num or self.max_materials;
	
	local e = nil;
	if (self.materials < max_num) then
		e = self:Find("prop_physics");
	else
		e = self:Find("rep_q");
	end
	self.tasks = self:Rep_AI_Follow(e);
end

-- seems like a pointless function, but will stay for now
-- make rep move to pos and wait for give time (both = rand)
function ENT:Rep_AI_Move_To_Position(pos,t_min,t_max)
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

-- make rep wander about a 1000 unit radius with random 0-5 second wait or defined by params
-- returns true
function ENT:Rep_AI_Wander(radius,min_wait,max_wait)
	radius = radius or 1000;
	min_wait = min_wait or 0;
	max_wait = max_wait or 5;
	
	local pos = self:GetPos();
	pos.x = math.random(radius*-1,radius);
	pos.y = math.random(radius*-1,radius);
	self:SetLastPosition(pos);
	local s = ai_schedule.New();
	s:EngTask("TASK_GET_PATH_TO_LASTPOSITION",0);
	s:EngTask("TASK_FACE_PATH",0);
	s:EngTask("TASK_RUN_PATH",0);
	s:EngTask("TASK_WAIT_FOR_MOVEMENT",0);
	s:EngTask("TASK_WAIT",math.random(min_wait,max_wait));
	self:StartSchedule(s);
	self.tasks = true;
end

-- does appropriate activity based on the entitiy
function ENT:Activity(e)
	local c = e:GetClass();
	if (c == "rep_q") then
		e.materials = e.materials + self.materials;
		self.materials = 0;
	end
	
	if (e:IsPlayer() or e:IsNPC()) then
		e:TakeDamage(5,self);
	elseif (c == "prop_physics") then
		if (gcombat) then
			if (gcombat.devhit(e,10,4) == 2) then
				e:Remove();
			end
		elseif (cds_damagepos) then
			cds_damagepos(e,10,50,nil,self);
		else
			timer.Create("prop_"..e:EntIndex(),3,1,
				function()
					e:Remove();
				end
			);
		end
		self.materials = self.materials + 10;
	elseif (c == "Zero_Point_Module") then
		self:Link(self,e);
	end
end

-- finds the nearest object by it's class
-- return closest ent by class
function ENT:Find(s)
	local e = nil;
	local color = {};
	local d = 5000;
	local dist = 0;
	local pos = self:GetPos();
	for _,v in pairs(ents.FindInSphere(pos,d)) do
		color = {v:GetColor()};
		if (v:GetClass() == s and color[4] == 255 and not table.HasValue(Replicators.IgnoreMe,v:GetModel())) then
			dist = (pos - v:GetPos()):Length();
			if (dist < d) then
				d = dist;
				e = v;
			end
		end
	end
	return e;
end

--########## NOT TESTED OR WORKING BELOW HERE ##########--

-- make rep attack near-by npc's (FIX! ATTACKS OTHER REPLICATORS)
function ENT:Rep_AI_AttackNPC()
	local trgt = ents.FindInSphere(self:GetPos(),1000);
	local e = nil;
	for _,v in pairs(trgt) do
		if (v:IsNPC()) then
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
			if (v:IsPlayer()) then
				e = v;
			end
		end
	else
		for _,v in pairs(player.GetAll()) do
			if (v:GetName() == s) then
				e = v;
			end
		end
	end
	if (e and ValidEntity(e)) then
		self:Rep_AI_Attack(e);
	else
		self:Rep_AI_Wander();
	end
end
