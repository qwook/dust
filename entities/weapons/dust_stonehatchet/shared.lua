if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if CLIENT then
	SWEP.PrintName			= "Stone Hatchet"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= false
	SWEP.Slot = 2
	SWEP.SlotPos		= 1
end

SWEP.Author		= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""


SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.ViewModel			= "models/weapons/v_stone_hatchet.mdl"
SWEP.WorldModel			= "models/weapons/w_stone_hatchet.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Primary.Delay			= 0.75

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Swing = Sound("weapons/iceaxe/iceaxe_swing1.wav")
SWEP.MeleeHit = Sound("Weapon_Crowbar.Melee_Hit")

SWEP.AnimPrefix = "crowbar"
SWEP.HoldType = "melee2"

/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end
/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/
function SWEP:Reload()
end

function SWEP:Deploy()
	self:SetWeaponHoldType( self.HoldType )
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

    self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	if not IsValid(self.Owner) then return end

	self.Owner:LagCompensation(true)

	local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = trace.start + (self.Owner:GetAimVector() * 75)
    trace.filter = self.Owner
	trace.mins = Vector( -5, -5, -5 )
	trace.maxs = Vector( 5, 5, 5 )
	trace.mask = MASK_SHOT_HULL
	
    local tr = util.TraceHull(trace)
	
	if SERVER and tr.Hit then
		
		--MsgN( string.find( tr.Entity:GetModel(), "tree" ) )
		--MsgN( string.find( tr.Entity:GetModel(), "rock" ) )
		
		--[[local bullet = {}
		bullet.Num 		= 1
		bullet.Src 		= self.Owner:GetShootPos()
		bullet.Dir 		= (tr.HitPos - trace.start):GetNormal()
		bullet.Spread 	= Vector( 0, 0, 0 )
		bullet.Tracer	= 0
		bullet.TracerName = nil
		bullet.Force	= 1
		bullet.Damage	= 35
		bullet.AmmoType = "Pistol"
	 
		self.Owner:FireBullets( bullet )]]
		self.Owner:TraceHullAttack( self.Owner:GetShootPos(), trace.start + (self.Owner:GetAimVector() * 75), Vector( -5, -5, -5 ), Vector( 5, 5, 5 ), 23, DMG_CLUB, 20, true )
	
	end
	
	self:DoShootEffect( tr )
	
    --[[if tr.Entity:IsTreeModel() then
        local data = {}
        data.Entity = tr.Entity
        data.Chance = 50
        data.MinAmount = 1
        data.MaxAmount = 5
        self.Owner:DoProcess("WoodCutting",2,data)
    end]]
	
	self.Owner:LagCompensation(false)
	
end

--[[---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------]]
function SWEP:SecondaryAttack()
end

--[[---------------------------------------------------------
	The shoot effect
-----------------------------------------------------------]]
function SWEP:DoShootEffect( trace )

	if trace.Hit then
		self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
		self.Weapon:EmitSound( self.MeleeHit )
	else
		self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
		self.Weapon:EmitSound(self.Swing)
	end
	
	if SERVER then
		self.Owner:SetAnimation( PLAYER_ATTACK1 )			-- 3rd Person Animation
	end
	
end
