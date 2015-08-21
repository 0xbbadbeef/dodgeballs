util.AddNetworkString("db_PlayerInitialSpawn")
util.AddNetworkString("db_ChooseTeam")
util.AddNetworkString("db_InitiateRespawnSequence")

hook.Add("PlayerInitialSpawn", "", function(ply)

	net.Start("db_PlayerInitialSpawn")
	net.Send(ply)
	ply:GodEnable()

	print("Player " .. ply:Nick() .. " spawned!")

end)

hook.Add("PlayerDeath", "", function(ply)
	net.Start("db_InitiateRespawnSequence")
	net.Send(ply)
end)

net.Receive("db_ChooseTeam", function(len, ply)
	ply:SetTeam( net.ReadInt(16) )
	print(ply:Nick() .. " joined " .. team.GetName( ply:Team() ) )
	ply:KillSilent()
	ply:GodDisable()
end)

print("db: sv_player init!")