RegisterNetEvent('ServerPlayIngameSound')
AddEventHandler('ServerPlayIngameSound', function(audioName, audioRef, instantPlay)
    PlaySoundFrontend(-1, audioName, audioRef, instantPlay);
end)
