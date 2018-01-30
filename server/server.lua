local CurrentVersion = '2.3.0'
local UpdateAvailable = false
local GithubResourceName = 'DeathScreen'


--Update Check

PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/' .. GithubResourceName .. '_Resources/master/VERSION', function(Error, NewestVersion, Header)
	PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/' .. GithubResourceName .. '_Resources/master/CHANGES', function(Error, Changes, Header)
		print('\n')
		print('####################################################################')
		print('########################### ' .. GetCurrentResourceName() .. ' ############################')
		print('####################################################################')
		print('#####                  Current Version: ' .. CurrentVersion .. '                  #####')
		print('#####                   Newest Version: ' .. NewestVersion .. '                  #####')
		print('####################################################################')
		if CurrentVersion ~= NewestVersion then
			UpdateAvailable = true
			print('############################# Outdated #############################')
			print('######################### Check the Topic ##########################')
			print('################### Or type "update ' .. GetCurrentResourceName() .. '" ###################')
			print('##################### For the newest Version! ######################')
			print('####################################################################')
			print('CHANGES: ' .. Changes)
		else
			UpdateAvailable = false
			print('#####                        Up to date!                       #####')
			print('####################################################################')
		end
		print('\n')
	end)
end)


-- Client to Client Communication

RegisterServerEvent(GetCurrentResourceName() .. ':SendDeathMessage')
AddEventHandler(GetCurrentResourceName() .. ':SendDeathMessage', function(Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller) --Sends the Death Message to every client
	TriggerClientEvent(GetCurrentResourceName() .. ':PrintDeathMessage', -1, Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller)
end)


-- Instant Update

AddEventHandler('rconCommand', function(CMDName, Arguments)
    if CMDName:lower() == 'update' then
		if #Arguments == 1 then
			if Arguments[1]:lower() == GetCurrentResourceName():lower() then
				TriggerEvent(GetCurrentResourceName() .. ':StartUpdate')
			else
				print('"' .. Arguments[1] .. '" is no known resource!')
			end
		else
			print('Argument count mismatch (Passed: ' .. #Arguments .. ', Wanted: 1)')
		end
		CancelEvent()
	end
end)

RegisterServerEvent(GetCurrentResourceName() .. ':StartUpdate')
AddEventHandler(GetCurrentResourceName() .. ':StartUpdate', function()
	if UpdateAvailable then
		PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/' .. GithubResourceName .. '_Resources/master/CHANGEDFILES', function(Error, Content, Header)
			ContentSplitted = stringsplit(Content, '\n')
			for k, Line in ipairs(ContentSplitted) do
				PerformHttpRequest('https://raw.githubusercontent.com/Flatracer/' .. GithubResourceName .. '/master/' .. Line, function(Error, FileContent, Header)
					SaveResourceFile(GetCurrentResourceName(), Line, FileContent, -1)
				end)
			end
		end)
		print('Update finished! Enter "restart ' .. GetCurrentResourceName() .. '" now!')
	else
		print('This is already the newest version! [' .. CurrentVersion .. ']')
	end
end)


-- Functions

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

