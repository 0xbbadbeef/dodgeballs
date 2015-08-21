db_UltimateShooterUsed = false
AddCSLuaFile( )

SWEP.Author         = "Exploderguy"
SWEP.Instructions   = "Click to shoot a powerful blast, then suicide"

SWEP.Spawnable          = false
SWEP.AdminSpawnable     = true

SWEP.WorldModel         = ""
SWEP.ViewModel         = "models/weapons/v_hands.mdl"
SWEP.AnimPrefix     = "Grenade"
SWEP.HoldType       = "grenade"

SWEP.Primary.ClipSize       = 10
SWEP.Primary.DefaultClip    = 10
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "RPG_Round"

SWEP.Secondary.ClipSize     = 10
SWEP.Secondary.DefaultClip  = 10
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "RPG_Round"

SWEP.Weight             = 5
SWEP.AutoSwitchTo       = false
SWEP.AutoSwitchFrom     = false

SWEP.PrintName          = "Ultimate Ball Launcher 1337"       
SWEP.Slot               = 2
SWEP.SlotPos            = 1
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = false

local timer_id_incrementer = 0

local function fireWeapon(self)

    local ent = ents.Create("dodgeball")

    ent:SetPos( self.Owner:GetPos() + Vector( math.Rand(-30,30), math.Rand(-30,30), math.Rand(-80,80) ) )
    ent:SetBallSize( 35 )
    ent:SetOwner( self.Owner )
    ent:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- So players dont run into it when going forward
    ent:Spawn()

    local phys = ent:GetPhysicsObject()
    if not IsValid( phys ) then ent:Remove() return end

    local velocity = Vector( math.Rand(-30,30), math.Rand(-30,30), math.Rand(-80,80) )
    velocity = velocity * 1000
    velocity = velocity + (VectorRand() * 10) -- a random element
    phys:ApplyForceCenter( velocity )
    timer_id_incrementer = timer_id_incrementer + 1 -- this is a much more efficient and less failure-prone method of assigning timer names
    util.SpriteTrail( ent, 0, team.GetColor( self.Owner:Team() ), false, 15, 1, 4, 0.1, "trails/laser.vmt" )
    timer.Simple(0.1, function() ent:SetCollisionGroup(COLLISION_GROUP_NONE) end) -- We can kill players now.
    timer.Simple(2.5, function()
        db_UltimateShooterUsed = false
        db_PlayedSound = false
    end)
end

function SWEP:Initialize()
    self:SetHoldType("melee")
    self.Weapon:SendWeaponAnim( ACT_VM_THROW )
end

function SWEP:PrimaryAttack()
    -- why doesnt a sound play the sound again while its in the if statement? Ill put it in the KeyDown hook.
    if ( db_UltimateShooterUsed == false ) then

        self.Owner:SetAnimation( PLAYER_ATTACK1 )
        self.Weapon:SendWeaponAnim( ACT_VM_THROW )

        db_UltimateShooterUsed = true
        if SERVER then
            timer.Simple(5, function()
                for i=1,10 do
                    fireWeapon(self)
                end
                local vPoint = self.Owner:GetPos()
                local effectdata = EffectData()
                effectdata:SetOrigin( vPoint )
                util.Effect( "Explosion", effectdata )
                self.Owner:Kill()
            end)
        end
    end
end

function SWEP:SecondaryAttack()
    -- Nothing!
end

function SWEP:ShouldDropOnDie()
    return false
end