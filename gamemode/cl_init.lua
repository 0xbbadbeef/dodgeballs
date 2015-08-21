include( 'shared.lua' )

print("DodgeBalls: ClientSide lua int..")

db_root = GM.FolderName.."/gamemode/core/"
function db_LoadClientSide()

	local _, folders = file.Find(db_root.."*", "LUA")

	for _, folder in SortedPairs(folders, true) do -- Ripped off my mHub gamemode.
		for _, File in SortedPairs(file.Find(db_root .. folder .."/sh_*.lua", "LUA"), true) do
			include(db_root.. folder .. "/" ..File)
		end
		for _, File in SortedPairs(file.Find(db_root .. folder .."/cl_*.lua", "LUA"), true) do
			include(db_root.. folder .. "/" ..File)
		end
	end

	hook.Call("db_loadedclientside")
end

db_LoadClientSide()
concommand.Add("db_loadcl", function(ply)
    if ( ply:IsAdmin() ) then
        db_LoadClientSide()
    end
end)

--[[------------------------
	DISABLE BAD CLIENT SHIT
]]--------------------------

function GM:SpawnMenuOpen()
	return false
end