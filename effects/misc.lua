local TVPlaylists = {
    "PL_WEB_KFLF", -- Kung Fu Rainbow Lazerforce
    "PL_WEB_RANGERS", -- Republican Space Rangers
    "PL_WEB_PRB2", -- Princess Robot Bubblegum
    "PL_WEB_FOS", -- Fame or Shame
    "PL_WEB_CAS", -- Diamond Casino DLC intro
    "PL_WEB_FOS",
    "PL_WEB_HOWITZER", -- Howitzer Documentary
    "PL_WEB_KFLF",
    "PL_WEB_PRB2",
    "PL_WEB_RS",
    "PL_STD_CNT",
    "PL_STD_WZL",
    "PL_LO_CNT",
    "PL_LO_WZL",
    "PL_SP_WORKOUT",
    "PL_SP_INV",
    "PL_SP_INV_EXP",
    "PL_LO_RS",
    "PL_LO_RS_CUTSCENE",
    "PL_SP_PLSH1_INTRO",
    "PL_LES1_FAME_OR_SHAME",
    "PL_STD_WZL_FOS_EP2",
    "PL_MP_WEAZEL",
    "PL_MP_CCTV",
    "PL_CINEMA_CARTOON",
    "PL_CINEMA_ARTHOUSE",
    "PL_CINEMA_ACTION",
    "PL_CINEMA_MULTIPLAYER",
    "PL_CINEMA_MULTIPLAYER_NO_MELTDOWN"
}

