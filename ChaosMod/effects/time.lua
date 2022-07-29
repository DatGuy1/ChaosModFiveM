-- Probably doesn't work
RegisterNetEvent('Chaos:Time:Superhot', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Super. Hot.")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastCheck = 0
        local timer = 0
        while true do
            if exitMethod then
                break
            end

            local currentTime = GetGameTimer()
            if currentTime - lastCheck > 100 then
                lastCheck = currentTime;
                local playerId = PlayerPedId();
                local gameSpeed = 1.;
                if not (IsPedGettingIntoAVehicle(playerId) or IsPedClimbing(playerId) or
                        IsPedDiving(playerId) or IsPedJumpingOutOfVehicle(playerId) or
                        IsPedRagdoll(playerId) or IsPedGettingUp(playerId)) then
                    local speed = GetEntitySpeed(PlayerPedId());
                    gameSpeed = math.max(math.min(speed, 4.) / 4, 0.2);
                end
                SetTimeScale(gameSpeed);
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Time:0.2x', function(duration)
    exports.helpers:DisplayMessage("0.2x speed")
    local timer = 0
    while timer < duration do
        SetAudioFlag("AllowAmbientSpeechInSlowMo", true)
        SetAudioFlag("AllowScriptedSpeechInSlowMo", true)
        SetTimeScale(0.2)

        Citizen.Wait(1000 * 0.2)
        timer = timer + 1
    end

    SetTimeScale(1.)
end)

RegisterNetEvent('Chaos:Time:0.5x', function(duration)
    exports.helpers:DisplayMessage("0.5x speed")
    local timer = 0
    while timer < duration do
        SetAudioFlag("AllowAmbientSpeechInSlowMo", true)
        SetAudioFlag("AllowScriptedSpeechInSlowMo", true)
        SetTimeScale(0.5)

        Citizen.Wait(1000 * 0.5)
        timer = timer + 1
    end

    SetTimeScale(1.)
end)