db_ang = 1
local db_BullShitCamPos = 0
local map = tostring(game.GetMap())
local meta = FindMetaTable( "Player" )
include("dodgeballs/gamemode/config.lua")

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
	CHudWeaponSelection = true,
	CHudSecondaryAmmo = true,
}

for k,v in pairs( db_Config.TeamSelectCamPos ) do
    if (k == map) then
    	db_BullShitCamPos = v
    	print(v)
    end
end

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end
end )

hook.Add("DrawDeathNotice", "", function()
	return false
end)

function db_InitialSpawn() -- Set up the players team and Playermodel
	local base = vgui.Create( "DFrame" )
		base:SetSize( 300, 150 )
		base:Center()
		base:SetTitle( "TeamSelect" )
		base:SetVisible( true )
		base:SetDraggable( false )
		base:ShowCloseButton( false )
		base:MakePopup()

	local Red_Button = vgui.Create("DButton", base)
		Red_Button:SetSize( 100, 30 )
		Red_Button:SetPos( 10, 30 )
		Red_Button:SetText("Red")
		Red_Button.DoClick = function()
			base:Remove()
			hook.Remove( "CalcView", "db_CinematicCalc")
			timer.Remove("db_CinematicBullShit")

			net.Start("db_ChooseTeam")
				net.WriteInt(1, 16)
			net.SendToServer()
		end

	local Blue_Button = vgui.Create("DButton", base)
		Blue_Button:SetSize( 100, 30 )
		Blue_Button:SetPos( 190, 30 )
		Blue_Button:SetText("Blue")
		Blue_Button.DoClick = function()
			base:Remove()
			hook.Remove( "CalcView", "db_CinematicCalc")
			timer.Remove("db_CinematicBullShit")

			net.Start("db_ChooseTeam")
				net.WriteInt(2, 16)
			net.SendToServer()
		end

	hook.Add( "CalcView", "db_CinematicCalc", db_CinematicBullshit)

end

timer.Create("db_CinematicBullShit", .01, 0, function() --I know lerp is more smoother but I couldnt seem to get it too loop.. I'll probably add it in a later update.
	if (db_ang >= 360) then
		db_ang = 0
	else
		db_ang = db_ang + 1
	end
end)

function db_CinematicBullshit( ply, pos, angles, fov )
	local view = {}

	view.origin = db_BullShitCamPos
	view.angles = Angle(30, db_ang, 0)
	view.fov = fov

	return view
end

hook.Add( "CalcView", "MyCalcView", MyCalcView )

net.Receive("db_PlayerInitialSpawn", db_InitialSpawn)

net.Receive("db_InitiateRespawnSequence", function()
	local secs = 5

	local base = vgui.Create( "DFrame" )
		base:SetSize( 400, 150 )
		base:Center()
		base:SetTitle( " " )
		base:SetVisible( true )
		base:SetDraggable( false )
		base:ShowCloseButton( false )
		base:MakePopup()
		timer.Create("db_RespawnTimer", 1, 5, function()
			secs = secs - 1
		end)
		base.Paint = function()
			draw.DrawText( "Respawn in " .. secs ..  " seconds!", "DermaLarge", 200, 50, team.GetColor( LocalPlayer():Team() ), TEXT_ALIGN_CENTER)
		end

	timer.Simple(5, function()
		base:Remove()
		timer.Remove("db_RespawnTimer")

		local base = vgui.Create( "DFrame" )
			base:SetSize( 400, 150 )
			base:Center()
			base:SetTitle( " " )
			base:SetVisible( true )
			base:SetDraggable( false )
			base:ShowCloseButton( false )
			base.Paint = function()
				draw.DrawText( "Click to respawn!", "DermaLarge", 200, 50, team.GetColor( LocalPlayer():Team() ), TEXT_ALIGN_CENTER )
			end
		hook.Add("Think", "bh_tempthinkhook", function()
			if ( LocalPlayer():Alive() ) then
				base:Remove()
				hook.Remove("Think", "bh_tempthinkhook")
			end
		end)
	end)

end)

