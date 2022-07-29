RegisterNetEvent('DisplayMessage')
AddEventHandler('DisplayMessage', function(prompt, flash)
    exports.helpers:DisplayMessage(prompt, flash)
end)

exports('DisplayMessage', function(prompt, flash)
    -- Default value for optional argument
    if flash == nil then
        flash = true
    end

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentString(prompt)
    EndTextCommandThefeedPostTicker(flash, true)
end)

RegisterNetEvent('ScaleformMessage')
AddEventHandler('ScaleformMessage', function(message, duration)
    exports.helpers:ScaleformMessage(message, duration)
end)

exports('ScaleformMessage', function(message, duration)
    local scaleForm = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    while not HasScaleformMovieLoaded(scaleForm) do
        Citizen.Wait(100)
    end
        
    local exitLoop = false
    Citizen.SetTimeout(duration * 1000, function() exitLoop = true end)

    BeginScaleformMovieMethod(scaleForm, "SHOW_SHARD_RANKUP_MP_MESSAGE")
    ScaleformMovieMethodAddParamPlayerNameString(message)
    EndScaleformMovieMethod()

    while not exitLoop do
        Citizen.Wait(0)
        DrawScaleformMovieFullscreen(scaleForm, 255, 255, 255, 255, 0)
    end

    SetScaleformMovieAsNoLongerNeeded()
end)