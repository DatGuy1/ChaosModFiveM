RegisterNetEvent('Chaos:Vehicles:30mphLimit', function(duration)
    exports.helpers:DisplayMessage("30MPH Speed Limit")
    local timer = 0
    while timer < duration do
        for vehicle in exports.helpers:EnumerateVehicles() do
            SetVehicleMaxSpeed(vehicle, 13.41)
        end
        Citizen.Wait(1000)
        timer = timer + 1
    end

    for vehicle in exports.helpers:EnumerateVehicles() do
        SetVehicleMaxSpeed(vehicle, -1.0) -- Resets max speed
    end
end)