hook.Add("HUDPaint", "db_clhud", function()
	--HUD
	if (LocalPlayer():Team() != 0) then
		draw.DrawText( "HP: " .. LocalPlayer():Health(), "DermaLarge", ScrW() * 0.01, ScrH() * 0.95, team.GetColor( LocalPlayer():Team() ) )
		draw.DrawText( "Kills: " .. LocalPlayer():GetNWInt("db_Kills"), "DermaLarge", ScrW() * 0.1, ScrH() * 0.95, team.GetColor( LocalPlayer():Team() ) )
		draw.DrawText( "Ammo: " .. LocalPlayer():GetAmmoCount("Grenade"), "DermaLarge", ScrW() * 0.88, ScrH() * 0.95, team.GetColor( LocalPlayer():Team() ) )
		if ( LocalPlayer():Alive() ) then --Why doesnt this work all the time? I dont have time to fix it.
			if (LocalPlayer():GetActiveWeapon():GetClass() == "ultimateballshooter") then
				draw.DrawText( "Weapon: " .. LocalPlayer():GetActiveWeapon():GetPrintName(), "DermaLarge", ScrW() * math.Rand(0.005, 0.015), ScrH() * math.Rand( 0.85, 0.95 ), Color(math.Rand(1, 255), math.Rand(1, 255), math.Rand(1, 255) ) )
			else
				draw.DrawText( "Weapon: " .. LocalPlayer():GetActiveWeapon():GetPrintName(), "DermaLarge", ScrW() * 0.01, ScrH() * 0.90, team.GetColor( LocalPlayer():Team() ) )
			end
		end
	end
end)

net.Receive("db_NotifyBonusTime", function()
	local time = net.ReadInt(32)
	if (time == 1337) then -- A powerup that doesn't involve a timer
		local newtime = 3
		hook.Add("KeyPress", "db_WhenUltimateShooterClicked", function(ply, key)
			if (key == IN_ATTACK) then
				timer.Simple(2, function() -- You are going to probs hate me for using too many timers, i just cbf atm okay?
					timer.Create("db_BonusCountdown", 1, 3, function() -- cbf doing CurTime()
						if ( newtime == 0 ) then
							timer.Remove("db_BonusCountdown")
						else
							newtime = newtime - 1
						end
					end)
					hook.Add("HUDPaint", "db_BonusTimer", function()
						draw.DrawText( newtime, "DermaLarge", ScrW() * .5, ScrH() * .25, Color(255,255,255,200) )
						if (newtime <= 0) then 
							hook.Remove("HUDPaint", "db_BonusTimer") -- I dont like it things dont work where they are supposed to, then you have to put them in dumb spots :(
						end
					end)
				end)
				hook.Remove("KeyPress", "db_WhenUltimateShooterClicked")
			end
		end)
	elseif (time != 0) then
		local newtime = time

		timer.Create("db_BonusCountdown", 1, time, function() -- cbf doing CurTime()
			if ( newtime == 0 ) then
				timer.Remove("db_BonusCountdown")
			else
				newtime = newtime - 1
			end
		end)

		hook.Add("HUDPaint", "db_BonusTimer", function()
			draw.DrawText( "Bonus: " .. newtime, "DermaDefaultBold", ScrW() * .01, ScrH() * .25, Color(255,255,255,200) )

			draw.RoundedBox( 3, ScrW() * .01, ScrH() * .27, newtime * 2, 8, Color(10,255,10,200) )
			if (newtime <= 0) then 
				hook.Remove("HUDPaint", "db_BonusTimer") -- I think I now know why it isnt working, oh well its fine here, dont have time to move it ;)
			end
		end)
	end
end)

function meta:alertKill()
	surface.PlaySound("HL1/fvox/bell.wav")
	print("Killed someone!")
end

hook.Add( "PreDrawHalos", "", function()
	halo.Add( ents.FindByClass( "ammo*" ), Color( 255, 255, 255 ), 5, 5, 2 )
end )

net.Receive("db_alertKilledBy", function()
	local ent = net.ReadEntity()
	hook.Add("HUDPaint", "db_YouWereKilledBy", function()
		draw.DrawText( "You were killed by " .. ent:Nick(), "DermaLarge", ScrW() * .5, ScrH() * .40, team.GetColor( ent:Team() ), TEXT_ALIGN_CENTER )
	end)
	timer.Simple(5, function() hook.Remove("HUDPaint", "db_YouWereKilledBy") end)
end)

print("db: cl_player init!")