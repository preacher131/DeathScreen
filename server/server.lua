local CurrentVersion = '2.2.0'

--Update Check

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/DeathScreen_Resources/master/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/DeathScreen_Resources/master/CHANGES', function(Error, Changes, Header)
		print('\n')
		print('####################################################################')
		print('########################### Death Screen ###########################')
		print('####################################################################')
		print('#####                  Current Version: ' .. CurrentVersion .. '                  #####')
		print('#####                   Newest Version: ' .. NewestVersion .. '                  #####')
		print('####################################################################')
		if CurrentVersion ~= NewestVersion then
			print('##### Outdated, please check the Topic for the newest Version! #####')
			print('####################################################################')
			print('CHANGES: ' .. Changes)
		else
			print('#####                        Up to date!                       #####')
			print('####################################################################')
		end
		print('\n')
	end)
end)

-- Client to Client Communication

RegisterServerEvent('DeathScreen:SendDeathMessage')
AddEventHandler('DeathScreen:SendDeathMessage', function(Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller) --Sends the Death Message to every client
	TriggerClientEvent('DeathScreen:PrintDeathMessage', -1, Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller)
end)
