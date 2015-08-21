include("dodgeballs/gamemode/config.lua")

local model = "models/Items/BoxMRounds.mdl" -- What model should it be?
local classname = "db_ammo" -- This should be the name of the folder containing this file.
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
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS)
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end

-----------
-- Touch --
-----------
function ENT:StartTouch(ent)
	if (ent:IsPlayer()) then
		local entpos = self.Entity:GetPos()
		timer.Simple(db_Config.AmmBoxResNext, function()
        	local ent = ents.Create( "ammobox" )

       		ent:SetPos( entpos )
			ent:Spawn()
		end)
		self.Entity:Remove()
		ent:GiveAmmo(5, "Grenade")
	end
end