local VehicleModels = {
    "adder", "airbus", "airtug", "akuma", "ambulance", "annihilator", "armytanker", "armytrailer", "armytrailer2", "asea", "asea2", "asterope", "bagger",
    "baletrailer", "baller", "baller2", "banshee", "barracks", "barracks2", "bati", "bati2", "benson", "bfinjection", "biff", "bison", "bison2", "bison3",
    "bjxl", "blazer", "blazer2", "blazer3", "blimp", "blista", "bmx", "boattrailer", "bobcatxl", "bodhi2", "boxville", "boxville2", "boxville3", "buccaneer",
    "buffalo", "buffalo2", "bulldozer", "bullet", "burrito", "burrito2", "burrito3", "burrito4", "burrito5", "bus", "buzzard", "buzzard2", "cablecar",
    "caddy", "caddy2", "camper", "carbonizzare", "carbonrs", "cargobob", "cargobob2", "cargobob3", "cargoplane", "cavalcade", "cavalcade2", "cheetah",
    "coach", "cogcabrio", "comet2", "coquette", "cruiser", "crusader", "cuban800", "cutter", "daemon", "dilettante", "dilettante2", "dinghy", "dinghy2",
    "dloader", "docktrailer", "docktug", "dominator", "double", "dubsta", "dubsta2", "dump", "dune", "dune2", "duster", "elegy2", "emperor", "emperor2",
    "emperor3", "entityxf", "exemplar", "f620", "faggio2", "fbi", "fbi2", "felon", "felon2", "feltzer2", "firetruk", "fixter", "flatbed", "forklift", "fq2",
    "freight", "freightcar", "freightcont1", "freightcont2", "freightgrain", "freighttrailer", "frogger", "frogger2", "fugitive", "fusilade", "futo",
    "gauntlet", "gburrito", "graintrailer", "granger", "gresley", "habanero", "handler", "hauler", "hexer", "hotknife", "infernus", "ingot", "intruder",
    "issi2", "jackal", "jb700", "jet", "jetmax", "journey", "khamelion", "landstalker", "lazer", "lguard", "luxor", "mammatus", "manana", "marquis", "maverick",
    "mesa", "mesa2", "mesa3", "metrotrain", "minivan", "mixer", "mixer2", "monroe", "mower", "mule", "mule2", "nemesis", "ninef", "ninef2", "oracle", "oracle2",
    "packer", "patriot", "pbus", "pcj", "penumbra", "peyote", "phantom", "phoenix", "picador", "police", "police2", "police3", "police4", "policeb",
    "policeold1", "policeold2", "policet", "polmav", "pony", "pony2", "pounder", "prairie", "pranger", "predator", "premier", "primo", "proptrailer",
    "radi", "raketrailer", "rancherxl", "rancherxl2", "rapidgt", "rapidgt2", "ratloader", "rebel", "rebel2", "regina", "rentalbus", "rhino", "riot",
    "ripley", "rocoto", "romero", "rubble", "ruffian", "ruiner", "rumpo", "rumpo2", "sabregt", "sadler", "sadler2", "sanchez", "sanchez2", "sandking",
    "sandking2", "schafter2", "schwarzer", "scorcher", "scrap", "seashark", "seashark2", "seminole", "sentinel", "sentinel2", "serrano", "shamal", "sheriff",
    "sheriff2", "skylift", "speedo", "speedo2", "squalo", "stanier", "stinger", "stingergt", "stockade", "stockade3", "stratum", "stretch", "stunt",
    "submersible", "sultan", "suntrap", "superd", "surano", "surfer", "surfer2", "surge", "taco", "tailgater", "tanker", "tankercar", "taxi", "tiptruck",
    "tiptruck2", "titan", "tornado", "tornado2", "tornado3", "tornado4", "tourbus", "towtruck", "towtruck2", "tr2", "tr3", "tr4", "tractor", "tractor2",
    "tractor3", "trailerlogs", "trailers", "trailers2", "trailers3", "trailersmall", "trash", "trflat", "tribike", "tribike2", "tribike3", "tropic",
    "tvtrailer", "utillitruck", "utillitruck2", "utillitruck3", "vacca", "vader", "velum", "vigero", "voltic", "voodoo2", "washington", "youga", "zion",
    "zion2", "ztype", "bifta", "kalahari", "paradise", "speeder", "btype", "jester", "turismor", "alpha", "vestra", "massacro", "zentorno", "huntley", "thrust",
    "rhapsody", "warrener", "blade", "glendale", "panto", "dubsta3", "pigalle", "monster", "sovereign", "besra", "miljet", "coquette2", "swift", "innovation",
    "hakuchou", "furoregt", "jester2", "massacro2", "ratloader2", "slamvan", "mule3", "velum2", "tanker2", "casco", "boxville4", "hydra", "insurgent",
    "insurgent2", "gburrito2", "technical", "dinghy3", "savage", "enduro", "guardian", "lectro", "kuruma", "kuruma2", "trash2", "barracks3", "valkyrie",
    "slamvan2", "swift2", "luxor2", "feltzer3", "osiris", "virgo", "windsor", "coquette3", "vindicator", "t20", "brawler", "toro", "chino", "submersible2",
    "dukes", "dukes2", "buffalo3", "dominator2", "dodo", "marshall", "blimp2", "gauntlet2", "stalion", "stalion2", "blista2", "blista3", "faction", "faction2",
    "moonbeam", "moonbeam2", "primo2", "chino2", "buccaneer2", "voodoo", "lurcher", "btype2", "verlierer2", "nightshade", "mamba", "limo2", "schafter3",
    "schafter4", "schafter5", "schafter6", "cog55", "cog552", "cognoscenti", "cognoscenti2", "baller3", "baller4", "baller5", "baller6", "toro2", "seashark3",
    "dinghy4", "tropic2", "speeder2", "cargobob4", "supervolito", "supervolito2", "valkyrie2", "tampa", "sultanrs", "banshee2", "btype3", "faction3", "minivan2",
    "sabregt2", "slamvan3", "tornado5", "virgo2", "virgo3", "nimbus", "xls", "xls2", "seven70", "fmj", "bestiagts", "pfister811", "brickade", "rumpo3", "volatus",
    "prototipo", "reaper", "tug", "windsor2", "lynx", "gargoyle", "tyrus", "sheava", "omnis", "le7b", "contender", "trophytruck", "trophytruck2", "rallytruck",
    "cliffhanger", "bf400", "tropos", "brioso", "tampa2", "tornado6", "faggio3", "faggio", "raptor", "vortex", "avarus", "sanctus", "youga2", "hakuchou2",
    "nightblade", "chimera", "esskey", "wolfsbane", "zombiea", "zombieb", "defiler", "daemon2", "ratbike", "shotaro", "manchez", "blazer4", "elegy", "tempesta",
    "italigtb", "italigtb2", "nero", "nero2", "specter", "specter2", "diablous", "diablous2", "blazer5", "ruiner2", "dune4", "dune5", "phantom2", "voltic2",
    "penetrator", "boxville5", "wastelander", "technical2", "fcr", "fcr2", "comet3", "ruiner3", "gp1", "infernus2", "ruston", "turismo2"
}

local function SpawnProp(propName)
    local playerPos = GetEntityCoords(PlayerPedId())

    RequestModel(propName)
    while not HasModelLoaded(propName) do
        Citizen.Wait(100)
    end

    CreateObject(propName, playerPos.x, playerPos.y, playerPos.z, true, false, true)
    SetModelAsNoLongerNeeded(propName)
end

local function SpawnTempVehicle(vehicleModel, spawnPos)
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Citizen.Wait(50)
    end

    local vehicleObject = CreateVehicle(vehicleModel, spawnPos.x, spawnPos.y, spawnPos.z, GetEntityHeading(PlayerPedId()))

    SetModelAsNoLongerNeeded(vehicleModel)

    return vehicleObject
end

