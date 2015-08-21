db_Config = {} -- Ignore me

db_Config.Rolls = {}
function db_Config.AddPwr(data, func)
	data.func = func
	if data.sound then data.sound = Sound(data.sound) end
	db_Config.Rolls[#db_Config.Rolls + 1] = data
end
--IGNORE EVERYTHING ABOVE ME!

--[[
	
	Thank you so much for downloading my gamemode!
	This game was created for DatFancyChicken's 48 hour gamemode challenge that only included him.. lol.

	In Case you didnt know, Exploderguy is DatFancyChicken

	Anyway, enough of my rant. Here's my gamemode. You are currently in the configureation file.
	Here you can change values and add/remove powerups. NOTE: You need to know lua to add powerups!

	I really hope you enjoy my addon. If you have a generous heart, you can donate to me on the donation button found here: http://facepunch.com/showthread.php?t=1473748.

]]--

------------------------

--[[
	
	Spectating Vec

	When you are in the team selection menu, this is where the camera spins around. You should probably only have one for each map.

]]--

db_Config.TeamSelectCamPos = {
	["gm_mariokart64_skyscraper"] = Vector( -21.296425, -3.397142, 1546.548950 ),
	["dm_runoff_winter_storm_v1_2"] = Vector(11784.028320, 2145.914551, -74.365540),
	["gmod13_hotels"] = Vector( -1912.086670, 1893.781006, 1381.626709 ),
	["gm_lasertag"] = Vector( -464.283325, 474.100128, 706.325195 )
}

--[[
	
	Round Time

	This int declares how long the rounds go for. This can be as long as you want.
	NOTE: MAKE SURE THE VALUE IS IN SECONDS, DONT WORRY, IT WILL FORMAT LATER! Def: 180 = 3 mins

]]--

db_Config.RoundTime = 180 -- 3 mins

--[[
	
	AmmoBox Vectors

	These are the positions where the ammo boxes will spawn for a specific map. You can have as many of these as you want.
	Its recommended you have at least 3. Also, this is the only way you can do it untill im botherd to do a in-game spawn
	thing.

]]--

db_Config.AmmoBoxsVec = {
	["gm_construct"] = { Vector(0,0,0) },
	["dm_runoff_winter_storm_v1_2"] =  { Vector(  9429.412109, 3362.216309, -365.694336 ), Vector(  8720.410156, 3268.828369, -130.856415 ), Vector(  9454.467773, 3114.222412, -176.968750) },
	["gmod13_hotels"] = { Vector( -480.184875, 1325.295166, 777.705078 ), 
		Vector( -154.074127, -9.975796, 1423.289551 ), 
		Vector( -2352.464844, -98.553528, 792.341675), 
		Vector( -1091.761597, 1899.146484, 670.961060 ), 
		Vector( -718.837097, -567.891113, -105.355759),
		Vector( -1531.374268, -400.324738, -109.717361),
		Vector( -2346.819336, -221.302734, -232.468018 ),
		Vector( -1399.824585, -826.314148, -233.645447 ),
		Vector( -3850.125244, 2409.210938, -1472.108765 ) },
	["gm_lasertag"] = { Vector( -465.635437, 891.848633, 384.031250 ), 
		Vector( -472.214966, 60.752625, 384.031250 ), 
		Vector( -475.778870, -516.032227, 348.031250 ), 
		Vector( -469.962341, 1492.420532, 384.031494 ),
		Vector( -1789.295654, 1025.131714, 512.031250 ),
		Vector( -1301.362305, 489.302704, 128.031250 ),
		Vector( 326.325684, 473.873199, 128.031250 ),
		Vector( 834.932251, -64.081970, 512.031250 )
	}
}

--[[
	
	AmmoBox Time Till Respawn

	This variable defines when the ammo box will spawn next. NOTE: It's in seconds.

]]--

db_Config.AmmBoxResNext = 30

--[[
	
	LaunchPad Vectors

	This is where the launchpads spawn. You can have as many spawn pads as you want. Refer to the default ones for reference.

]]--

db_Config.LaunchPadVec = {
	["gm_mariokart64_skyscraper"] = { Vector(  -74.784836, 410.131989, 1060.989380 ), Vector(  -90.122681, -416.027557, 1060.989380 ) },
	["dm_runoff_winter_storm_v1_2"] =  { Vector( 10719.690430, 3543.366699, -420.497162 ), Vector( 10371.706055, 946.406555, -439.708282 ), Vector( 8418.560547, 1204.032227, -424.376465), Vector( 8198.251953, 3606.901123, -411.826935) },
	["gmod13_hotels"] = { 
		Vector( -1501.370483, 1210.690552, 670.020447 ), 
		Vector( -2208.596436, 610.678162, 448.031250 ), 
		Vector( -2553.568359, 688.591553, 64.031250 ),
		Vector( -3350.076416, 2307.263672, 320.031250 ),
		Vector( -2721.512207, 3369.269287, 824.031250 ),
		Vector( -2503.771484, 2042.225708, 320.031250 ) },
	["gm_lasertag"] = { Vector( -476.129181, 474.684357, 256.031250) }
}

--[[

	PowerUp Box Vector:

	This is where the powerup boxes can spawn. You can have as many boxes as you want. Refer to the default ones for reference.

]]--

db_Config.PwrVec = { 
	["gm_mariokart64_skyscraper"] = Vector( -7.326394, -15.187552, 1190.406494),
	["dm_runoff_winter_storm_v1_2"] =  { Vector( 11086.796875, 3589.734375, -139.468750 ), Vector( 10796.010742, 979.348145, -161.968750), Vector(8695.802734, 1095.589355, -184.958008) },
	["gmod13_hotels"] = { Vector( -1921.072144, 2074.813721, 715.890198 ),
		Vector( -2084.892090, -807.732300, -321.468750 ),
		Vector( -3126.009521, 2114.849121, 320.031250 ) },
	["gm_lasertag"] = { Vector( -476.129181, 474.684357, 276.031250 ), Vector( -482.722443, 479.016022, 128.031250 ) }
}

--[[

	PowerUp Box Time Till Respawn

	This variable defines when the powerup box will spawn next. NOTE: It's in seconds.

]]--

db_Config.PwrResNext = 100

--[[

	Powerups:
	
	These are the powerups found in the PowerUp box thing.

	Follow this syntax: db_Config.AddPwr(variables (things added to roll table you can access in func), func it calls)
	Default variables are name, time (Shows as effect time in chat. 0=Not show), kills (If it will kill roller, makes the box effect not draw), sound (sound played)
	Arguments of func are: roll (the data you defined) and ply (the player who rolled)

	--Side Note, thanks to zerf for fixing my rtd addon which is used in the power up system
	--Another Note, if it doesnt need timer, put time to 0 (if you want a 3,2,1 countdown, put it to 1337)

]]--

db_Config.AddPwr({name="MoonJump", time=20, sound="vo/Citadel/br_laugh01.wav"}, function(roll, ply)
	if not SERVER then return end
	local db_oldjump = ply:GetJumpPower()
	ply:SetJumpPower(1000)
	timer.Simple(roll.time, function()
		if not IsValid(ply) then return end
		ply:SetJumpPower(db_oldjump)
		ply:ChatPrint("Moon Jump has worn out")
	end)
end)

db_Config.AddPwr({name="God", time=10, sound="vo/Citadel/br_laugh01.wav"}, function(roll, ply)
	if not SERVER then return end
	ply:GodEnable()
	timer.Simple(roll.time, function()
		if not IsValid(ply) then return end
		ply:GodDisable()
		ply:ChatPrint("God Mode has worn out")
	end)
end)

db_Config.AddPwr({name="UltimateBallShooter", time=1337, sound="vo/coast/odessa/male01/nlo_cheer01.wav"}, function(roll, ply)
	if not SERVER then return end
	ply:StripWeapons()
	ply:Give("ultimateballshooter")
	ply:SetMaterial("models/shiny")
	hook.Add("Tick", "db_SickInsanseSeizueTime", function()
		ply:SetColor(Color(math.Rand(1, 255), math.Rand(1, 255), math.Rand(1, 255) ))
	end)
	hook.Add("PlayerDeath", "db_CleanupSizure", function(vic)
		if not IsValid(ply) then return end
		if not ( ply == vic ) then return end
		hook.Remove("Tick", "db_SickInsanseSeizueTime")
		ply:SetMaterial("")
		ply:SetColor( Color(255,255,255,255) )
		ply:StripWeapons()
		ply:Give("ballshooter")
		ply:ChatPrint("Ultimate Ball Shooter has ran out!")
		hook.Remove("PlayerDeath", "db_CleanupSizure")
	end)
end)

db_Config.AddPwr({name="50Dodgeballs", time=0, sound="vo/Citadel/br_laugh01.wav"}, function(roll, ply)
	if not SERVER then return end
	ply:GiveAmmo(50, "Grenade")
end)