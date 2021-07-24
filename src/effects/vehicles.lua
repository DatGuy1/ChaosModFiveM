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
            SetEntityVelocity(vehicle, vehicleVelocity.x, vehicleVelocity.y, vehicleVelocity.z)
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
                        vehicleVelocity.x = vehicleVelocity * velocityMultiplier
                        vehicleVelocity.y = vehicleVelocity * velocityMultiplier
                        SetEntityVelocity(vehicle, vehicleVelocity.x, vehicleVelocity.y, vehicleVelocity.z)
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

            if IsPedInAnyVehicle(playerPed, false) then
                local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                if GetPedInVehicleSeat(playerVehicle, -1) == playerPed and IsControlPressed(0, 72) then
                    local vehicleModel = GetEntityModel(playerVehicle)
                    if GetVehicleClass(playerVehicle) ~= 15 and GetEntityModel(playerVehicle) ~= "BLIMP" then
                        ApplyForceToEntity(
                                playerVehicle, 0,
                                .0, 50., .0,
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
