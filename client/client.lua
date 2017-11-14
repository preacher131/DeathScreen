Citizen.CreateThread(function()
	local TimeDelay = 500
	local Died = false; PlayingSound = false; delay = true; alpha = 0
	local scaleform
			
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
		
		if IsPlayerDead(PlayerId()) then
			local PedKiller = GetPedKiller(PlayerPedId())
			local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			local Killer, DeathReason, INT
			local KilledPlayer = PlayerId()
			
			if IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			else
				Killer = nil
			end
			
			if (Killer == PlayerId()) then
				DeathReason = GetLabelText('DM_U_SUIC')
			elseif (Killer == nil) then
				DeathReason = GetLabelText('DM_TK_YD1')
			else
				if DeathCauseHash == GetHashKey('WEAPON_CROWBAR') or DeathCauseHash == GetHashKey('WEAPON_BAT') or 
				   DeathCauseHash == GetHashKey('WEAPON_UNARMED') or  DeathCauseHash == GetHashKey('WEAPON_GOLFCLUB') or
				   DeathCauseHash == GetHashKey('WEAPON_HAMMER') or  DeathCauseHash == GetHashKey('WEAPON_NIGHTSTICK') then
					INT = GetRandomIntInRange(0, 4)
					DeathReason = 'DM_TK_MELEE1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_MOLOTOV') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_TORCH1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_DAGGER') or DeathCauseHash == GetHashKey('WEAPON_KNIFE') or
					   DeathCauseHash == GetHashKey('WEAPON_SWITCHBLADE') or DeathCauseHash == GetHashKey('WEAPON_HATCHET') or
					   DeathCauseHash == GetHashKey('WEAPON_BOTTLE') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_KNIFE1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_SNSPISTOL') or DeathCauseHash == GetHashKey('WEAPON_HEAVYPISTOL') or
					   DeathCauseHash == GetHashKey('WEAPON_VINTAGEPISTOL') or DeathCauseHash == GetHashKey('WEAPON_PISTOL') or
					   DeathCauseHash == GetHashKey('WEAPON_APPISTOL') or DeathCauseHash == GetHashKey('WEAPON_COMBATPISTOL') then
					INT = GetRandomIntInRange(0, 1)
					DeathReason = 'DM_TK_PISTOL1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_MICROSMG') or DeathCauseHash == GetHashKey('WEAPON_SMG') then
					INT = GetRandomIntInRange(0, 3)
					DeathReason = 'DM_TK_SUB1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_CARBINERIFLE') or DeathCauseHash == GetHashKey('WEAPON_MUSKET') or
					   DeathCauseHash == GetHashKey('WEAPON_ADVANCEDRIFLE') or DeathCauseHash == GetHashKey('WEAPON_ASSAULTRIFLE') or
					   DeathCauseHash == GetHashKey('WEAPON_SPECIALCARBINE') or DeathCauseHash == GetHashKey('WEAPON_COMPACTRIFLE') or
					   DeathCauseHash == GetHashKey('WEAPON_BULLPUPRIFLE') then
					INT = GetRandomIntInRange(0, 3)
					DeathReason = 'DM_TK_ARIFLE1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_MG') or DeathCauseHash == GetHashKey('WEAPON_COMBATMG') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_LIGHT1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_BULLPUPSHOTGUN') or DeathCauseHash == GetHashKey('WEAPON_ASSAULTSHOTGUN') or
					   DeathCauseHash == GetHashKey('WEAPON_DBSHOTGUN') or DeathCauseHash == GetHashKey('WEAPON_PUMPSHOTGUN') or
					   DeathCauseHash == GetHashKey('WEAPON_HEAVYSHOTGUN') or DeathCauseHash == GetHashKey('WEAPON_SAWNOFFSHOTGUN') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_SHOT1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_MARKSMANRIFLE') or DeathCauseHash == GetHashKey('WEAPON_SNIPERRIFLE') or
					   DeathCauseHash == GetHashKey('WEAPON_HEAVYSNIPER') or DeathCauseHash == GetHashKey('WEAPON_ASSAULTSNIPER') or
					   DeathCauseHash == GetHashKey('WEAPON_REMOTESNIPER') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_SNIPE1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_GRENADELAUNCHER') or DeathCauseHash == GetHashKey('WEAPON_RPG') or
					   DeathCauseHash == GetHashKey('WEAPON_FLAREGUN') or DeathCauseHash == GetHashKey('WEAPON_HOMINGLAUNCHER') or
					   DeathCauseHash == GetHashKey('WEAPON_FIREWORK') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_HEAVY1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_MINIGUN') then
					INT = GetRandomIntInRange(0, 3)
					DeathReason = 'DM_TK_MINI1' .. INT
				elseif DeathCauseHash == GetHashKey('WEAPON_GRENADE') or DeathCauseHash == GetHashKey('WEAPON_PROXMINE') or
					   DeathCauseHash == GetHashKey('WEAPON_EXPLOSION') or DeathCauseHash == GetHashKey('WEAPON_STICKYBOMB') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_BOMB1' .. INT
				elseif DeathCauseHash == GetHashKey('VEHICLE_WEAPON_TANK') then
					INT = GetRandomIntInRange(0, 2)
					DeathReason = 'DM_TK_HEAVY1' .. INT
				elseif DeathCauseHash == GetHashKey('VEHICLE_WEAPON_ROTORS') then
					DeathReason = 'DM_TK_VEH1'
				elseif DeathCauseHash == GetHashKey('WEAPON_RUN_OVER_BY_CAR') or DeathCauseHash == GetHashKey('WEAPON_RAMMED_BY_CAR') then
					DeathReason = 'DM_TK_VK1'
				else
					DeathReason = 'DM_TICK1'
				end
				DeathReason = GetLabelText(DeathReason):gsub('~a~', GetPlayerName(Killer))
			end
			
			PlaySoundFrontend(-1, 'Bed', 'WastedSounds', 1)
			
			ShakeGameplayCam('DEATH_FAIL_IN_EFFECT_SHAKE', 1.0)
			StartScreenEffect('DeathFailOut', 0, 0)

			PushScaleformMovieFunction(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
			PushScaleformMovieFunctionParameterString(GetLabelText('RESPAWN_W'))
			PushScaleformMovieFunctionParameterString(DeathReason)
			PopScaleformMovieFunctionVoid()
			
			Citizen.Wait(500)
				
			while IsPlayerDead(PlayerId()) do
				Citizen.Wait(0)
				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			end
			
			StopScreenEffect('DeathFailOut')
		end
    end
end)