RegisterNetEvent('Chaos:Misc:Airstrike', function(duration)
    local function GetRandomOffsetCoord(startCoord, maxOffset)
        return vector3(
            startCoord.x + math.random(-maxOffset, maxOffset),
            startCoord.y + math.random(-maxOffset, maxOffset),
            startCoord.z + math.random(-maxOffset, maxOffset)
        )
    end

    local strikeName = "WEAPON_AIRSTRIKE_ROCKET"
    ---@type integer
    local lastAirStrike = 0

    local exitMethod = false
    exports.helpers:DisplayMessage("Airstrike inbound, bravo out")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            RequestWeaponAsset(strikeName, 31, 0)
            while not HasWeaponAssetLoaded(strikeName) do
                Citizen.Wait(100)
            end

            local currentTime = GetGameTimer()
            if currentTime - lastAirStrike > 750 then
                lastAirStrike = currentTime
                local playerPos = GetEntityCoords(PlayerPedId())
                local startPos = GetRandomOffsetCoord(playerPos, 10)
                local targetPos = GetRandomOffsetCoord(playerPos, 35)

                local onGround, groundZ = GetGroundZFor_3dCoord(targetPos.x, targetPos.y, targetPos.z, false)
                if onGround then
                    ShootSingleBulletBetweenCoords(
                        startPos.x, startPos.y, startPos.z + 200,
                        targetPos.x, targetPos.y, groundZ,
                        200, true, strikeName, 0, true, false, 5000.
                    )
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:Cartoon', function(duration)
    local fPosX = math.random(3, 7) / 10
    local fPosY = math.random(3, 7) / 10

    local randomPlaylist = TVPlaylists[math.random(1, #TVPlaylists)]

    SetTvChannelPlaylistAtHour(0, randomPlaylist, math.random(0, 23))
    SetTvAudioFrontend(true)
    SetTvVolume(2.0)
    AttachTvAudioToEntity(PlayerPedId())
    SetTvChannel(0)
    EnableMovieSubtitles(true)

    local exitMethod = false
    exports.helpers:DisplayMessage("Let's watch some TV")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SetScriptGfxDrawOrder(4)
            SetScriptGfxDrawBehindPausemenu(true)
            DrawTvChannel(fPosX, fPosY, 0.3, 0.3, 0., 255, 255, 255, 255)

            Citizen.Wait(0)
        end
        SetTvChannel(-1)
        SetTvChannelPlaylist(0, "", false)
        EnableMovieSubtitles(false)
    end)
end)

RegisterNetEvent('Chaos:Misc:DVDScreensaver', function(duration)
    local speed = 0.003
    local boxHeightRatio = 0.45
    local goingDown = true
    local goingRight = true

    local exitMethod = false
    exports.helpers:DisplayMessage("DVD Screensaver")

    local resolutionX, resolutionY = GetActiveScreenResolution()
    local boxHeight = boxHeightRatio
    local boxWidth = boxHeight * (resolutionY / resolutionX)
    local offsetX = 0
    local offsetY = 0

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            if goingRight then
                offsetX = offsetX + speed
                if offsetX + boxWidth >= 1 then
                    goingRight = false
                end
            else
                offsetX = offsetX - speed
                if offsetX <= 0 then
                    goingRight = true
                end
            end
            if goingDown then
                offsetY = offsetY + speed
                if offsetY + boxHeight >= 1 then
                    goingDown = false
                end
            else
                offsetY = offsetY - speed
                if offsetY <= 0 then
                    goingDown = true
                end
            end

            DrawRect(0.5, offsetY / 2, 1., offsetY, 0, 0, 0, 255) -- Top bar
            local lowerHeight = 1 - offsetY - boxHeight
            DrawRect(0.5, 1 - lowerHeight / 2, 1., lowerHeight, 0, 0, 0, 255) -- Bottom bar
            DrawRect(offsetX / 2, 0.5, offsetX, 1., 0, 0, 0, 255) -- Left bar
            local rightWidth = (1 - offsetX - boxWidth)
            DrawRect(1 - (rightWidth / 2), 0.5, rightWidth, 1., 0, 0, 0, 255) -- Right bar

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:Earthquake', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("OH GOD IT'S AN EARTHQUAKE")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local shakeAmount = math.random(-9, 7)
            ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 1.0)

            Citizen.Wait(0)
        end
        StopGameplayCamShaking(true)
    end)
end)

---@param duration number
RegisterNetEvent('Chaos:Misc:FakeCrash', function(duration)
    duration = 6
    local textureDict = "chaos_textures"
    RequestStreamedTextureDict(textureDict, true)
    while not HasStreamedTextureDictLoaded(textureDict) do
        Citizen.Wait(100)
    end

    Citizen.SetTimeout(duration * 1000 * 0.2, function() exitMethod = true end)
    Citizen.CreateThread(function()
        TriggerEvent("Client:SoundToClient", "windows_error", 1.0)
        EnterCursorMode()
        while true do
            if exitMethod then
                break
            end

            SetTimeScale(0.2)
            DrawSprite(textureDict, "crash", 0.5, 0.5, 0.26, 0.4, 0., 255, 255, 255, 255)

            Citizen.Wait(0)
        end
        LeaveCursorMode()
        SetTimeScale(1.)
        exports.helpers:DisplayMessage("PRANK'D", false)
    end)
end)

