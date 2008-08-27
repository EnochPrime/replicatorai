/*
	Replicator Disruptor for GarrysMod10
	Copyright (C) 2008  

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
AddCSLuaFile("shared.lua");
AddCSLuaFile("cl_init.lua");
include("shared.lua");
include("modules/callbacks.lua");
SWEP.Sounds = {
	Shot={Sound("weapons/hd_shot1.mp3"),Sound("weapons/hd_shot2.mp3")},
	SwitchMode=Sound("buttons/button5.wav"),
};
SWEP.AttackMode = 1;
SWEP.MaxAmmo = 100;
SWEP.Delay = 5;
SWEP.TimeOut = 0.25; -- Time in seconds, a target will be tracked when hit with the beam
SWEP.Ent = nil;

--################### Init the SWEP @JDM12989
function SWEP:Initialize()
	self:SetWeaponHoldType("melee");
end

--################### Initialize the shot @JDM12989
function SWEP:PrimaryAttack(fast)
	local ammo = self.Weapon:Clip1();
	local delay = 0;
	if(self.AttackMode == 1 and ammo >= 20 and not fast) then
		self.Owner:EmitSound(self.Sounds.Shot[1],90,math.random(96,102));
		self:PushEffect();
		delay = 0.3;
		self.Weapon:SetNextPrimaryFire(CurTime()+0.8);
	elseif(self.AttackMode == 2 and ammo >= 3) then
		self.Owner:SetNWBool("shooting_hand",true);
		local time = CurTime();
		if((self.LastSound or 0)+0.9 < time) then
			self.LastSound = time;
			self.Owner:EmitSound(self.Sounds.Shot[2],90,math.random(96,102));
		end
		self.Weapon:SetNextPrimaryFire(CurTime()+0.1);
	else
		self.Weapon:SetNextPrimaryFire(CurTime()+0.5);
	end
	local e = self.Weapon;
	timer.Simple(delay,
		function()
			if(ValidEntity(e) and ValidEntity(e.Owner)) then
				e:DoShoot();
			end
		end
	);
	return true;
end

--################### Secondary Attack @ aVoN
function SWEP:SecondaryAttack()
	self.Ent = nil;
	trgts = ents.FindInSphere(self:GetPos(),2000);
	for _,v in pairs(trgts) do
		if (ValidEntity(v)) then
			if (v:GetClass() == "rep_n" or v:GetClass() == "rep_q" or v:GetClass() == "rep_h") then
				self.Ent = v;
			end
		end
	end
	if (ValidEntity(self.Ent)) then
		MsgN("hurray replicators!");
	end
	self:EmitSound(self.Sounds.SwitchMode); -- Make some mode-change sounds
	--self.Weapon:SetNWBool("Mode",self.AttackMode); -- Tell client, what mode we are in
	--self.Owner.__HandDeviceMode = self.AttackMode; -- So modes are saved accross "session" (if he died it's the last mode he used it before)
end

--################### Reset Mode @ aVoN
function SWEP:OwnerChanged() 
	--self.AttackMode = self.Owner.__HandDeviceMode or 1;
	--self.Weapon:SetNWBool("Mode",self.AttackMode);
end

--################### Do the shot @JDM12989
function SWEP:DoShoot()
	local p = self.Owner;
	if(not ValidEntity(p)) then return end;
end

--################### Opens up the main gui @JDM12989
function SWEP:Reload()
	local p = self.Owner;
	timer.Create("Rep_Window",0.3,1,
		function()
			umsg.Start("Show_RepCodePanel",p);
				umsg.Entity(self.Ent);
				if (ValidEntity(self.Ent)) then
					umsg.String(self.Ent.ai);
				else
					umsg.String("");
				end
			umsg.End();
			p.RepController = self;
		end
	);
end

--################### Think @JDM2989
function SWEP:Think()
	if(self.AttackMode == 2 and self.Owner:GetNWBool("shooting_hand",false) and not self.Owner:KeyDown(IN_ATTACK)) then
		self.Owner:SetNWBool("shooting_hand",false);
	end
end
