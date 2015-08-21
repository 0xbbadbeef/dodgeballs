db_text = "Waiting for players!"
include("dodgeballs/gamemode/config.lua")

net.Receive("db_StartRound", function()
	local timeLeftcl = net.ReadInt(32)
	timer.Create("db_RoundTimer", 1, db_Config.RoundTime + 1, function()
		if ( timeLeftcl == 0 ) then
			print("ROUND OVER!")
			timer.Remove("db_RoundTimer")
			db_text = "Restarting Round!"
			timer.Simple(9.5, function() db_text = "Waiting for players!" end)
		else
			timeLeftcl = timeLeftcl - 1
			db_text = string.FormattedTime( timeLeftcl, "%2i:%02i")
		end
	end)
end)

hook.Add("HUDPaint", "", function()
	surface.SetFont( "DermaLarge" )
	surface.SetTextColor( 255,157,0 )
	surface.SetTextPos( ScrW() * .478, ScrH() * .01 )
	local w, h = surface.GetTextSize(db_text)
	draw.RoundedBox( 5, ScrW() * .48, ScrH() * .0001, w + 4, h + 7, Color(0,0,0,150) )
	surface.DrawText(db_text) -- No time to Align! Also, I dont know how ;-;
end)
print("DB: Rounds Loaded!")