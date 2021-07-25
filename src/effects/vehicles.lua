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

RegisterNetEvent('Chaos:Vehicles:30mphLimit', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("30MPH Speed Limit")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                SetVehicleMaxSpeed(vehicle, 13.41)
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleMaxSpeed(vehicle, -1.0) -- Resets max speed
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:AllHorn', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Hooooooonk")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                SoundVehicleHornThisFrame(vehicle)
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:AllVehsLaunchUp', function(duration)
    exports.helpers:DisplayMessage("All vehicles go up!")
    Citizen.CreateThread(function()
        for vehicle in exports.helpers:EnumerateVehicles() do
            local vehicleVelocity = GetEntityVelocity(vehicle)
            SetEntityVelocity(vehicle, vehicleVelocity.x, vehicleVelocity.y, 100.)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:Beyblade', function(duration)
    local velocityMultiplier = 3
    local force = 100.

    local exitMethod = false
    exports.helpers:DisplayMessage("Beyblades!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local count = 5
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                local doBeyBlade = IsVehicleSeatFree(vehicle, -1) and true or not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))

                if doBeyBlade then
                    ApplyForceToEntity(
                            vehicle, 3,
                            force, 0., 0.,
                            0., 4., 0.,
                            0, true, true, true, true, true
                    )
                    ApplyForceToEntity(
                            vehicle, 3,
                            -force, 0., 0.,
                            0., -4., 0.,
                            0, true, true, true, true, true
                    )
                    SetEntityInvincible(vehicle, true)
                    SetVehicleReduceGrip(vehicle, true)
                    if GetEntitySpeed(vehicle) < 10 then
                        local vehicleVelocity = GetEntitySpeedVector(vehicle, true)
                        local newX = vehicleVelocity.x * velocityMultiplier
                        local newY = vehicleVelocity.y * velocityMultiplier
                        SetEntityVelocity(vehicle, newX, newY, vehicleVelocity.z)
                    end
                else
                    SetVehicleReduceGrip(vehicle, false)
                end

                count = count - 1
                if count == 0 then
                    count = 5
                    Citizen.Wait(0)
                end
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetEntityInvincible(vehicle, false)
            SetVehicleReduceGrip(vehicle, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:BouncyCars', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Bouncy Cars!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type number
        local velFactor
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                SetEntityInvincible(vehicle, true)
                if HasEntityCollidedWithAnything(vehicle) then
                    local vehicleVelocity = GetEntityVelocity(vehicle)
                    if vehicleVelocity.x < 10 and vehicleVelocity.y < 10 and vehicleVelocity.z < 10 then
                        velFactor = 300.
                    else
                        velFactor = 60.
                    end

                    ApplyForceToEntity(
                            vehicle, 0,
                            vehicleVelocity.x * -velFactor, vehicleVelocity.y * -velFactor, vehicleVelocity.z * -velFactor,
                            .0, .0, .0, 0, true, true, true, false, true
                    )
                end
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetEntityInvincible(vehicle, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:BrakeBoost', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Try braking when driving")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            if exitMethod then
                break
            end

            DisableControlAction(0, 72, true)
            if IsPedInAnyVehicle(playerPed, false) then
                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                if GetPedInVehicleSeat(playerVehicle, -1) == playerPed and IsControlPressed(0, 72) then
                    local vehicleModel = GetEntityModel(playerVehicle)
                    if GetVehicleClass(playerVehicle) ~= 15 and GetEntityModel(playerVehicle) ~= "BLIMP" then
                        ApplyForceToEntity(
                                playerVehicle, 0,
                                .0, 80., .0,
                                .0, .0, .0,
                                0, true, true, true, false, true
                        )
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:BreakDoors', function(duration)
    exports.helpers:DisplayMessage("Where's your doors at?")
    Citizen.CreateThread(function()
        local count = 10
        for vehicle in exports.helpers:EnumerateVehicles() do
            for i = 0, 6 do
                SetVehicleDoorBroken(vehicle, i, false)

                count = count - 1
                if count == 0 then
                    count = 10
                    Citizen.Wait(0)
                end
            end
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:CinematicCam', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Very artsy")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SetPlayerCanDoDriveBy(PlayerId(), false)
            SetCinematicModeActive(true)
            DisableControlAction(0, 80, true)

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                DisableControlAction(0, 27, true)
                DisableControlAction(0, 0, true)
            end

            Citizen.Wait(0)
        end

        SetCinematicModeActive(false)
        SetPlayerCanDoDriveBy(PlayerId(), true)
    end)
end)

RegisterNetEvent('Chaos:Vehicles:CrumblingCars', function(duration)
    local function GenRandomFloat()
        return math.random(-10, 10) / 10.
    end

    local exitMethod = false
    exports.helpers:DisplayMessage("Bono, my car is crumbling")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local vehicles = {}
            for vehicle in exports.helpers:EnumerateVehicles() do
                table.insert(vehicles, vehicle)
            end

            if #vehicles > 0 then
                SetVehicleDamage(
                        vehicles[math.random(1, #vehicles)],
                        GenRandomFloat(), GenRandomFloat(), GenRandomFloat(),
                        ToFloat(math.random(10000, 100000) / 10),
                        ToFloat(math.random(1000, 10000) / 10),
                        true
                )
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:ExplodeNearby', function(duration)
    exports.helpers:DisplayMessage("Cars go boom")
    Citizen.CreateThread(function()
        local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local count = 3
        for vehicle in exports.helpers:EnumerateVehicles() do
            if vehicle ~= playerVehicle then
                NetworkExplodeVehicle(vehicle, true, false, false)

                count = count - 1
                if count == 0 then
                    count = 3
                    Citizen.Wait(0)
                end
            end
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:FlyingCars', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Elon Musk taught me cars can fly to space once they catch liftoff")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            if exitMethod then
                break
            end

            if IsPedInAnyVehicle(playerPed, false) then
                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                local vehicleClass = GetVehicleClass(playerVehicle)
                if vehicleClass ~= 15 and vehicleClass ~= 16 then
                    local currentSpeed = GetEntitySpeed(playerVehicle)
                    local maxSpeed = GetVehicleModelEstimatedMaxSpeed(GetEntityModel(playerVehicle))

                    if currentSpeed >= maxSpeed * 0.6 then
                        if IsControlPressed(0, 71) then
                            SetVehicleForwardSpeed(playerVehicle, math.min(maxSpeed * 3, currentSpeed + 0.3))
                        end

                        -- Allow Steering if not "on ground" or boat in water
                        if vehicleClass == 14 or not IsVehicleOnAllWheels(playerVehicle) then
                            local newX, newY, newZ = table.unpack(GetEntityRotation(playerVehicle, 2))

                            -- Turn Left
                            if IsControlPressed(0, 63) then
                                newZ = newZ + 1.
                            end
                            -- Turn Right
                            if IsControlPressed(0, 64) then
                                newZ = newZ - 1.0
                            end
                            -- Roll Left
                            if IsControlPressed(0, 108) then
                                newY = newY - 1.0
                            end
                            -- Roll Right
                            if IsControlPressed(0, 109) then
                                newY = newY + 1.
                            end
                            -- Tilt Down
                            if IsControlPressed(0, 111) then
                                newX = newX - 1.
                            end
                            -- Tilt Up
                            if IsControlPressed(0, 112) then
                                newX = newX + 1.
                            end

                            SetEntityRotation(playerVehicle, newX, newY, newZ, 2, 1)
                        end
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:FullAccel', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Gotta go fast")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                local vehicleModel = GetEntityModel(vehicle)
                if IsVehicleOnAllWheels(vehicle) or IsThisModelAPlane(vehicleModel) or IsThisModelAHeli(vehicleModel) then
                    SetVehicleForwardSpeed(vehicle, GetVehicleModelEstimatedMaxSpeed(vehicleModel) * 2)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:HonkBoost', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Honk4Boost")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                if IsHornActive(vehicle) then
                    ApplyForceToEntity(vehicle, 0, .0, 50., .0, .0, .0, .0, 0, true, true, true, false, true)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:InvisibleVehicles', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Where did all the vehicles go?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                SetEntityAlpha(vehicle, 0, false)
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            ResetEntityAlpha(vehicle)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:JesusTakeTheWheel', function(duration)
    local backupCoords = vector3(-1393.66, -582.16, -29.64)

    local exitMethod = false
    exports.helpers:DisplayMessage("As Carrie Underwood once said: Jesus, take the wheel")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local jesusModel = "u_m_m_jesus_01"

        -- If the player isn't in a vehicle, put him in a pink panto
        if not IsPedInAnyVehicle(playerPed, false) then
            local playerPos = GetEntityCoords(playerPed, true)

            RequestModel("PANTO")
            while not HasModelLoaded("PANTO") do
                Citizen.Wait(100)
            end

            local createdPanto = CreateVehicle(
                    "PANTO",
                    playerPos.x, playerPos.y, playerPos.z,
                    GetEntityHeading(playerPed), true, false, false
            )
            SetModelAsNoLongerNeeded("PANTO")

            SetVehicleColours(createdPanto, 135, 135)
            SetPedIntoVehicle(playerPed, createdPanto, -1)
        end

        RequestModel(jesusModel)
        while not HasModelLoaded(jesusModel) do
            Citizen.Wait(100)
        end

        local _, relationshipGroup = AddRelationshipGroup("_WHEEL_JESUS")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")

        local playerVehicle = GetVehiclePedIsIn(playerPed)
        SetPedIntoVehicle(playerPed, playerVehicle, -2)

        local jesusPed = CreatePedInsideVehicle(playerVehicle, 4, jesusModel, -1, true, false)
        SetPedRelationshipGroupHash(jesusPed, relationshipGroup)
        SetEntityProofs(jesusPed, true, true, true, false, false, false, false, true)

        local waypointCoords = IsWaypointActive() and GetBlipCoords(GetFirstBlipInfoId(0)) or backupCoords
        -- Not exactly sure what the driveMode means, https://gtaforums.com/topic/822314-guide-driving-styles/
        TaskVehicleDriveToCoordLongrange(
                jesusPed, playerVehicle,
                waypointCoords.x, waypointCoords.y, waypointCoords.z,
                9999., 262668, 10.
        )
        SetPedKeepTask(jesusPed, true)
        SetBlockingOfNonTemporaryEvents(jesusPed, true)
        SetModelAsNoLongerNeeded(jesusModel)
    end)
end)

RegisterNetEvent('Chaos:Vehicles:JumpyCars', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Jumpy Cars!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local lastTick = GetGameTimer()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 50 then
                lastTick = currentTick

                for vehicle in exports.helpers:EnumerateVehicles() do
                    if vehicle ~= GetVehiclePedIsIn(playerPed, false) and not IsEntityInAir(vehicle) then
                        ApplyForceToEntityCenterOfMass(vehicle, 0, .0, .0, 500., true, false, true, false)
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:KillEngine', function(duration)
    exports.helpers:DisplayMessage("Kill all vehicles' engines")
    Citizen.CreateThread(function()
        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleEngineHealth(vehicle, 0.)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:LockCamera', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Vehicle camera locked")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            if IsPedInAnyVehicle(PlayerPedId(), false) then
                SetGameplayCamRelativeRotation(0., 0., 0.)
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:NoGravity', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Cars are in zero-G")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                SetVehicleGravity(vehicle, false)
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleGravity(vehicle, true)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:NoTraffic', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Where have all the cars gone?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SetAmbientVehicleRangeMultiplierThisFrame(0.)
            SetParkedVehicleDensityMultiplierThisFrame(0.)
            SetRandomVehicleDensityMultiplierThisFrame(0.)
            SetVehicleDensityMultiplierThisFrame(0.)

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:OneHitKO', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Vehicles explode on impact!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local lastTick = GetGameTimer()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 1000 then
                lastTick = currentTick

                for vehicle in exports.helpers:EnumerateVehicles() do
                    SetVehicleOutOfControl(vehicle, false, true)
                end
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleOutOfControl(vehicle, false, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:PopRandomTires', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Pop, go your tires")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local lastTick = GetGameTimer()
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 1750 then
                lastTick = currentTick

                for vehicle in exports.helpers:EnumerateVehicles() do
                    for i = 0, 48 do
                        -- random true / false to get ideally 50% of tires popped
                        if math.random(0, 1) == 1 then
                            SetVehicleTyresCanBurst(vehicle, true)
                            SetVehicleTyreBurst(vehicle, i, true, 1000.)
                        else
                            SetVehicleTyreFixed(vehicle, i)
                        end
                    end
                end
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleOutOfControl(vehicle, false, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:RainbowCars', function(duration)
    local frequency = .1

    local exitMethod = false
    exports.helpers:DisplayMessage("Rainbow Cars!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        -- https://krazydad.com/tutorials/makecolors.php
        local headlightColour = 0
        local cnt = 0
        while true do
            if exitMethod then
                break
            end

            cnt = cnt + 1
            if cnt >= 128 then
                cnt = 0
            end

            headlightColour = headlightColour + 1
            if headlightColour > 12 then
                headlightColour = 0
            end

            for vehicle in exports.helpers:EnumerateVehicles() do
                -- Needs to be integer, so floor
                local newR = Floor(math.sin(frequency * cnt) * 127 + 128)
                local newG = Floor(math.sin(frequency * cnt + 2) * 127 + 128)
                local newB = Floor(math.sin(frequency * cnt + 4) * 127 + 128)

                SetVehicleCustomPrimaryColour(vehicle, newR, newG, newB)
                SetVehicleCustomSecondaryColour(vehicle, newG, newB, newR)

                SetVehicleNeonLightsColour(vehicle, newR, newG, newB)
                for i = 0, 3 do
                    SetVehicleNeonLightEnabled(vehicle, i, true)
                end

                ToggleVehicleMod(vehicle, 22, true)
                SetVehicleXenonLightsColor(vehicle, headlightColour)
            end

            Citizen.Wait(0)
        end

        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleXenonLightsColor(vehicle, -1)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:ReplaceVehicle', function(duration)
    exports.helpers:DisplayMessage("Tada, a brand new random vehicle!")
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()

        local pedsToMove = {}

        ---@type vector3
        local newCoords
        ---@type number
        local newHeading
        ---@type vector3
        local newVelocity
        local forwardSpeed = 0

        if IsPedInAnyVehicle(playerPed, false) then
            local oldVehicle = GetVehiclePedIsIn(playerPed, false)

            newCoords = GetEntityCoords(oldVehicle, false)
            newHeading = GetEntityHeading(oldVehicle)
            newVelocity = GetEntityVelocity(oldVehicle)
            forwardSpeed = GetEntitySpeed(oldVehicle)

            for i = -1, #GetVehicleModelNumberOfSeats(GetEntityModel(oldVehicle)) do
                if not IsVehicleSeatFree(oldVehicle, i) then
                    table.insert(pedsToMove, GetPedInVehicleSeat(oldVehicle, i))
                end
            end

            DeleteVehicle(oldVehicle)
        else
            newHeading = GetEntityHeading(playerPed)
            newCoords = GetEntityCoords(playerPed, false)
            newVelocity = GetEntityVelocity(playerPed)
            forwardSpeed = GetEntitySpeed(playerPed)
            table.insert(pedsToMove, playerPed)
        end

        local randomVehicle = VehicleModels[math.random(1, #VehicleModels)]

        -- Filter out Truck Trailers and other vehicles with insufficient seats
        while GetVehicleModelNumberOfSeats(randomVehicle) < #pedsToMove or
                IsThisModelATrain(randomVehicle) or GetVehicleModelAcceleration(randomVehicle) <= 0 do
            randomVehicle = VehicleModels[math.random(1, #VehicleModels)]
        end

        RequestModel(randomVehicle)
        while not HasModelLoaded(randomVehicle) do
            Citizen.Wait(50)
        end

        local newVehicle = CreateVehicle(
                randomVehicle,
                newCoords.x, newCoords.y, newCoords.z,
                newHeading, true, true, true
        )
        for i = 0, #pedsToMove do
            SetPedIntoVehicle(pedsToMove[i], newVehicle, i == 0 and -1 or -2)
        end

        SetVehicleEngineOn(newVehicle, true, true, false)
        SetEntityVelocity(newVehicle, newVelocity.x, newVehicle.y, newVelocity.z)
        SetVehicleForwardSpeed(newVehicle, forwardSpeed)

        SetEntityAsMissionEntity(newVehicle, false, true)
        SetModelAsNoLongerNeeded(randomVehicle)

        -- Apply random upgrades
        SetVehicleModKit(newVehicle, 0)
        for i = 0, 50 do
            local maxMods = GetNumVehicleMods(newVehicle, i)
            SetVehicleMod(newVehicle, i, maxMods > 0 and math.random(0, #maxMods - 1) or 0, math.random(0, 1))
            ToggleVehicleMod(newVehicle, i, math.random(0, 1))
        end
        SetVehicleTyresCanBurst(newVehicle, math.random(0, 1) == 1 and true or false)
        SetVehicleWindowTint(newVehicle, 3)
    end)
end)

RegisterNetEvent('Chaos:Vehicles:Repossession', function(duration)
    local backupCoords = vector3(-1393.66, -582.16, -29.64)

    local exitMethod = false
    exports.helpers:DisplayMessage("Simeone's here, I guess someone didn't pay back their loans")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local simeonModel = "ig_siemonyetarian"
        local dealershipCoords = vector3(-52, -1106.88, 26)
        local playerVehicle


        if not IsPedInAnyVehicle(playerPed, false) then
            local playerPos = GetEntityCoords(playerPed, true)

            RequestModel("BJXL")
            while not HasModelLoaded("BJXL") do
                Citizen.Wait(100)
            end

            local createdVehicle = CreateVehicle(
                    "BJXL",
                    playerPos.x, playerPos.y, playerPos.z,
                    GetEntityHeading(playerPed), true, false, false
            )
            SetModelAsNoLongerNeeded("BJXL")

            SetVehicleColours(createdVehicle, 88, 0)
            SetVehicleEngineOn(createdVehicle)
        end

        RequestModel(simeonModel)
        while not HasModelLoaded(simeonModel) do
            Citizen.Wait(100)
        end

        local _, relationshipGroup = AddRelationshipGroup("_WHEEL_SIMEON")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")

        SetPedIntoVehicle(playerPed, playerVehicle, -2)

        local simeonPed = CreatePedInsideVehicle(playerVehicle, 4, simeonModel, -1, true, false)
        SetPedRelationshipGroupHash(simeonPed, relationshipGroup)
        SetEntityProofs(simeonPed, true, false, false, false, false, false, false, false)

        -- Not exactly sure what the driveMode means, https://gtaforums.com/topic/822314-guide-driving-styles/
        TaskVehicleDriveToCoordLongrange(
                simeonPed, playerVehicle,
                dealershipCoords.x, dealershipCoords.y, dealershipCoords.z,
                9999., 262668, 3.
        )
        SetPedKeepTask(simeonPed, true)
        SetBlockingOfNonTemporaryEvents(simeonPed, true)
        SetModelAsNoLongerNeeded(simeonModel)
    end)
end)

RegisterNetEvent('Chaos:Vehicles:RotateAll', function(duration)
    exports.helpers:DisplayMessage("Flip!")
    Citizen.CreateThread(function()
        for vehicle in exports.helpers:EnumerateVehicles() do
            local vehicleVelocity = GetEntityVelocity(vehicle)
            local vehicleRotation = GetEntityRotation(vehicle, 2)

            if math.random(0, 1) == 1 then
                -- Horizontal flip
                if vehicleRotation.x < 180. then
                    SetEntityRotation(vehicle, vehicleRotation.x + 180., vehicleRotation.y, vehicleRotation.z, 2, true)
                else
                    SetEntityRotation(vehicle, vehicleRotation.x - 180., vehicleRotation.y, vehicleRotation.z, 2, true)
                end
            else
                -- Vertical flip
                if vehicleRotation.y < 180. then
                    SetEntityRotation(vehicle, vehicleRotation.x, vehicleRotation.y + 180., vehicleRotation.z, 2, true)
                else
                    SetEntityRotation(vehicle, vehicleRotation.x, vehicleRotation.y - 180., vehicleRotation.z, 2, true)
                end
            end

            SetEntityVelocity(vehicle, vehicleVelocity.x, vehicleVelocity.y, vehicleVelocity.z)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:Spawn:WizardBroom', function(duration)
    exports.helpers:DisplayMessage(string.format("You're a wizard, %s", GetPlayerName(PlayerId())))
    Citizen.CreateThread(function()
        local oppressorModel = "OPPRESSOR2"
        local broomModel = "prop_tool_broom"
        local playerPed = PlayerPedId()
        local playerPos = GetOffsetFromEntityInWorldCoords(playerPed, 0., 1., 0.)

        RequestModel(oppressorModel)
        while not HasModelLoaded(oppressorModel) do
            Citizen.Wait(50)
        end

        RequestModel(broomModel)
        while not HasModelLoaded(broomModel) do
            Citizen.Wait(50)
        end

        local newVehicle = CreateVehicle(oppressorModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPos), true, false)
        SetVehicleEngineOn(newVehicle, true, true, false)

        SetVehicleModKit(newVehicle, 0)
        for i = 0, 50 do
            local maxMods = GetNumVehicleMods(newVehicle, i)
            SetVehicleMod(newVehicle, i, maxMods > 0 and maxMods - 1 or 0, false)
        end

        SetEntityAlpha(newVehicle, 0, false)
        SetEntityVisible(newVehicle, false, false)

        local broomObject = CreateObject(broomModel, playerPos.x, playerPos.y + 2, playerPos.z, true, false, false)
        AttachEntityToEntity(
                broomObject, newVehicle, 0,
                0., 0., 0.3,
                -80., 0., 0.,
                true, false, false, false, 0, true
        )

        SetModelAsNoLongerNeeded(oppressorModel)
        SetModelAsNoLongerNeeded(broomModel)
    end)
end)

RegisterNetEvent('Chaos:Vehicles:SpeedGoal', function(duration)
    local USE_METRIC = ShouldUseMetricMeasurements()
    local WAIT_TIME = 10000 -- ms
    local SPEED_THRESHOLD = 0.5 -- % of max speed that must be reached

    local function Beepable(timeLeft)
        return ((math.log(timeLeft) / math.log(1.0019)) % 100) < 20
    end

    local function FormatSpeed(ms)
        if USE_METRIC then
            return string.format("%.1f km/h", ms * 3.6)
        else
            return string.format("%.1f mph", ms * 2.236936)
        end
    end

    local exitMethod = false
    exports.helpers:DisplayMessage("Ever seen the Keanu Reeves Speed movie? Well, buckle up")

    Citizen.Wait(1000)
    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local scaleformOverlay = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
        while not HasScaleformMovieLoaded(scaleformOverlay) do
            Citizen.Wait(100)
        end

        local enteredVehicle = false
        local lastTick = GetGameTimer()
        ---@type Vehicle
        local lastVehicle
        local timeReserve = WAIT_TIME
        -- Making up for no 'continue' statement
        local skipNext = false
        while true do
            if exitMethod then
                break
            end

            local playerVehicle = GetVehiclePedIsIn(playerPed, false)

            if lastVehicle ~= nil and playerVehicle ~= lastVehicle then
                NetworkExplodeVehicle(playerVehicle, true, false, false)
            end

            if not IsPedDeadOrDying(playerPed, false) and
                    IsPedInAnyVehicle(playerPed, false) and
                    GetIsVehicleEngineRunning(playerPed, false) then
                if enteredVehicle then
                    lastVehicle = playerVehicle

                    local minSpeed = GetVehicleModelEstimatedMaxSpeed(GetEntityModel(playerVehicle)) * SPEED_THRESHOLD
                    local speedMs = GetEntitySpeed(playerVehicle)

                    local currentTick = GetGameTimer()
                    local tickDelta = currentTick - lastTick

                    local overlayColour = 0
                    if speedMs < minSpeed then
                        overlayColour = 75
                        if timeReserve < tickDelta then
                            NetworkExplodeVehicle(playerVehicle, true, false, false)
                            timeReserve = WAIT_TIME
                            skipNext = true
                        else
                            if Beepable(timeReserve - tickDelta) and not Beepable(timeReserve) then
                                PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", true)
                            end

                            timeReserve = timeReserve - tickDelta
                        end
                    else
                        overlayColour = 25
                        timeReserve = timeReserve + tickDelta / 2
                        if timeReserve > WAIT_TIME then
                            timeReserve = WAIT_TIME
                        end
                    end

                    if skipNext then
                        skipNext = false
                    else
                        lastTick = currentTick

                        BeginScaleformMovieMethod(scaleformOverlay, "SHOW_SHARD_RANKUP_MP_MESSAGE")

                        local displaySpeed = FormatSpeed(speedMs)
                        local displayMinSpeed = FormatSpeed(minSpeed)
                        local displayMessage = tostring(displaySpeed)

                        ScaleformMovieMethodAddParamPlayerNameString(displayMessage)

                        if timeReserve ~= WAIT_TIME and speedMs < minSpeed then
                            displayMessage = string.format("Minimum: %s\nDetonation In: %.1fs", displayMinSpeed, timeReserve / 1000)
                        elseif timeReserve ~= WAIT_TIME and speedMs > minSpeed then
                            displayMessage = string.format("Minimum: %s\nDetonation In: %.1fs (Recovering)", displayMinSpeed, timeReserve / 1000)
                        else
                            displayMessage = string.format("Minimum: %s", displayMinSpeed)
                        end

                        ScaleformMovieMethodAddParamPlayerNameString(displayMessage)
                        ScaleformMovieMethodAddParamInt(overlayColour)
                        EndScaleformMovieMethod()
                        DrawScaleformMovieFullscreen(scaleformOverlay, 255, 255, 255, 255, 0)
                    end
                else
                    enteredVehicle = true
                    lastVehicle = nil
                    timeReserve = WAIT_TIME
                    lastTick = GetGameTimer()
                end
            else
                enteredVehicle = false
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Vehicles:VehicleWeapons', function(duration)
    local zOffset = 0.35

    local exitMethod = false
    exports.helpers:DisplayMessage("Vehicles Shoot Rockets (Left Click/RB)")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        ---@type integer
        local lastShot = 0
        local weaponHash = "VEHICLE_WEAPON_TANK"
        while true do
            if exitMethod then
                break
            end

            if IsPedInAnyVehicle(playerPed, false) then
                -- INPUT_VEH_ATTACK - Left MouseButton
                if IsControlPressed(0, 69) or IsControlJustPressed(0, 60) then
                    local currentTime = GetGameTimer()
                    if currentTime - lastShot > 1000 then
                        lastShot = currentTime

                        if not HasWeaponAssetLoaded(weaponHash) then
                            RequestWeaponAsset(weaponHash, 31, 0)
                            while not HasWeaponAssetLoaded(weaponHash) do
                                Citizen.Wait(50)
                            end
                        end

                        local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                        local vehicleCoords = GetEntityCoords(playerVehicle, false)

                        local leftWeaponStart = GetOffsetFromEntityInWorldCoords(playerVehicle, -1.5, 0.5, zOffset)
                        local leftWeaponEnd = GetOffsetFromEntityInWorldCoords(playerVehicle, -1.5, 100, zOffset)
                        local rightWeaponStart = GetOffsetFromEntityInWorldCoords(playerVehicle, 1.5, 0.5, zOffset)
                        local rightWeaponEnd = GetOffsetFromEntityInWorldCoords(playerVehicle, 1.5, 100, zOffset)

                        ShootSingleBulletBetweenCoords(
                                leftWeaponStart.x, leftWeaponStart.y, leftWeaponStart.z,
                                leftWeaponEnd.x, leftWeaponEnd.y, leftWeaponEnd.z,
                                0, true, weaponHash, playerPed, true, false, 200.
                        )
                        ShootSingleBulletBetweenCoords(
                                rightWeaponStart.x, rightWeaponStart.y, rightWeaponStart.z,
                                rightWeaponEnd.x, rightWeaponEnd.y, rightWeaponEnd.z,
                                0, true, weaponHash, playerPed, true, false, 200.
                        )

                        RemoveWeaponAsset(weaponHash)
                    end
                end
            end

            Citizen.Wait(0)
        end

        RemoveNamedPtfxAsset("weap_ch_vehicle_weapons")
    end)
end)