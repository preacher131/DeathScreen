AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

Citizen.CreateThread(function()
	local ScaleformDM, ScaleformIB, X, Y, W; H = 0.0125
	local CheckPoint
	
	RequestScriptAudioBank('MP_WASTED', 0)
	
	while true do
		Citizen.Wait(0)

		if not HasScaleformMovieLoaded(ScaleformDM) then
			ScaleformDM = RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
			while not HasScaleformMovieLoaded(ScaleformDM) do
				Citizen.Wait(0)
			end
		end
		
		if not HasScaleformMovieLoaded(ScaleformIB) then
			ScaleformIB = RequestScaleformMovie('INSTRUCTIONAL_BUTTONS')
			while not HasScaleformMovieLoaded(ScaleformIB) do
				Citizen.Wait(0)
			end
		end
		
		if not HasStreamedTextureDictLoaded('TIMERBARS') then
			RequestStreamedTextureDict('TIMERBARS')
			while not HasStreamedTextureDictLoaded('TIMERBARS') do
				Citizen.Wait(0)
			end
		end
		
		if IsPlayerDead(PlayerId()) then
			ClearHelp(1)
			
			local PedKiller = GetPedSourceOfDeath(PlayerPedId())
			local Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller, INT

			if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			elseif IsEntityAVehicle(PedKiller) and IsEntityAPed(GetPedInVehicleSeat(PedKiller, -1)) and IsPedAPlayer(GetPedInVehicleSeat(PedKiller, -1)) then
				Killer = NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(PedKiller, -1))
			end
			
			if (Killer == PlayerId()) then
				DeathReasonVictim = 'DM_U_SUIC'
				DeathReasonOthers = 'DM_O_SUIC'
			elseif (Killer == nil) then
				DeathReasonVictim = 'DM_TK_YD1'
				DeathReasonOthers = 'TICK_DIED'
			else
				DeathReasonKiller, DeathReasonVictim, DeathReasonOthers = GetReason(GetPedCauseOfDeath(PlayerPedId()))
			end
			
			if N_0x35fb78dc42b7bd21() then
				StartScreenEffect('DeathFailMPDark', 0, 0)
			else
				StartScreenEffect('DeathFailMPIn', 0, 0)
			end
			ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
			SetCamEffect(2)
			
			TriggerServerEvent(GetCurrentResourceName() .. ':SendDeathMessage', PlayerId(), Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller)
			
			Citizen.Wait(750)
			
			PlaySoundFrontend(-1, 'MP_Flash', 'WastedSounds', true)

			BeginScaleformMovieMethod(ScaleformDM, 'SHOW_SHARD_WASTED_MP_MESSAGE')
			PushScaleformMovieMethodParameterString(GetLabelText('RESPAWN_W_MP'))
			if DeathReasonVictim == 'DM_TK_YD1' then
				PushScaleformMovieMethodParameterString('')
			else
				PushScaleformMovieMethodParameterString(GetLabelText(DeathReasonVictim):gsub('~a~', '~bold~' .. GetPlayerName(Killer) .. '~bold~'))
			end
			PushScaleformMovieMethodParameterInt(6)
			EndScaleformMovieMethod()
			
			local timer = GetGameTimer()
				
			while IsPlayerDead(PlayerId()) do
				Citizen.Wait(0)
				
				HideHudComponentThisFrame(1)
				HideHudComponentThisFrame(2)
				HideHudComponentThisFrame(3)
				HideHudComponentThisFrame(4)
				HideHudComponentThisFrame(5)
				HideHudComponentThisFrame(6)
				HideHudComponentThisFrame(7)
				HideHudComponentThisFrame(8)
				HideHudComponentThisFrame(9)
				HideHudComponentThisFrame(13)
				HideHudComponentThisFrame(14)
				HideHudComponentThisFrame(15)
				HideHudComponentThisFrame(16)
				HideHudComponentThisFrame(17)
				HideHudComponentThisFrame(19)
				N_0x7669f9e39dc17063()

				DrawScaleformMovieFullscreen(ScaleformDM, 255, 255, 255, 255)
				
				if Killer and Killer ~= PlayerId() then
					DrawScaleformMovieFullscreen(ScaleformIB, 255, 255, 255, 0)
					BeginScaleformMovieMethod(ScaleformIB, 'CLEAR_ALL')
					EndScaleformMovieMethod()
					BeginScaleformMovieMethod(ScaleformIB, 'SET_CLEAR_SPACE')
					PushScaleformMovieMethodParameterInt(200)
					EndScaleformMovieMethod()
					
					BeginScaleformMovieMethod(ScaleformIB, 'SET_DATA_SLOT')
					PushScaleformMovieMethodParameterInt(0)
					if GetLastInputMethod(2) then
						PushScaleformMovieMethodParameterInt(100)
					else
						PushScaleformMovieMethodParameterInt(30)
					end
					BeginTextCommandScaleformString('STRING')
					AddTextComponentScaleform(GetLabelText('HUD_INPUT97'))
					EndTextCommandScaleformString()	
					EndScaleformMovieMethod()

					BeginScaleformMovieMethod(ScaleformIB, 'DRAW_INSTRUCTIONAL_BUTTONS')
					EndScaleformMovieMethod()
					BeginScaleformMovieMethod(ScaleformIB, 'SET_BACKGROUND_COLOUR')
					PushScaleformMovieMethodParameterInt(0)
					PushScaleformMovieMethodParameterInt(0)
					PushScaleformMovieMethodParameterInt(0)
					PushScaleformMovieMethodParameterInt(60)
					EndScaleformMovieMethod()

					if FasterRespawnClicked() and GetTimeDifference(GetGameTimer(), timer) < 11800 then
						PlaySoundFrontend(-1, 'Faster_Click', 'RESPAWN_ONLINE_SOUNDSET', true)
						timer = GetTimeDifference(timer, 500)
					end

					if GetTimeDifference(GetGameTimer(), timer) < 12000 then
						W = (GetTimeDifference(GetGameTimer(), timer) * (0.085 / 12000))
					end
					
					local correction = ((1.0 - round(GetSafeZoneSize(), 2)) * 100) * 0.005
					X, Y = 0.9095 - correction, 0.94 - correction
					
					Set_2dLayer(0)
					DrawSprite('TimerBars', 'ALL_BLACK_bg', X, Y, 0.15, 0.0305, 0.0, 255, 255, 255, 180)
					
					Set_2dLayer(1)
					DrawRect(X + 0.0275, Y, 0.085, 0.0095, 100, 0, 0, 180)
					
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
						if IsEntityAPed(PedKiller) and IsPedAPlayer(PedKiller) then
							DisableAllControlActions(0)

							SetCamEffect(0)
							SetFocusEntity(PedKiller)
							NetworkSetOverrideSpectatorMode(true)
							NetworkSetInSpectatorMode(true, PedKiller)
							SetCinematicModeActive(true)
						end
					end
					

					if GetTimeDifference(GetGameTimer(), timer) >= 12000 then
						PlaySoundFrontend(-1, 'Faster_Bar_Full', 'RESPAWN_ONLINE_SOUNDSET', true)
						Citizen.Wait(500)
						exports.spawnmanager:spawnPlayer()
					end
				else
					if GetTimeDifference(GetGameTimer(), timer) >= 3800 then
						exports.spawnmanager:spawnPlayer()
					end
				end
			end
			
			SetCamEffect(0)
			
			if GetScreenEffectIsActive('DeathFailMPDark') then
				StopScreenEffect('DeathFailMPDark')
			elseif GetScreenEffectIsActive('DeathFailMPIn') then
				StopScreenEffect('DeathFailMPIn')
			end
			
			if IsGameplayCamShaking() then
				StopGameplayCamShaking(false)
			end
			
			if NetworkIsInSpectatorMode() then
				SetCinematicModeActive(false)
				NetworkSetOverrideSpectatorMode(false)
				NetworkSetInSpectatorMode(false, PedKiller)
			end
			
			SetFocusEntity(PlayerPedId())
		end
	end
