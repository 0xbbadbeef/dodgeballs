
AddCSLuaFile( )

SWEP.Author         = "Exploderguy"
SWEP.Instructions   = "Click to shoot balls\nRight click to shoot multiple balls"

SWEP.Spawnable          = true
SWEP.AdminSpawnable     = true

SWEP.WorldModel         = ""
SWEP.ViewModel         = "models/weapons/v_hands.mdl"

SWEP.Primary.ClipSize       = 10
SWEP.Primary.DefaultClip    = 10
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "Grenade"

SWEP.Secondary.ClipSize     = 10
SWEP.Secondary.DefaultClip  = 10
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "Grenade"

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.PrintName          = "Ball Launcher 3000"       
SWEP.Slot               = 2
SWEP.SlotPos            = 1
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = false

local timer_id_incrementer = 0

local function fireWeapon(self, mode)

    if not (tonumber( self.Owner:GetAmmoCount("Grenade") ) <= 0 ) then

        local ent = ents.Create("dodgeball")

        ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 30 ) )
        ent:SetAngles( Angle(0,0,0) )
        ent:SetBallSize( 35 )
        ent:SetOwner( self.Owner )
        ent:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- So players dont run into it when going forward
        ent:Spawn()

        local phys = ent:GetPhysicsObject()
        if not IsValid( phys ) then ent:Remove() return end

        local velocity = self.Owner:GetAimVector()
        velocity = velocity * 1000
        velocity = velocity + (VectorRand() * 10) -- a random element
        phys:ApplyForceCenter( velocity )
        timer_id_incrementer = timer_id_incrementer + 1 -- this is a much more efficient and less failure-prone method of assigning timer names
        util.SpriteTrail( ent, 0, team.GetColor( self.Owner:Team() ), false, 15, 1, 4, 0.1, "trails/laser.vmt" )
        self.Owner:SetAmmo( self.Owner:GetAmmoCount("Grenade") - 1, "Grenade" )
        self.Owner:EmitSound( "npc/zombie/claw_miss1.wav" )
        timer.Simple(0.1, function() ent:SetCollisionGroup(COLLISION_GROUP_NONE) end) -- We can kill players now.

    else

        self.Owner:EmitSound("buttons/button2.wav")

    end

end

function SWEP:Initialize()
    self:SetHoldType("melee")
    self.Weapon:SendWeaponAnim( ACT_VM_THROW )
end

function SWEP:PrimaryAttack()
    self.Weapon:SetNextPrimaryFire( CurTime() + 0.2 )

    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self.Weapon:SendWeaponAnim( ACT_VM_THROW )
    self:ShootEffects( self )

    if CLIENT then return end
    fireWeapon(self, false)
end

function SWEP:SecondaryAttack()
    self:ShootEffects( self )

    if CLIENT then return end
    for i=1,3 do
        fireWeapon(self, true)
    end
end

function SWEP:ShouldDropOnDie()
    return false
end