Citizen.CreateThread(function()
	local Died = false; PlayingSound = false
	local scaleform
			
    while true do
       Citizen.Wait(0)  
	   
		if not HasThisAdditionalTextLoaded("global", 100) then
			ClearAdditionalText(100, true)
			RequestAdditionalText("global", 100)
			while not HasThisAdditionalTextLoaded("global", 100) do
				Citizen.Wait(0)
			end
		end
		
		if not HasNamedScaleformMovieLoaded("MP_BIG_MESSAGE_FREEMODE") then
			scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
			while not HasNamedScaleformMovieLoaded("MP_BIG_MESSAGE_FREEMODE") do
				Citizen.Wait(0)
			end
		end

		if IsPlayerDead(PlayerId()) then
			local PedKiller = GetPedKiller(PlayerPedId())
			local DeathCauseHash = GetPedCauseOfDeath(PlayerPedId())
			local Killer, DeathReason
			local KilledPlayer = PlayerId()
			
			if IsPedAPlayer(PedKiller) then
				Killer = NetworkGetPlayerIndexFromPed(PedKiller)
			else
				Killer = nil
			end
			

			if (Killer == PlayerId()) then
				DeathReason = GetLabelText("DM_U_SUIC")
			elseif (Killer == nil) then
				DeathReason = GetLabelText("DM_TK_YD1")
			else
				if DeathCauseHash == GetHashKey("WEAPON_CROWBAR") or DeathCauseHash == GetHashKey("WEAPON_BAT") or 
				   DeathCauseHash == GetHashKey("WEAPON_UNARMED") or  DeathCauseHash == GetHashKey("WEAPON_GOLFCLUB") or
				   DeathCauseHash == GetHashKey("WEAPON_HAMMER") or  DeathCauseHash == GetHashKey("WEAPON_NIGHTSTICK") then
					DeathReason = GetLabelText("DM_TK_MELEE1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_MOLOTOV") then
					DeathReason = GetLabelText("DM_TK_TORCH1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_DAGGER") or DeathCauseHash == GetHashKey("WEAPON_KNIFE") or
					   DeathCauseHash == GetHashKey("WEAPON_SWITCHBLADE") or DeathCauseHash == GetHashKey("WEAPON_HATCHET") or
					   DeathCauseHash == GetHashKey("WEAPON_BOTTLE") then
					DeathReason = GetLabelText("DM_TK_TORCH1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_SNSPISTOL") or DeathCauseHash == GetHashKey("WEAPON_HEAVYPISTOL") or
					   DeathCauseHash == GetHashKey("WEAPON_VINTAGEPISTOL") or DeathCauseHash == GetHashKey("WEAPON_PISTOL") or
					   DeathCauseHash == GetHashKey("WEAPON_APPISTOL") or DeathCauseHash == GetHashKey("WEAPON_COMBATPISTOL") then
					DeathReason = GetLabelText("DM_TK_PISTOL1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_MICROSMG") or DeathCauseHash == GetHashKey("WEAPON_SMG") then
					DeathReason = GetLabelText("DM_TK_SUB1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_CARBINERIFLE") or DeathCauseHash == GetHashKey("WEAPON_MUSKET") or
					   DeathCauseHash == GetHashKey("WEAPON_ADVANCEDRIFLE") or DeathCauseHash == GetHashKey("WEAPON_ASSAULTRIFLE") or
					   DeathCauseHash == GetHashKey("WEAPON_SPECIALCARBINE") or DeathCauseHash == GetHashKey("WEAPON_COMPACTRIFLE") or
					   DeathCauseHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
					DeathReason = GetLabelText("DM_TK_ARIFLE1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_MG") or DeathCauseHash == GetHashKey("WEAPON_COMBATMG") then
					DeathReason = GetLabelText("DM_TK_LIGHT1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") or DeathCauseHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") or
					   DeathCauseHash == GetHashKey("WEAPON_DBSHOTGUN") or DeathCauseHash == GetHashKey("WEAPON_PUMPSHOTGUN") or
					   DeathCauseHash == GetHashKey("WEAPON_HEAVYSHOTGUN") or DeathCauseHash == GetHashKey("WEAPON_SAWNOFFSHOTGUN") then
					DeathReason = GetLabelText("DM_TK_SHOT1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_MARKSMANRIFLE") or DeathCauseHash == GetHashKey("WEAPON_SNIPERRIFLE") or
					   DeathCauseHash == GetHashKey("WEAPON_HEAVYSNIPER") or DeathCauseHash == GetHashKey("WEAPON_ASSAULTSNIPER") or
					   DeathCauseHash == GetHashKey("WEAPON_REMOTESNIPER") then
					DeathReason = GetLabelText("DM_TK_SNIPE1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_GRENADELAUNCHER") or DeathCauseHash == GetHashKey("WEAPON_RPG") or
					   DeathCauseHash == GetHashKey("WEAPON_FLAREGUN") or DeathCauseHash == GetHashKey("WEAPON_HOMINGLAUNCHER") or
					   DeathCauseHash == GetHashKey("WEAPON_FIREWORK") then
					DeathReason = GetLabelText("DM_TK_HEAVY1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_MINIGUN") then
					DeathReason = GetLabelText("DM_TK_MINI1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_GRENADE") or DeathCauseHash == GetHashKey("WEAPON_PROXMINE") or
					   DeathCauseHash == GetHashKey("WEAPON_EXPLOSION") or DeathCauseHash == GetHashKey("WEAPON_STICKYBOMB") then
					DeathReason = GetLabelText("DM_TK_BOMB1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_BZGAS") then
					DeathReason = GetLabelText("DM_TK_GAS1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("VEHICLE_WEAPON_TANK") then
					DeathReason = GetLabelText("DM_TK_HEAVY1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("VEHICLE_WEAPON_ROTORS") then
					DeathReason = GetLabelText("DM_TK_VEH1"):gsub("~a~", GetPlayerName(Killer))
				elseif DeathCauseHash == GetHashKey("WEAPON_RUN_OVER_BY_CAR") or DeathCauseHash == GetHashKey("WEAPON_RAMMED_BY_CAR") then
					DeathReason = GetLabelText("DM_TK_VK1"):gsub("~a~", GetPlayerName(Killer))
				else
					DeathReason = GetLabelText("DM_TICK1"):gsub("~a~", GetPlayerName(Killer))
				end
			end
			
			if not Died then
				ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
			end
				
			StartScreenEffect("DeathFailOut", 0, 0)

			if not PlayingSound then
				PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
				PlayingSound = true
			end
			
			PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
			PushScaleformMovieFunctionParameterString(GetLabelText("RESPAWN_W"))
			PushScaleformMovieFunctionParameterString(DeathReason)
			PopScaleformMovieFunctionVoid()
			
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

			Died = true
		else
			if Died then
				StopScreenEffect("DeathFailOut")
				Died = false
				PlayingSound = false
			end
		end
    end
end)