end)

RegisterNetEvent(GetCurrentResourceName() .. ':PrintDeathMessage')
AddEventHandler(GetCurrentResourceName() .. ':PrintDeathMessage', function(Victim, Killer, DeathReasonVictim, DeathReasonOthers, DeathReasonKiller) --Prints the Death Message
	if (Victim == PlayerId()) then
		drawNotification(GetLabelText(DeathReasonVictim):gsub('~a~', '~bold~' .. GetPlayerName(Killer) .. '~bold~'))
	elseif (Killer == PlayerId()) then
		drawNotification(GetLabelText(DeathReasonKiller):gsub('~a~', '~bold~' .. GetPlayerName(Victim) .. '~bold~'))
	else
		if Killer then
			drawNotification(GetLabelText(DeathReasonOthers):gsub('~a~', '~bold~' .. GetPlayerName(Killer) .. '~bold~', 1):gsub('~a~', '~bold~' .. GetPlayerName(Victim) .. '~bold~'))
		else
			drawNotification(GetLabelText(DeathReasonOthers):gsub('~a~', '~bold~' .. GetPlayerName(Victim) .. '~bold~'))
		end
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

function GetIsControlJustPressed(Control)
	if IsControlJustPressed(1, Control) or IsDisabledControlJustPressed(1, Control) then
		return true
	end
	return false
end

function IsMelee(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_UNARMED'),
					 GetHashKey('WEAPON_BAT'),
					 GetHashKey('WEAPON_NIGHTSTICK'),
					 GetHashKey('WEAPON_HAMMER'),
					 GetHashKey('WEAPON_CROWBAR'),
					 GetHashKey('WEAPON_GOLFCLUB'),
					 GetHashKey('WEAPON_KNUCKLE'),
					 GetHashKey('WEAPON_HATCHET'),
					 GetHashKey('WEAPON_POOLCUE'),
					 GetHashKey('WEAPON_WRENCH'),
					 GetHashKey('WEAPON_FLASHLIGHT'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsTorch(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_MOLOTOV'),
					 GetHashKey('WEAPON_FIRE'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsKnife(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_KNIFE'),
					 GetHashKey('WEAPON_BOTTLE'),
					 GetHashKey('WEAPON_DAGGER'),
					 GetHashKey('WEAPON_BATTLEAXE'),
					 GetHashKey('WEAPON_MACHETE'),
					 GetHashKey('WEAPON_SWITCHBLADE'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsPistol(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_PISTOL'),
					 GetHashKey('WEAPON_COMBATPISTOL'),
					 GetHashKey('WEAPON_APPISTOL'),
					 GetHashKey('WEAPON_SNSPISTOL'),
					 GetHashKey('WEAPON_HEAVYPISTOL'),
					 GetHashKey('WEAPON_VINTAGEPISTOL'),
					 GetHashKey('WEAPON_MARKSMANPISTOL'),
					 GetHashKey('WEAPON_MACHINEPISTOL'),
					 GetHashKey('WEAPON_REVOLVER'),
					 GetHashKey('WEAPON_PISTOL50'),
					 GetHashKey('WEAPON_PISTOL_MK2'),
					 GetHashKey('WEAPON_DOUBLEACTION'),
					 GetHashKey('WEAPON_REVOLVER_MK2'),
					 GetHashKey('WEAPON_SNSPISTOL_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsSub(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_SMG'),
					 GetHashKey('WEAPON_MICROSMG'),
					 GetHashKey('WEAPON_COMBATPDW'),
					 GetHashKey('WEAPON_MINISMG'),
					 GetHashKey('WEAPON_ASSAULTSMG'),
					 GetHashKey('WEAPON_GUSENBERG'),
					 GetHashKey('WEAPON_SMG_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsRifle(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_ASSAULTRIFLE'),
					 GetHashKey('WEAPON_CARBINERIFLE'),
					 GetHashKey('WEAPON_CARBINERIFLE_MK2'),
					 GetHashKey('WEAPON_ADVANCEDRIFLE'),
					 GetHashKey('WEAPON_ASSAULTRIFLE_MK2'),
					 GetHashKey('WEAPON_SPECIALCARBINE'),
					 GetHashKey('WEAPON_BULLPUPRIFLE'),
					 GetHashKey('WEAPON_MUSKET'),
					 GetHashKey('WEAPON_COMPACTRIFLE'),
					 GetHashKey('WEAPON_BULLPUPRIFLE_MK2'),
					 GetHashKey('WEAPON_SPECIALCARBINE_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsLight(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_MG'),
					 GetHashKey('WEAPON_COMBATMG'),
					 GetHashKey('VEHICLE_WEAPON_PLAYER_BULLET'),
					 GetHashKey('WEAPON_COMBATMG_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsShotgun(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_PUMPSHOTGUN'),
					 GetHashKey('WEAPON_SAWNOFFSHOTGUN'),
					 GetHashKey('WEAPON_ASSAULTSHOTGUN'),
					 GetHashKey('WEAPON_BULLPUPSHOTGUN'),
					 GetHashKey('WEAPON_HEAVYSHOTGUN'),
					 GetHashKey('WEAPON_DBSHOTGUN'),
					 GetHashKey('WEAPON_AUTOSHOTGUN'),
					 GetHashKey('WEAPON_PUMPSHOTGUN_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsSniper(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_HEAVYSNIPER'),
					 GetHashKey('WEAPON_REMOTESNIPER'),
					 GetHashKey('WEAPON_SNIPERRIFLE'),
					 GetHashKey('WEAPON_SNIPER_ASSAULT'),
					 GetHashKey('WEAPON_MARKSMANRIFLE'),
					 GetHashKey('WEAPON_HEAVYSNIPER_MK2'),
					 GetHashKey('WEAPON_MARKSMANRIFLE_MK2'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsHeavy(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_EXPLOSION'),
					 GetHashKey('WEAPON_GRENADELAUNCHER'),
					 GetHashKey('WEAPON_FLAREGUN'),
					 GetHashKey('WEAPON_RPG'),
					 GetHashKey('WEAPON_VEHICLE_ROCKET'),
					 GetHashKey('WEAPON_RAILGUN'),
					 GetHashKey('WEAPON_FIREWORK'),
					 GetHashKey('WEAPON_HOMINGLAUNCHER'),
					 GetHashKey('WEAPON_COMPACTLAUNCHER'),
					 GetHashKey('WEAPON_AIRSTRIKE_ROCKET'),
					 GetHashKey('VEHICLE_WEAPON_TURRET_TECHNICAL'),
					 GetHashKey('VEHICLE_WEAPON_SPACE_ROCKET'),
					 GetHashKey('VEHICLE_WEAPON_PLAYER_LASER'),
					 GetHashKey('VEHICLE_WEAPON_PLAYER_BUZZARD'),
					 GetHashKey('WEAPON_PASSENGER_ROCKET'),
					 GetHashKey('VEHICLE_WEAPON_PLANE_ROCKET'),
					 -901318531,
					 1177935125,
					 GetHashKey('VEHICLE_WEAPON_PLAYER_SAVAGE'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsMinigun(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_MINIGUN'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsBomb(Weapon)
	local Weapons = {
				 GetHashKey('WEAPON_STICKYBOMB'),
				 GetHashKey('WEAPON_GRENADE'),
				 GetHashKey('WEAPON_PROXMINE'),
				 GetHashKey('WEAPON_PIPEBOMB'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsBZGas(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_BZGAS'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsTank(Weapon)
	local Weapons = {
					 GetHashKey('VEHICLE_WEAPON_TANK'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsVeh(Weapon)
	local Weapons = {
					 GetHashKey('VEHICLE_WEAPON_ROTORS'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function IsVK(Weapon)
	local Weapons = {
					 GetHashKey('WEAPON_RAMMED_BY_CAR'),
					 GetHashKey('WEAPON_RUN_OVER_BY_CAR'),
					}
	for i, CurrentWeapon in ipairs(Weapons) do
		if CurrentWeapon == Weapon then
			return true
		end
	end
	return false
end

function GetReason(DeathCauseHash)
	local DeathReasonKiller, DeathReasonVictim, DeathReasonOthers
	if WasPedKilledByStealth(PlayerPedId()) or WasPedKilledByTakedown(PlayerPedId()) then
		DeathReasonKiller = 'DM_TK_EXE0'
		DeathReasonVictim = 'DM_TK_EXE1'
		DeathReasonOthers = 'DM_TK_EXE2'
	elseif IsMelee(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 4)
		DeathReasonKiller = 'DM_TK_MELEE0' .. INT
		DeathReasonVictim = 'DM_TK_MELEE1' .. INT
		DeathReasonOthers = 'DM_TK_MELEE2' .. INT
	elseif IsTorch(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_TORCH0' .. INT
		DeathReasonVictim = 'DM_TK_TORCH1' .. INT
		DeathReasonOthers = 'DM_TK_TORCH2' .. INT
	elseif IsKnife(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_KNIFE0' .. INT
		DeathReasonVictim = 'DM_TK_KNIFE1' .. INT
		DeathReasonOthers = 'DM_TK_KNIFE2' .. INT
	elseif IsPistol(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 1)
		DeathReasonKiller = 'DM_TK_PISTOL0' .. INT
		DeathReasonVictim = 'DM_TK_PISTOL1' .. INT
		DeathReasonOthers = 'DM_TK_PISTOL2' .. INT
	elseif IsSub(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 3)
		DeathReasonKiller = 'DM_TK_SUB0' .. INT
		DeathReasonVictim = 'DM_TK_SUB1' .. INT
		DeathReasonOthers = 'DM_TK_SUB2' .. INT
	elseif IsRifle(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 3)
		DeathReasonKiller = 'DM_TK_ARIFLE0' .. INT
		DeathReasonVictim = 'DM_TK_ARIFLE1' .. INT
		DeathReasonOthers = 'DM_TK_ARIFLE2' .. INT
	elseif IsLight(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_LIGHT0' .. INT
		DeathReasonVictim = 'DM_TK_LIGHT1' .. INT
		DeathReasonOthers = 'DM_TK_LIGHT2' .. INT
	elseif IsShotgun(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_SHOT0' .. INT
		DeathReasonVictim = 'DM_TK_SHOT1' .. INT
		DeathReasonOthers = 'DM_TK_SHOT2' .. INT
	elseif IsSniper(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_SNIPE0' .. INT
		DeathReasonVictim = 'DM_TK_SNIPE1' .. INT
		DeathReasonOthers = 'DM_TK_SNIPE2' .. INT
	elseif IsHeavy(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_HEAVY0' .. INT
		DeathReasonVictim = 'DM_TK_HEAVY1' .. INT
		DeathReasonOthers = 'DM_TK_HEAVY2' .. INT
	elseif IsMinigun(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 3)
		DeathReasonKiller = 'DM_TK_MINI0' .. INT
		DeathReasonVictim = 'DM_TK_MINI1' .. INT
		DeathReasonOthers = 'DM_TK_MINI2' .. INT
	elseif IsBomb(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 2)
		DeathReasonKiller = 'DM_TK_BOMB0' .. INT
		DeathReasonVictim = 'DM_TK_BOMB1' .. INT
		DeathReasonOthers = 'DM_TK_BOMB2' .. INT
	elseif IsBZGas(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 1)
		DeathReasonKiller = 'DM_TK_GAS0' .. INT
		DeathReasonVictim = 'DM_TK_GAS1' .. INT
		DeathReasonOthers = 'DM_TK_GAS2' .. INT
	elseif IsTank(DeathCauseHash) then
		INT = GetRandomIntInRange(0, 1)
		DeathReasonKiller = 'DM_TK_HEAVY0' .. INT
		DeathReasonVictim = 'DM_TK_HEAVY1' .. INT
		DeathReasonOthers = 'DM_TK_HEAVY2' .. INT
	elseif IsVeh(DeathCauseHash) then
		DeathReasonKiller = 'DM_TK_VEH0'
		DeathReasonVictim = 'DM_TK_VEH1'
		DeathReasonOthers = 'DM_TK_VEH2'
	elseif IsVK(DeathCauseHash) then
		DeathReasonKiller = 'DM_TK_VK0'
		DeathReasonVictim = 'DM_TK_VK1'
		DeathReasonOthers = 'DM_TK_VK2'
	else
		DeathReasonKiller = 'DM_TICK2'
		DeathReasonVictim = 'DM_TICK1'
		DeathReasonOthers = 'DM_TICK6'
	end
	return DeathReasonKiller, DeathReasonVictim, DeathReasonOthers
end

function FasterRespawnClicked()
	if (IsInputDisabled(2) and GetIsControlJustPressed(237)) or
	(not IsInputDisabled(2) and GetIsControlJustPressed(201)) then
		return true
	end
	return false
end

