util.AddNetworkString("db_StartRound")
include("dodgeballs/gamemode/config.lua")

function db_StartRound() -- VERY BASIC ROUND SYSTEM, DONT HAVE TIME FOR ACTUAL ONE
	timeLeft = db_Config.RoundTime
	hook.Add("Tick", "db_WaitForPlayers", function()
		if ( team.NumPlayers(1) >= 1 && team.NumPlayers(2) >= 1 ) then
			hook.Call("db_PreRound")
			print("round start")
			hook.Remove("Tick", "db_WaitForPlayers")
			for k, v in pairs( player.GetAll() ) do
				net.Start("db_StartRound")
					net.WriteInt(timeLeft, 32)
				net.Send(v)
				v:SetNWInt("db_Kills", 0)
			end

			timer.Create("db_RoundTimersv", 1, db_Config.RoundTime + 1, function()
				if ( timeLeft <= 0 ) then
					print("ROUND OVER")
					hook.Call("db_postRound")
					for k, v in pairs(player.GetAll()) do
						v:Freeze(true)
						v:ChatPrint("The round has ended") -- There's no time for pretty derma!
						v:ChatPrint("Round restarting in 5")
					end
					timer.Simple(5, function()
						for k, v in pairs( player.GetAll() ) do
							v:Spawn()
							v:Freeze(true)
							hook.Remove("PlayerInitialSpawn", "db_SendPlayersRoundMemo")
						end
						timer.Simple(5, function()
							for k, v in pairs( player.GetAll() ) do
								v:Freeze(false)
								db_StartRound()
								timer.Destroy("db_RoundTimersv")
							end
						end)
					end)
				else
					timeLeft = timeLeft - 1
					print(timeLeft)
				end
			end)

			hook.Add("PlayerInitialSpawn", "db_SendPlayersRoundMemo", function(ply)
				net.Start("db_StartRound")
					net.WriteInt(timeLeft, 32)
				net.Send(ply)
			end)
		end
	end)
end
db_StartRound()