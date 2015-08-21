local model = "models/hunter/plates/plate3x3.mdl" -- What model should it be?
local classname = "db_launchpad" -- This should be the name of the folder containing this file.
local ShouldSetOwner = false -- Set the entity's owner?
db_prizang = 1

-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
-------------------------------

--------------------
-- Spawn Function --
--------------------
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create( classname )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	if ShouldSetOwner then
		ent.Owner = ply
	end
	return ent
	
end

----------------
-- Initialize --
----------------
function ENT:Initialize()
	
	self.Entity:SetModel( model )
	self.Entity:PhysicsInit( SOLID_NONE)
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS)
	self.Entity:SetMaterial( "models/shiny" )
	self.Entity:SetColor( Color(0, 255, 0))
	self.Entity:DropToFloor()
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end

-----------
-- Touch --
-----------
function ENT:StartTouch(ent)
	if ( ent:IsPlayer() ) then
		self.Entity:SetColor( Color(255, 0, 0))
		ent:SetVelocity( Vector(0,0,900) )
		self:EmitSound("weapons/physcannon/energy_bounce1.wav")
		ent:EmitSound("vo/coast/odessa/male01/nlo_cheer0" .. math.floor(math.Rand(2,4)) .. ".wav")
	end
end

function ENT:EndTouch(ent)
	if ( ent:IsPlayer() ) then
		self.Entity:SetColor( Color(0, 255, 0))
	end
end

hook.Add( "KeyPress", "db_WhenUltimateShooterClicked", function(ply, key)
	if (key == IN_JUMP && ply:GetJumpPower() == 1000 && ply:IsOnGround() ) then
		ply:EmitSound("vo/coast/odessa/male01/nlo_cheer0" .. math.floor(math.Rand(2,4)) .. ".wav")
	end
end )