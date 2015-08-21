util.AddNetworkString("db_alertKilledBy")
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile("dodgeballs/gamemode/config.lua")
 
include( 'shared.lua' )
include( 'config.lua' )

print("DodgeBalls: ServerSide lua int..")

local db_fol = GM.FolderName.."/gamemode/core/"
db_prizang = 1

function db_LoadServerSide()

    local files, folders = file.Find(db_fol .. "*", "LUA")
    for k,v in pairs(files) do
        if string.GetExtensionFromFilename(v) ~= "lua" then continue end

        include(db_fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do -- Ripped off my mHub gamemode and DarkRP loading system.
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(db_fol .. folder .."/sh_*.lua", "LUA"), true) do
            AddCSLuaFile(db_fol..folder .. "/" ..File)
            include(db_fol.. folder .. "/" ..File)
        end

        for _, File in SortedPairs(file.Find(db_fol .. folder .."/sv_*.lua", "LUA"), true) do
            include(db_fol.. folder .. "/" ..File)
        end

        for _, File in SortedPairs(file.Find(db_fol .. folder .."/cl_*.lua", "LUA"), true) do
            AddCSLuaFile(db_fol.. folder .. "/" ..File)
        end
    end

    hook.Call("db_loadedserverside")
end
db_LoadServerSide()
concommand.Add("db_loadsv", function(ply)
    if ( ply:IsAdmin() ) then
        db_LoadServerSide()
    end
end)

hook.Add("InitPostEntity", "", function() -- Dont want to ruin anything bad
    PrintTable(db_Config.PwrVec)

    local map = tostring(game.GetMap())

    for k,v in pairs( db_Config.PwrVec ) do
        if (k == map) then
            if istable(v) then
                for k, v in pairs(v) do
                    local ent = ents.Create( "powerup" )
                    ent:SetPos( v )
                    ent:Spawn()
                end
            else
                local ent = ents.Create( "powerup" )
                ent:SetPos( v )
                ent:Spawn()
            end
        end
    end

    timer.Create("", .01, 0, function() --I know lerp is more smoother but I couldnt seem to get it too loop.. I'll probably add it in a later update.
        for k, v in pairs( ents.GetAll() ) do
            if v:GetClass() == "powerup" then
                if (db_prizang >= 360 && v:IsValid() ) then
                    db_prizang = 0
                    v:SetAngles( Angle(0, db_prizang, 0 ) )
                    v:SetColor( Color( math.Rand(1, 255), math.Rand(1, 255), math.Rand(1, 255) ) )
                else
                    db_prizang = db_prizang + 1
                    v:SetAngles( Angle(0, db_prizang, 0 ) )
                    v:SetColor( Color( math.Rand(1, 255), math.Rand(1, 255), math.Rand(1, 255) ) )
                end
            end
        end
    end)

    for k,v in pairs( db_Config.LaunchPadVec ) do
        if (k == map) then
            if istable(v) then
                for k, v in pairs(v) do
                    local ent = ents.Create( "launchpad" )
                    ent:SetPos( v )
                    ent:Spawn()
                end
            else
                local ent = ents.Create( "launchpad" )
                ent:SetPos( v )
                ent:Spawn()
            end
        end
    end

    for k,v in pairs( db_Config.AmmoBoxsVec ) do
        if (k == map) then
            if istable(v) then
                for k, v in pairs(v) do
                    local ent = ents.Create( "ammobox" )
                    ent:SetPos( v )
                    ent:Spawn()
                end
            else
                local ent = ents.Create( "ammobox" )
                ent:SetPos( v )
                ent:Spawn()
            end
        end
    end

    for k,v in pairs( ents.GetAll() ) do
        if ( v:GetClass() == "prop_door_rotating"  or v:GetClass() == "item_ammo_crate" or v:GetClass() == "func_wall_toggle")then
            v:Remove()
        end
    end

end)

function GM:PlayerSpawn( ply )
    self.BaseClass:PlayerSpawn( ply )   
 
    ply:SetGravity  ( 1 )  
    ply:SetMaxHealth( 100, true )  
 
    ply:SetWalkSpeed( 300 )  
    ply:SetRunSpeed ( 600 ) 
    ply:SetJumpPower( 300 )

    ply:SetAmmo(10, "Grenade")
 
end

function GM:PlayerLoadout( ply )
	ply:Give("ballshooter")
end

function GM:PlayerInitialSpawn( ply )

end

function GM:GetFallDamage()
    return 0
end

--[[--------------------------
    DISABLE A LOT OF BAD SHIT
]]----------------------------

function GM:ContextMenuOpen()
    return false
end

function GM:CanPlayerSuicide()
    return false
end

function GM:PlayerSpawnProp()
    return false
end
