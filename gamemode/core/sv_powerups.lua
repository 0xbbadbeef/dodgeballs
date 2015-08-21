include( 'dodgeballs/gamemode/config.lua' )
util.AddNetworkString("db_NotifyBonusTime")

function db_ChoosePowerUp(ply, entpos)

	local roll = math.random(1, #db_Config.Rolls)
	local rolldata = db_Config.Rolls[roll]

	rolldata.func(rolldata, ply)
	ply:EmitSound(rolldata.sound)

	ply:SetNWBool( "db_inBonus", true )

	timer.Simple(rolldata.time, function()
		ply:SetNWBool( "db_inBonus", false )
	end)

	ply:ChatPrint("You received " .. rolldata.name)
	net.Start("db_NotifyBonusTime")
		net.WriteInt(rolldata.time, 32)
	net.Send(ply)
	PrintTable(rolldata)
	if ( rolldata.time == 1337 ) then
		hook.Add( "KeyPress", "db_WhenUltimateShooterClicked", function(ply, key)
			if (key == IN_ATTACK) then
				ply:EmitSound("vo/k_lab/kl_initializing02.wav") -- I have to put it here, see why in ultimateballshooter.lua.
				hook.Remove("KeyPress", "db_WhenUltimateShooterClicked")
			end
		end )
	end
end