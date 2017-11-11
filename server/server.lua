local CurrentVersion = "2.0.0"

--Update Check

PerformHttpRequest("https://raw.githubusercontent.com/Flatracer/DeathScreen_Resources/master/VERSION", function(Error, NewestVersion, Header)
	if CurrentVersion ~= NewestVersion then
		print("\n")
		print("\n")
		print("####################################################################")
		print("########################### Death Screen ###########################")
		print("####################################################################")
		print("#####                  Current Version: " .. CurrentVersion .. "                  #####")
		print("#####                   Newest Version: " .. NewestVersion .. "                  #####")
		print("####################################################################")
		print("##### Outdated, please check the Topic for the newest Version! #####")
		print("####################################################################")
		print("\n")
		print("\n")
	else
		print("\n")
		print("\n")
		print("####################################################################")
		print("########################### Death Screen ###########################")
		print("####################################################################")
		print("#####                  Current Version: " .. CurrentVersion .. "                  #####")
		print("#####                   Newest Version: " .. NewestVersion .. "                  #####")
		print("####################################################################")
		print("#####                        Up to date!                       #####")
		print("####################################################################")
		print("\n")
		print("\n")
	end
end)