AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include('shared.lua');
include('modules/asm.lua');
include('modules/block.lua');
include('modules/spawner.lua');

function ENT:Initialize()
	self:SetModel("models/JDM12989/Block.mdl");
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:SetCollisionGroup(COLLISION_GROUP_WORLD);
	self:DrawShadow(false);
	self:AddBlock();
	self.assembled = false;		-- part of a group already assembling
	self.class = nil;			-- class of rep to form
	self.cost = 0;				-- how many to use
	self.leader = nil;			-- who is the leader
	self.sever = false;			-- disconnect intelligence
	self.wait = CurTime();
	self.ThinkNext = CurTime()+1;
	local phys = self:GetPhysicsObject();
	if (phys:IsValid()) then
		phys:Wake();
	end
end

function ENT:SpawnFunction(p,t)
	if (!t.Hit) then return end
	local pos = t.HitPos + t.HitNormal * 16;
	local e = ents.Create("block");
	e:SetPos(pos);
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Think()
	if (self.ThinkNext > CurTime() or self.sever) then return end
	if (self.wait+10 <= CurTime()) then
		self.sever = true;
		self:OnRemove();
	end
	self:Check();
	if (self:Gather()) then
		self.wait = CurTime();
	end
	self:Assemble();
	self.NextThink = CurTime()+1;
end

function ENT:OnRemove()
	self:RemoveBlock();
	self:SetNWBool("fade_out",true);
	-- Kill after some time
	local e = self.Entity;
	timer.Simple(5,
		function()
			if(e and e:IsValid()) then
				self:Remove();
			end
		end
	);
end
