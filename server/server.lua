local CurrentVersion = "2.0.0"

--Update Check

PerformHttpRequest("https://raw.githubusercontent.com/Flatracer/DeathScreen_Resources/master/VERSION", function(Error, NewestVersion, Header)
	print("\n")
	print("####################################################################")
	print("########################### Death Screen ###########################")
	print('####################################################################')
	print('#####                  Current Version: ' .. CurrentVersion .. '                  #####')
	print('#####                   Newest Version: ' .. NewestVersion .. '                  #####')
	print('####################################################################')
	if CurrentVersion ~= NewestVersion then
		print('##### Outdated, please check the Topic for the newest Version! #####')
	else
		print('#####                        Up to date!                       #####')
	end
	print('####################################################################')
	print('\n')
end)
