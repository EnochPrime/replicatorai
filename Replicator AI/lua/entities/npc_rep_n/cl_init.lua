include('shared.lua')
 
ENT.RenderGroup = RENDERGROUP_BOTH
  
function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:SetRagdollBones( bIn )
	self.m_bRagdollSetup = bIn
end

function ENT:DoRagdollBone( PhysBoneNum, BoneNum )
	self:SetBonePosition( BoneNum, Pos, Angle )
end 
