AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer() --Spawn
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false) --Disable AutoSpawn
end)

Citizen.CreateThread(function()
	local scaleform, X, Y, W; H = 0.0125
	
	RequestScriptAudioBank('MP_WASTED', 0)
	
	while true do
		Citizen.Wait(0)  
	   
		if not HasThisAdditionalTextLoaded('global', 100) then
			ClearAdditionalText(100, true)
			RequestAdditionalText('global', 100)
			while not HasThisAdditionalTextLoaded('global', 100) do
				Citizen.Wait(0)
			end
		end
		
		if not HasNamedScaleformMovieLoaded('MP_BIG_MESSAGE_FREEMODE') then
			scaleform = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
			while not HasNamedScaleformMovieLoaded('MP_BIG_MESSAGE_FREEMODE') do
				Citizen.Wait(0)
			end
		end
		
		if not HasStreamedTextureDictLoaded('timerbars') then
			RequestStreamedTextureDict('timerbars')
			while not HasStreamedTextureDictLoaded('timerbars') do
				Citizen.Wait(0)
			end
		end
		
		if IsPlayerDead(PlayerId()) then
			local PedKiller = GetPedSourceOfDeath(PlayerPedId()); DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			local Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller, INT

			if IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			else
				Killer = nil
			end
			
			if (Killer == PlayerId()) then
				DeathReasonVictim = 'DM_U_SUIC'
				DeathReasonOthers = 'DM_O_SUIC'
			elseif (Killer == nil) then
				DeathReasonVictim = 'DM_TK_YD1'
--				if DeathCauseHash == GetHashKey('WEAPON_FALL') then -- Currently not working ¯\_(ツ)_/¯
--					DeathReasonOthers = 'DM_TK_FALL0'
--				else
					DeathReasonOthers = 'TICK_DIED'
--				end
			else
				if IsMelee(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 4)
					DeathReasonVictim = 'DM_TK_MELEE1' .. INT
					DeathReasonKiller = 'DM_TK_MELEE0' .. INT
					DeathReasonOthers = 'DM_TK_MELEE2' .. INT
				elseif IsTorch(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_TORCH1' .. INT
					DeathReasonKiller = 'DM_TK_TORCH0' .. INT
					DeathReasonOthers = 'DM_TK_TORCH2' .. INT
				elseif IsKnife(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_KNIFE1' .. INT
					DeathReasonKiller = 'DM_TK_KNIFE0' .. INT
					DeathReasonOthers = 'DM_TK_KNIFE2' .. INT
				elseif IsPistol(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 1)
					DeathReasonVictim = 'DM_TK_PISTOL1' .. INT
					DeathReasonKiller = 'DM_TK_PISTOL0' .. INT
					DeathReasonOthers = 'DM_TK_PISTOL2' .. INT
				elseif IsSub(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 3)
					DeathReasonVictim = 'DM_TK_SUB1' .. INT
					DeathReasonKiller = 'DM_TK_SUB0' .. INT
					DeathReasonOthers = 'DM_TK_SUB2' .. INT
				elseif IsRifle(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 3)
					DeathReasonVictim = 'DM_TK_ARIFLE1' .. INT
					DeathReasonKiller = 'DM_TK_ARIFLE0' .. INT
					DeathReasonOthers = 'DM_TK_ARIFLE2' .. INT
				elseif IsLight(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_LIGHT1' .. INT
					DeathReasonKiller = 'DM_TK_LIGHT0' .. INT
					DeathReasonOthers = 'DM_TK_LIGHT2' .. INT
				elseif IsShotgun(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_SHOT1' .. INT
					DeathReasonKiller = 'DM_TK_SHOT0' .. INT
					DeathReasonOthers = 'DM_TK_SHOT2' .. INT
				elseif IsSniper(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_SNIPE1' .. INT
					DeathReasonKiller = 'DM_TK_SNIPE0' .. INT
					DeathReasonOthers = 'DM_TK_SNIPE2' .. INT
				elseif IsHeavy(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_HEAVY1' .. INT
					DeathReasonKiller = 'DM_TK_HEAVY0' .. INT
					DeathReasonOthers = 'DM_TK_HEAVY2' .. INT
				elseif IsMinigun(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 3)
					DeathReasonVictim = 'DM_TK_MINI1' .. INT
					DeathReasonKiller = 'DM_TK_MINI0' .. INT
					DeathReasonOthers = 'DM_TK_MINI2' .. INT
				elseif IsBomb(DeathCauseHash) then
					INT = GetRandomIntInRange(0, 2)
					DeathReasonVictim = 'DM_TK_BOMB1' .. INT
					DeathReasonKiller = 'DM_TK_BOMB0' .. INT
					DeathReasonOthers = 'DM_TK_BOMB2' .. INT
				elseif IsVeh(DeathCauseHash) then
					DeathReasonVictim = 'DM_TK_VEH1'
					DeathReasonKiller = 'DM_TK_VEH0'
					DeathReasonOthers = 'DM_TK_VEH2'
				elseif IsVK(DeathCauseHash) then
					DeathReasonVictim = 'DM_TK_VK1'
					DeathReasonKiller = 'DM_TK_VK0'
					DeathReasonOthers = 'DM_TK_VK2'
				else
					DeathReasonVictim = 'DM_TICK1'
					DeathReasonKiller = 'DM_TICK2'
					DeathReasonOthers = 'DM_TICK6'
				end
			end
			
			StartScreenEffect('DeathFailOut', 0, 0)
			
			Citizen.Wait(300)
			
			TriggerServerEvent('DeathScreen:SendDeathMessage', PlayerId(), Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller)
			
			PlaySoundFrontend(-1, 'MP_Flash', 'WastedSounds', 1)
			
			ShakeGameplayCam('DEATH_FAIL_IN_EFFECT_SHAKE', 1.0)

			PushScaleformMovieFunction(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
			PushScaleformMovieFunctionParameterString(GetLabelText('RESPAWN_W'))
			if DeathReasonVictim ~= 'DM_TK_YD1' then
				PushScaleformMovieFunctionParameterString(GetLabelText(DeathReasonVictim))
			end
			PopScaleformMovieFunctionVoid()
			
			Citizen.Wait(500)
			
			local timer = GetGameTimer()
				
			while IsPlayerDead(PlayerId()) do
				Citizen.Wait(0)
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
				
				if Killer and Killer ~= PlayerId() then
					local ScaleformMovie = RequestScaleformMovie('instructional_buttons')
					DrawScaleformMovieFullscreen(ScaleformMovie, 255, 255, 255, 0)
					PushScaleformMovieFunction(ScaleformMovie, 'CLEAR_ALL')
					PopScaleformMovieFunctionVoid()
					PushScaleformMovieFunction(ScaleformMovie, 'SET_CLEAR_SPACE')
					PushScaleformMovieFunctionParameterInt(200)
					PopScaleformMovieFunctionVoid()
					
					PushScaleformMovieFunction(ScaleformMovie, 'SET_DATA_SLOT')
					PushScaleformMovieFunctionParameterInt(0)
					if GetLastInputMethod(2) then
						PushScaleformMovieFunctionParameterInt(100)
					else
						PushScaleformMovieFunctionParameterInt(30)
					end
					BeginTextCommandScaleformString('STRING')
					AddTextComponentScaleform(GetLabelText('HUD_INPUT97'))
					EndTextCommandScaleformString()	
					PopScaleformMovieFunctionVoid()

					PushScaleformMovieFunction(ScaleformMovie, 'DRAW_INSTRUCTIONAL_BUTTONS')
					PopScaleformMovieFunctionVoid()
					PushScaleformMovieFunction(ScaleformMovie, 'SET_BACKGROUND_COLOUR')
					PushScaleformMovieFunctionParameterInt(0)
					PushScaleformMovieFunctionParameterInt(0)
					PushScaleformMovieFunctionParameterInt(0)
					PushScaleformMovieFunctionParameterInt(60)
					PopScaleformMovieFunctionVoid()

					if ((GetLastInputMethod(2) and (IsControlJustPressed(1, 24) or IsDisabledControlJustPressed(1, 24))) or (not GetLastInputMethod(2) and
					   (IsControlJustPressed(1, 21) or IsDisabledControlJustPressed(1, 21)))) and GetTimeDifference(GetGameTimer(), timer) < 6750 then
						PlaySoundFrontend(-1, 'Faster_Bar_Full', 'RESPAWN_ONLINE_SOUNDSET', 1)
						timer = GetTimeDifference(timer, 250)
					end

					if GetTimeDifference(GetGameTimer(), timer) < 7500 then
						W = (GetTimeDifference(GetGameTimer(), timer) * (0.085 / 7500))
					end
					
					local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
					X, Y = 0.9255 - correction, 0.94 - correction
					
					Set_2dLayer(0)
					DrawSprite('timerbars', 'all_black_bg', X, Y, 0.15, 0.0325, 0.0, 255, 255, 255, 180)
					
					Set_2dLayer(1)
					DrawRect(X + 0.0275, Y, 0.085, 0.0125, 100, 0, 0, 180)
					
					Set_2dLayer(2)
					DrawRect(X - 0.015 + (W / 2), Y, W, H, 150, 0, 0, 180)
					
					SetTextColour(255, 255, 255, 180)
					SetTextFont(0)
					SetTextScale(0.3, 0.3)
					SetTextCentre(true)
					SetTextEntry('STRING')
					AddTextComponentString(GetLabelText('KS_RESPAWN_B'))
					Set_2dLayer(3)
					DrawText(X - 0.06, Y - 0.012)
					
					if GetTimeDifference(GetGameTimer(), timer) >= 3000 then
						if IsGameplayCamShaking() then
							StopGameplayCamShaking(true)
						end
--[[						if not NetworkIsInSpectatorMode() then
							while not HasCollisionLoadedAroundEntity(GetPlayerPed(Killer)) do
								Citizen.Wait(0)
								RequestCollisionAtCoord(GetEntityCoords(GetPlayerPed(Killer), true))
							end
							NetworkSetInSpectatorMode(true, GetPlayerPed(Killer))
							SetCinematicModeActive(true)
						end]]																			-- Currently not working ¯\_(ツ)_/¯
					end
					
					if GetTimeDifference(GetGameTimer(), timer) >= 7500 then
						exports.spawnmanager:spawnPlayer()
					end
				else
					if GetTimeDifference(GetGameTimer(), timer) >= 5000 then
						exports.spawnmanager:spawnPlayer()
					end
				end
			end
			
			if GetScreenEffectIsActive('DeathFailOut') then
				StopScreenEffect('DeathFailOut')
			end
			if IsGameplayCamShaking() then
				StopGameplayCamShaking(true)
			end
--[[			if NetworkIsInSpectatorMode then
				SetCinematicModeActive(false)
				NetworkSetInSpectatorMode(false, GetPlayerPed(Killer))
			end]] 														-- Currently not working ¯\_(ツ)_/¯
		end
    end
end)

RegisterNetEvent('DeathScreen:PrintDeathMessage')
AddEventHandler('DeathScreen:PrintDeathMessage', function(Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller) --Prints the Death Message
	if (Victim == PlayerId()) then
		drawNotification(GetLabelText(DeathReasonVictim):gsub('~a~', '~bold~' .. GetPlayerName(Killer) .. '~bold~'))
	elseif (Killer == PlayerId()) then
		drawNotification(GetLabelText(DeathReasonKiller):gsub('~a~', '~bold~' .. GetPlayerName(Victim) .. '~bold~'))
	else
		drawNotification(GetLabelText(DeathReasonOthers):gsub('~a~', '~bold~' .. GetPlayerName(Killer) .. '~bold~', 1):gsub('~a~', '~bold~' .. GetPlayerName(Victim) .. '~bold~'))
	end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function drawNotification(Notification)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(Notification)
	DrawNotification(false, false)
end

function IsMelee(Weapon)
	local Weapons = {'WEAPON_UNARMED', 'WEAPON_CROWBAR', 'WEAPON_BAT', 'WEAPON_GOLFCLUB', 'WEAPON_HAMMER', 'WEAPON_NIGHTSTICK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {'WEAPON_MOLOTOV'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {'WEAPON_DAGGER', 'WEAPON_KNIFE', 'WEAPON_SWITCHBLADE', 'WEAPON_HATCHET', 'WEAPON_BOTTLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {'WEAPON_SNSPISTOL', 'WEAPON_HEAVYPISTOL', 'WEAPON_VINTAGEPISTOL', 'WEAPON_PISTOL', 'WEAPON_APPISTOL', 'WEAPON_COMBATPISTOL'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {'WEAPON_MICROSMG', 'WEAPON_SMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {'WEAPON_CARBINERIFLE', 'WEAPON_MUSKET', 'WEAPON_ADVANCEDRIFLE', 'WEAPON_ASSAULTRIFLE', 'WEAPON_SPECIALCARBINE', 'WEAPON_COMPACTRIFLE', 'WEAPON_BULLPUPRIFLE'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {'WEAPON_MG', 'WEAPON_COMBATMG'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {'WEAPON_BULLPUPSHOTGUN', 'WEAPON_ASSAULTSHOTGUN', 'WEAPON_DBSHOTGUN', 'WEAPON_PUMPSHOTGUN', 'WEAPON_HEAVYSHOTGUN', 'WEAPON_SAWNOFFSHOTGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {'WEAPON_MARKSMANRIFLE', 'WEAPON_SNIPERRIFLE', 'WEAPON_HEAVYSNIPER', 'WEAPON_ASSAULTSNIPER', 'WEAPON_REMOTESNIPER'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {'WEAPON_GRENADELAUNCHER', 'WEAPON_RPG', 'WEAPON_FLAREGUN', 'WEAPON_HOMINGLAUNCHER', 'WEAPON_FIREWORK', 'VEHICLE_WEAPON_TANK'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {'WEAPON_MINIGUN'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {'WEAPON_GRENADE', 'WEAPON_PROXMINE', 'WEAPON_EXPLOSION', 'WEAPON_STICKYBOMB'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {'VEHICLE_WEAPON_ROTORS'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
	for i, CurrentWeapon in ipairs(Weapons) do
		if GetHashKey(CurrentWeapon) == Weapon then
			return true
		end
	end
	return false
end