RegisterNetEvent('Chaos:Misc:Fireworks', function(duration)
    ---@type integer
    local lastFirework = 0

    local exitMethod = false
    exports.helpers:DisplayMessage("Katy Perry once sang about me, y'know")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            -- Launch a firework every 500 miliseconds
            local currentTime = GetGameTimer()
            if currentTime - lastFirework > 500 then
                lastFirework = currentTime

                local playerPos = GetEntityCoords(PlayerPedId())

                RequestNamedPtfxAsset("proj_indep_firework_v2")
                while not HasNamedPtfxAssetLoaded("proj_indep_firework_v2") do
                    Citizen.Wait(100)
                end
                UseParticleFxAsset("proj_indep_firework_v2")

                local newX = playerPos.x + math.random(-110, 110)
                local newY = playerPos.y + math.random(-110, 110)
                local newZ = playerPos.z + math.random(50, 150)
                StartParticleFxNonLoopedAtCoord(
                    (math.random(0, 1) == 0) and "scr_firework_indep_ring_burst_rwb" or "scr_firework_indep_spiral_burst_rwb",
                    newX, newY, newZ, 0., 0., 0., 2., true, true, true
                )

                -- Spawn an explosion to make an explosion sound and a screen shake (explosionType 38 = fireworks)
                AddExplosion(newX, newY, newZ, 38, 1.0, true, false, 1.0, false)
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:IntenseMusic', function(duration)
    -- Not very tense
    exports.helpers:DisplayMessage("Wow, very tense.")

    TriggerMusicEvent("AW_LOBBY_MUSIC_START")
    Citizen.SetTimeout(duration * 1000, function() TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START") end)
end)

RegisterNetEvent('Chaos:Misc:InvertVelocity', function(duration)
    local function SetInReverse(target)
        local currentVelocity = GetEntityVelocity(target)
        SetEntityVelocity(target, -currentVelocity.x, -currentVelocity.y, -currentVelocity.z)
    end

    exports.helpers:DisplayMessage("Go in reverse!")

    for ped in exports.helpers:EnumeratePeds() do
        SetInReverse(ped)
    end

    for vehicle in exports.helpers:EnumerateVehicles() do
        SetInReverse(vehicle)
    end
end)

RegisterNetEvent('Chaos:Misc:Lag', function(duration)
    local state = 0
    ---@type table
    local toTpPeds = {}
    ---@type table
    local toTpVehs = {}
    ---@type integer
    local lastTick = 0

    local exitMethod = false
    exports.helpers:DisplayMessage("Oh no, the lag!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if currentTick > lastTick + 500 then
                lastTick = currentTick

                state = state + 1
                if state == 4 then
                    state = 0
                end

                if state == 2 then
                    for ped in exports.helpers:EnumeratePeds() do
                        if not (IsPedInAnyVehicle(ped, true) or GetVehiclePedIsEntering(ped)) then
                            toTpPeds[ped] = GetEntityCoords(ped, false)
                        end
                    end

                    for vehicle in exports.helpers:EnumerateVehicles() do
                        toTpVehs[vehicle] = GetEntityCoords(vehicle, false)
                    end
                elseif state == 3 then
                    local camHeading = GetGameplayCamRelativeHeading()

                    for ped, pedLoc in pairs(toTpPeds) do
                        local pedVelocity = GetEntityVelocity(ped)
                        local pedHeading = GetEntityHeading(ped)

                        SetEntityCoordsNoOffset(ped, pedLoc.x, pedLoc.y, pedLoc.z, false, false, false)
                        SetEntityHeading(ped, pedHeading)
                        SetEntityVelocity(ped, pedVelocity.x, pedVelocity.y, pedVelocity.z)

                        toTpPeds[ped] = nil
                    end

                    toTpPeds = {}

                    for vehicle, vehicleLoc in pairs(toTpVehs) do
                        local vehicleVelocity = GetEntityVelocity(vehicle)
                        local vehicleHeading = GetEntityHeading(vehicle)
                        local vehicleForwardSpeed = GetEntitySpeed(vehicle)

                        if GetEntitySpeedVector(vehicle, true).y < 0 then
                            vehicleForwardSpeed = vehicleForwardSpeed * -1
                        end

                        SetEntityCoordsNoOffset(vehicle, vehicleLoc.x, vehicleLoc.y, vehicleLoc.z, false, false, false)
                        SetEntityHeading(vehicle, vehicleHeading)
                        SetEntityVelocity(vehicle, vehicleVelocity.x, vehicleVelocity.y, vehicleVelocity.z)
                        SetVehicleForwardSpeed(vehicle, vehicleForwardSpeed)

                        toTpVehs[vehicle] = nil
                    end

                    toTpVehs = {}

                    SetGameplayCamRelativeHeading(camHeading)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:LowPoly', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Where did all my polygons go?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            OverrideLodscaleThisFrame(0.04)
            for ped in exports.helpers:EnumeratePeds() do
                if not (IsPedAPlayer(ped) or IsEntityAMissionEntity(ped)) then
                    ForcePedMotionState(ped, 0xbac0f10b, 0, 0, 0)
                end
            end

            Citizen.Wait(0)
        end
        OverrideLodscaleThisFrame(1.)
    end)
end)

RegisterNetEvent('Chaos:Misc:MeteorRain', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("It's raining... meatballs?")

    local PropNames = {"prop_asteroid_01", "prop_test_boulder_01", "prop_test_boulder_02", "prop_test_boulder_03", "prop_test_boulder_04"}
    local MaxMeteors = 40
    local DespawnTime = 8
    local meteorTable = {}
    ---@type integer
    local lastTick = 0
    ---@type integer
    local lastTick2 = 0

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            local playerPos = GetEntityCoords(PlayerPedId())

            if (#meteorTable <= MaxMeteors and currentTick > lastTick + 200) then
                lastTick = currentTick

                local spawnPos = vector3(
                    playerPos.x + math.random(-100, 100),
                    playerPos.y + math.random(-100, 100),
                    playerPos.z + math.random(25, 50)
                )

                local chosenProp = PropNames[math.random(1, #PropNames)]

                RequestModel(chosenProp)
                while not HasModelLoaded(chosenProp) do
                    Citizen.Wait(100)
                end

                local createdMeteor = CreateObject(chosenProp, spawnPos.x, spawnPos.y, spawnPos.z, true, false, true)
                meteorTable[#meteorTable + 1] = {prop = createdMeteor, despawn = DespawnTime}

                SetObjectPhysicsParams(createdMeteor, 100000., 1., 1., 0., 0., .5, 0., 0., 0., 0., 0.)
                ApplyForceToEntityCenterOfMass(createdMeteor, 0, 50., 0, -10000., true, false, true, true)

                SetModelAsNoLongerNeeded(chosenProp)
            end

            for i, meteorObject in ipairs(meteorTable) do
                local skipNow = false
                local currentProp = meteorObject["prop"]
                if DoesEntityExist(currentProp) and meteorObject["despawn"] > 0 then
                    local propPos = GetEntityCoords(currentProp)
                    if GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, propPos.x, propPos.y, propPos.z, true) < 400 then
                        -- Seems to not be very reliable
                        -- if HasEntityCollidedWithAnything(currentProp) then
                        if lastTick2 < currentTick - 1000 then
                            meteorObject["despawn"] = meteorObject["despawn"] - 1
                        end
                        -- end
                        skipNow = true
                    end
                end

                if skipNow then
                    skipNow = false
                else
                    SetObjectAsNoLongerNeeded(currentProp)
                    table.remove(meteorTable, i)
                end
            end

            if lastTick2 < currentTick - 1000 then
                lastTick2 = currentTick
            end

            Citizen.Wait(0)
        end
        for i, meteorObject in ipairs(meteorTable) do
            SetObjectAsNoLongerNeeded(meteorObject["prop"])
            table.remove(meteorTable, i)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:NewsTeam', function(duration)
    ---@type integer
    local lastPositionGoal = 0
    ---@return vector3
    local function GetCoordsAround(pos, radius)
        local randOffset = math.random(0, 360)

        return vector3(
            pos.x + (math.cos(randOffset) * radius),
            pos.y + (math.sin(randOffset) * radius),
            pos.z + 50
        )
    end

    local exitMethod = false
    exports.helpers:DisplayMessage("Live broadcast, coming right to you")

    local playerPos = GetEntityCoords(PlayerPedId())
    local playerGroup = GetHashKey("PLAYER")
    local relationshipGroup = AddRelationshipGroup("_NEWS_TEAM")

    SetRelationshipBetweenGroups(2, relationshipGroup, playerGroup)
    SetRelationshipBetweenGroups(2, playerGroup, relationshipGroup)

    RequestModel("frogger")
    while not HasModelLoaded("frogger") do
        Citizen.Wait(100)
    end

    ---@type vector3
    local aroundCoords
    ---@type number
    local groundZ
    local isValidCoord = false
    while not isValidCoord do
        aroundCoords = GetCoordsAround(playerPos, 70)
        isValidCoord, groundZ = GetGroundZFor_3dCoord(aroundCoords.x, aroundCoords.y, aroundCoords.z, false)
    end

    groundZ = math.max(groundZ, aroundCoords.z)

    heliEntity = CreateVehicle("frogger", aroundCoords.x, aroundCoords.y, groundZ, 0, true, false, false)
    SetVehicleEngineOn(heliEntity, true, true, true)
    SetVehicleForwardSpeed(heliEntity, 0)
    ModifyVehicleTopSpeed(heliEntity, 100)
    SetHeliBladesSpeed(heliEntity, 1)

    Citizen.Wait(0)

    -- Spawn pilot
    RequestModel("csb_reporter")
    while not HasModelLoaded("csb_reporter") do
        Citizen.Wait(100)
    end

    local pilotPed = CreatePedInsideVehicle(heliEntity, 26, "csb_reporter", -1, true, true)
    SetPedRelationshipGroupHash(pilotPed, relationshipGroup)

    local heliCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 0., 0., 0., 0., 0., 0., 50., true, 2)
    local rearBottomLeft, frontTopRight = GetModelDimensions("frogger")

    AttachCamToEntity(heliCam, heliEntity, 0., frontTopRight.y / 2, rearBottomLeft.z - 2, true)
    PointCamAtEntity(heliCam, PlayerPedId(), 0., 0., 0., true)
    SetCamActive(heliCam, true)
    RenderScriptCams(true, true, 1000, true, true, true)

    local scaleForm = RequestScaleformMovie("breaking_news")
    while not HasScaleformMovieLoaded(scaleForm) do
        Citizen.Wait(100)
    end

    BeginScaleformMovieMethod(scaleForm, "SET_TEXT")
    ScaleformMovieMethodAddParamPlayerNameString(string.format("%s is trying to get clips", GetPlayerName(PlayerId())))
    ScaleformMovieMethodAddParamPlayerNameString("\"Upload better videos\", says random Twitter user")
    EndScaleformMovieMethod()

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local currentTime = GetGameTimer()
            if currentTime - lastPositionGoal > 1000 then
                lastPositionGoal = currentTime
                local targetCoords = GetCoordsAround(vector3(0, 0, 0), math.random(20, 30))
                TaskHeliChase(pilotPed, PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z + math.random(5, 10))
                SetPedKeepTask(pilotPed, true)
            end

            if scaleForm > 0 then
                DrawScaleformMovieFullscreen(scaleForm, 255, 255, 255, 255, 0)
            end

            Citizen.Wait(0)
        end
        RenderScriptCams(false, true, 1000, true, true, true)
        SetCamActive(heliCam, false)
        
        SetEntityAsMissionEntity(pilotPed, true, true)
        DeleteEntity(pilotPed)

        SetEntityAsMissionEntity(heliEntity, true, true)
        DeleteEntity(heliEntity)

        pilotPed = nil
        heliEntity = nil
        scaleForm = nil
    end)
end)

RegisterNetEvent('Chaos:Misc:OilLeaks', function(duration)
    local function AddOil(entity)
        if DoesEntityExist(entity) then
            local entityPos = GetEntityCoords(entity)
            local zExists, groundZ = GetGroundZFor_3dCoord(entityPos.x, entityPos.y, entityPos.z, false)
            if zExists then
                AddPetrolDecal(entityPos.x, entityPos.y, groundZ, 2., 2., 0.)
            end
        end
    end

    local exitMethod = false
    exports.helpers:DisplayMessage("Uh oh, seems like someone spilt some oil")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedInAnyVehicle(ped, false) and IsPedHuman(ped)
                    and not IsPedSwimming(ped) and not IsPedSwimmingUnderWater(ped)
                    and not IsPedDeadOrDying(ped, true) then
                        AddOil(ped)
                end
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                if IsThisModelACar(GetEntityModel(vehicle)) then
                    AddOil(vehicle)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:PortraitMode', function(duration)
    local maxBoxWidth = 0.35
    local currentBoxWidth = 0.

    local exitMethod = false
    exports.helpers:DisplayMessage("Portait mode!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            DrawRect(currentBoxWidth / 2, 0.5, currentBoxWidth, 1., 0, 0, 0, 255) -- Left bar
            DrawRect(1 - currentBoxWidth / 2, 0.5, currentBoxWidth, 1., 0, 0, 0, 255) -- Right bar
            if currentBoxWidth < maxBoxWidth then
                currentBoxWidth = currentBoxWidth + 0.01
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:RainbowWeapons', function(duration)
    local lastTick = GetGameTimer()

    local exitMethod = false
    exports.helpers:DisplayMessage("Rainbow Weapons")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 100 then
                lastTick = currentTick
                for _, playerId in ipairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(playerId)
                    local _, weaponHash = GetCurrentPedWeapon(ped, true)
                    SetPedWeaponTintIndex(ped, weaponHash, math.random(1, 7))
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:RampJam', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Press jump when in a vehicle")

    local playerId = PlayerPedId()
    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            if IsPedInAnyVehicle(playerId, false) then
                local vehicle = GetVehiclePedIsIn(playerId, false)
                if GetPedInVehicleSeat(vehicle, -1) == playerId and IsVehicleOnAllWheels(vehicle) and IsControlJustPressed(0, 22) then
                    ApplyForceToEntity(vehicle, 0, 0., 850., 0., 0., 0., 0., 0, true, true, true, false, true)

                    local playerPos = GetEntityCoords(playerId)
                    local rampPos = GetOffsetFromEntityInWorldCoords(playerId, 0., 18., 0.)

                    local rampObject = CreateObject("prop_mp_ramp_02", rampPos.x, rampPos.y, rampPos.z, true, false, true)

                    PlaceObjectOnGroundProperly(rampObject)
                    rampPos = GetEntityCoords(rampObject)

                    SetEntityCoords(rampObject, rampPos.x, rampPos.y, rampPos.z - 0.3, true, true, true, false)
                    SetEntityRotation(rampObject, GetEntityPitch(playerId), -GetEntityRoll(playerId), GetEntityHeading(playerId), 0, true)
                    SetEntityAsNoLongerNeeded(rampObject)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

---@param duration number
RegisterNetEvent('Chaos:Misc:RollCredits', function(duration)
    exports.helpers:DisplayMessage("That's all folks!")

    -- Hardcode duration
    duration = 40

    local alpha = 0
    local alphaTimer = 0.
    RequestAdditionalText("CREDIT", 0)
    while not HasAdditionalTextLoaded(0) do
        Citizen.Wait(100)
    end

    PlayEndCreditsMusic(true)
    SetCreditsActive(true)
    SetMobilePhoneRadioState(true)

    local songId = math.random(0, 2)
    if songId == 0 then
        SetCustomRadioTrackList("RADIO_16_SILVERLAKE", "END_CREDITS_SAVE_MICHAEL_TREVOR", 1)
    elseif songId == 1 then
        SetCustomRadioTrackList("RADIO_16_SILVERLAKE", "END_CREDITS_KILL_MICHAEL", 1)
    else
        SetCustomRadioTrackList("RADIO_16_SILVERLAKE", "END_CREDITS_KILL_TREVOR", 1)
    end

    SetRadioToStationName("RADIO_16_SILVERLAKE")
    SetUserRadioControlEnabled(false)

    local exitMethod = false

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            alphaTimer = alphaTimer + GetFrameTime()
            if (alpha < 255 and alphaTimer > 0.1) then
                alphaTimer = 0
                alpha = alpha + 1
            end

            DrawRect(.5, .5, 1., 1., 0, 0, 0, alpha)

            Citizen.Wait(0)
        end

        SetCreditsActive(false)
        PlayEndCreditsMusic(false)
        SetMobilePhoneRadioState(false)
        SetUserRadioControlEnabled(true)
    end)
end)

RegisterNetEvent('Chaos:Misc:Spawn:FerrisWheel', function(duration)
    exports.helpers:DisplayMessage("Want to go to the top?")

    Citizen.CreateThread(function()
        SpawnProp("prop_ld_ferris_wheel")
    end)
end)

RegisterNetEvent('Chaos:Misc:Spawn:UFO', function(duration)
    exports.helpers:DisplayMessage("A message from Elon Musk")

    Citizen.CreateThread(function()
        SpawnProp("p_spinning_anus_s")
    end)
end)

RegisterNetEvent('Chaos:Misc:Spawn:OrangeBall', function(duration)
    exports.helpers:DisplayMessage("Watch out!")

    Citizen.CreateThread(function()
        local minDistance = 2
        local maxDistance = 7
        local maxSpeedCheck = 40
        local playerId = PlayerPedId()

        local playerPos = GetEntityCoords(playerId)
        local playerSpeed = math.min(math.max(0, GetEntitySpeed(playerId)), maxSpeedCheck)

        local fixedDistance = ((playerSpeed / maxSpeedCheck) * (maxDistance - minDistance)) + minDistance
        local spawnPos = GetOffsetFromEntityInWorldCoords(playerId, 0., fixedDistance, 0.)

        local ballObject = CreateObject("prop_juicestand", spawnPos.x, spawnPos.y, spawnPos.z - 0.2, true, false, true)

        local ballWeight = ToFloat(math.random(10, 1000) / 10)
        SetObjectPhysicsParams(ballObject, ballWeight, 1., 1., 0., 0., .5, 0., 0., 0., 0., 0.)

        -- Make it fall
        ShootSingleBulletBetweenCoords(
            spawnPos.x, spawnPos.y, spawnPos.z + 4.,
            spawnPos.x, spawnPos.y, spawnPos.z,
            0, false, "weapon_specialcarbine", playerId, false, true, 0.01
        )
        SetPedToRagdoll(playerId, 1000, 1000, 0, true, true, false)
    end)
end)

RegisterNetEvent('Chaos:Misc:SuperStunt', function(duration)
    exports.helpers:DisplayMessage("Super stunt!")

    Citizen.CreateThread(function()
        local playerId = PlayerPedId()
        local rampPos = GetOffsetFromEntityInWorldCoords(playerId, 0., 15., 0.)

        local rampObject = CreateObject("prop_mp_ramp_03", rampPos.x, rampPos.y, rampPos.z, true, false, true)
        PlaceObjectOnGroundProperly(rampObject)

        rampPos = GetEntityCoords(rampObject)
        SetEntityCoords(rampObject, rampPos.x, rampPos.y, rampPos.z - 0.3, true, true, true, false)
        SetEntityRotation(rampObject, GetEntityPitch(playerId), -GetEntityRoll(playerId), GetEntityHeading(playerId), 0, true)
        SetEntityAsNoLongerNeeded(rampObject)
    end)
end)

RegisterNetEvent('Chaos:Misc:VehicleRain', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("It's raining cars. Hallelujah")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()

            if currentTick > lastTick + 500 then
                local playerPos = GetEntityCoords(PlayerPedId())
                lastTick = currentTick

                local spawnPos = vector3(
                    playerPos.x + math.random(-30, 30),
                    playerPos.y + math.random(-30, 30),
                    playerPos.z + math.random(25, 50)
                )

                local randomVehicle = SpawnTempVehicle(VehicleModels[math.random(1, #VehicleModels)], spawnPos)

                -- Give random modifications
                SetVehicleModKit(randomVehicle, 0)
                for i = 0, 50 do
                    if i > 16 and i < 23 then
                        ToggleVehicleMod(randomVehicle, i, math.random(0, 1))
                    else
                        local maxMods = GetNumVehicleMods(randomVehicle, i)
                        if maxMods > 0 then
                            SetVehicleMod(randomVehicle, i, math.random(0, maxMods - 1))
                        end
                    end
                end

                SetVehicleTyresCanBurst(randomVehicle, math.random(0, 1) == 1 and true or false)
                SetVehicleWindowTint(randomVehicle, math.random(0, 6))
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Misc:WhaleRain', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Does anyone still read this? Oh whale.")

    local PropName = "a_c_humpback"
    local MaxWhales = 15
    local DespawnTime = 8
    local whaleTable = {}
    ---@type integer
    local lastTick = 0
    ---@type integer
    local lastTick2 = 0

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            local playerPos = GetEntityCoords(PlayerPedId())

            if #whaleTable <= MaxWhales and currentTick > lastTick + 200 then
                lastTick = currentTick

                local spawnPos = vector3(
                    playerPos.x + math.random(-75, 75),
                    playerPos.y + math.random(-75, 75),
                    playerPos.z + math.random(25, 50)
                )

                RequestModel(PropName)
                while not HasModelLoaded(PropName) do
                    Citizen.Wait(100)
                end

                local createdWhale = CreatePed(28, PropName, spawnPos.x, spawnPos.y, spawnPos.z, math.random(0, 359), true, false)
                whaleTable[#whaleTable + 1] = {prop = createdWhale, despawn = DespawnTime}

                SetPedToRagdoll(createdWhale, 10000, 10000, 0, true, true, false)
                SetEntityHealth(createdWhale, 0)

                ApplyForceToEntityCenterOfMass(createdWhale, 0, 35., 0., -5000., true, false, true, true)

                SetModelAsNoLongerNeeded(PropName)
            end

            for i, whaleObject in ipairs(whaleTable) do
                local skipNow = false
                local currentProp = whaleObject["prop"]
                if DoesEntityExist(currentProp) and whaleObject["despawn"] > 0 then
                    local propPos = GetEntityCoords(currentProp)
                    if GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, propPos.x, propPos.y, propPos.z, true) < 400 then
                        -- Seems to not be very reliable
                        -- if HasEntityCollidedWithAnything(currentProp) then
                        if lastTick2 < currentTick - 1000 then
                            whaleObject["despawn"] = whaleObject["despawn"] - 1
                        end
                        -- end
                        skipNow = true
                    end
                end

                if skipNow then
                    skipNow = false
                else
                    SetObjectAsNoLongerNeeded(currentProp)
                    table.remove(whaleTable, i)
                end
            end

            if lastTick2 < currentTick - 1000 then
                lastTick2 = currentTick
            end

            Citizen.Wait(0)
        end
        for i, whaleObject in ipairs(whaleTable) do
            SetObjectAsNoLongerNeeded(whaleObject["prop"])
            table.remove(whaleTable, i)
        end
    end)
end)