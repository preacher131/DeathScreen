-- Version Checking down here, better don't touch this
local CurrentVersion = '2.3.1'
local GithubResourceName = 'DeathScreen'

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/FiveM_Resources/master/' .. GithubResourceName .. '/CHANGES', function(Error, Changes, Header)
		print('\n')
		print('##############')
		print('## ' .. GithubResourceName)
		print('##')
		print('## Current Version: ' .. CurrentVersion)
		print('## Newest Version: ' .. NewestVersion)
		print('##')
		if CurrentVersion ~= NewestVersion then
			print('## Outdated')
			print('## Check the Topic')
			print('## For the newest Version!')
			print('##############')
			print('CHANGES: ' .. Changes)
		else
			print('## Up to date!')
			print('##############')
		end
		print('\n')
	end)
end)

--Update Check

-- Client to Client Communication

RegisterServerEvent(GetCurrentResourceName() .. ':SendDeathMessage')
AddEventHandler(GetCurrentResourceName() .. ':SendDeathMessage', function(Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller) --Sends the Death Message to every client
	TriggerClientEvent(GetCurrentResourceName() .. ':PrintDeathMessage', -1, Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller)
end)
