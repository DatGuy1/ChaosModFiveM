local SimonSaysActions = {
    {"move forwards", {32, 71, 77, 87, 129, 136, 150, 232}},
    {"move backwards", {33, 72, 78, 88, 130, 139, 151, 233}},
    {"move left", {34, 63, 89, 133, 147, 234}},
    {"move right", {35, 64, 90, 134, 148, 235}},
    {"move", {
        32, 71, 77, 87, 129, 136, 150, 232,
        33, 72, 78, 88, 130, 139, 151, 233,
        34, 63, 89, 133, 147, 234,
        35, 64, 90, 134, 148, 235,
        44, 23, 102, 55,
    }},
    {"look behind", {26, 79}}
}

---TeleportPlayer
---@param newCoords void dasd
---@return string xd
local function TeleportPlayer(newCoords)
    local playerPed = PlayerPedId()

    ---@type Vehicle
    local playerVehicle
    local isInVehicle = IsPedInAnyVehicle(playerPed, false)

    if isInVehicle then
        playerVehicle = GetVehiclePedIsIn(playerPed, false)
    end

    local entityVelocity = GetEntityVelocity(isInVehicle and playerVehicle or playerPed)
    local entityHeading = GetEntityHeading(isInVehicle and playerVehicle or playerPed)

    local forwardSpeed = isInVehicle and GetEntitySpeed(playerVehicle) or 0

    SetEntityCoords(isInVehicle and playerVehicle or playerPed, newCoords.x, newCoords.y, newCoords.z, false, false, false, false)
    SetEntityHeading(isInVehicle and playerVehicle or playerPed, entityHeading)
    SetEntityVelocity(isInVehicle and playerVehicle or playerPed, entityVelocity.x, entityVelocity.y, entityVelocity.z)

    if isInVehicle then
        SetVehicleForwardSpeed(playerVehicle, forwardSpeed)
    end
end

RegisterNetEvent('Chaos:Player:Aimbot', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Aimbot")

    local playerId = PlayerPedId()
    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SetPedInfiniteAmmoClip(playerId, true)
            if (IsPedWeaponReadyToShoot(playerId)) then
                local count = 10
                local maxRange = GetMaxRangeOfCurrentPedWeapon(playerId)
                local playerPos = GetEntityCoords(playerId)

                for ped in exports.helpers:EnumeratePeds() do
                    RequestPedVisibilityTracking(ped)
                    if (ped ~= playerId and IsTrackedPedVisible(ped) and not 
                        IsPedDeadOrDying(ped, true) and -- and not IsPedAPlayer(ped)
                        IsTrackedPedVisible(ped)) then
                        local pedCoords = GetEntityCoords(ped)
                        local distance = GetDistanceBetweenCoords(
                            playerPos.x, playerPos.y, playerPos.z,
                            pedCoords.x, pedCoords.y, pedCoords.z,
                            true
                        )

                        if distance <= maxRange then
                            local headVector = GetPedBoneCoords(ped, 0x796E, 0, 0, 0) -- Get head bone of ped
                            SetPedShootsAtCoord(playerId, headVector.x, headVector.y, headVector.z, true)

                            count = count - 1
                            if (count <= 0) then
                                break
                            end
                        end
                    end
                end
            end

            Citizen.Wait(0)
        end
        SetPedInfiniteAmmoClip(playerId, false)
    end)
end)

RegisterNetEvent('Chaos:Player:Bees', function(duration)
    local CHANCE = 100 -- const. The higher, the less likely
    local matchTarget = math.random(0, CHANCE) -- Target for chance to match against

    RequestNamedPtfxAsset("core")
    while not HasNamedPtfxAssetLoaded("core") do
        Citizen.Wait(100)
    end

    UseParticleFxAsset("core")
    local particleId = StartParticleFxLoopedOnEntity("ent_amb_fly_swarm", PlayerPedId(), 0., 0., 0., 0., 0., 0., 2.5, false, false, false)
    local timeUntilClear = GetGameTimer()

    local exitMethod = false
    exports.helpers:DisplayMessage("Not the bees!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local randInt = math.random(0, CHANCE)

            PlayStreamFromPed(PlayerPedId())

            if randInt == matchTarget then
                ApplyDamageToPed(PlayerPedId(), 1, false, false)
                PlayPain(PlayerPedId(), 22, 0, 0)

                if GetTimecycleTransitionModifierIndex() == -1 and GetTimecycleModifierIndex() == -1 then
                    SetTransitionTimecycleModifier("fp_vig_red", 0.25)
                end
                timeUntilClear = timeUntilClear + 250
            end

            local curTick = GetGameTimer()
            if timeUntilClear < curTick then
                timeUntilClear = curTick
                ClearTimecycleModifier()
            end

            Citizen.Wait(0)
        end
        StopParticleFxLooped(particleId, 0)
        RemoveNamedPtfxAsset("core")
        ClearTimecycleModifier()
    end)
end)

RegisterNetEvent('Chaos:Player:Binoculars', function(duration)
    local fovCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    RenderScriptCams(true, true, 700, true, true, true)

    local exitMethod = false
    exports.helpers:DisplayMessage("Got me some new glasses")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SetCamActive(fovCamera, true)
            local camPos = GetGameplayCamCoord()
            local camRot = GetGameplayCamRot_2()
            SetCamParams(fovCamera, camPos.x, camPos.y, camPos.z, camRot.x, camRot.y, camRot.z, 10., 0, 1, 1, 2)

            Citizen.Wait(0)
        end

        SetCamActive(fovCamera, false)
        RenderScriptCams(false, false, 700, true, true, true)
        DestroyCam(fovCamera, true)
        fovCamera = nil
    end)
end)

RegisterNetEvent('Chaos:Player:Clone', function(duration)
    exports.helpers:DisplayMessage("Here's a friend! Or is he?")

    local isFriendly = math.random(0, 1)

    ---@type Hash
    local relationshipGroup
    if isFriendly then
        _, relationshipGroup = AddRelationshipGroup("_COMPANION_CLONE_FRIENDLY")
        SetRelationshipBetweenGroups(0, relationshipGroup, GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(0, GetHashKey("PLAYER"), relationshipGroup)
    else
        _, relationshipGroup = AddRelationshipGroup("_COMPANION_CLONE_HOSTILE")
        SetRelationshipBetweenGroups(5, relationshipGroup, GetHashKey("PLAYER"))
        SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), relationshipGroup)
    end

    local playerPed = PlayerPedId()

    local playerClone = ClonePed(playerPed, true, true, false)
    if IsPedInAnyVehicle(playerPed, false) then
        SetPedIntoVehicle(playerClone, GetVehiclePedIsIn(playerPed, false), -2)
    end

    StopPedSpeaking(playerClone, true)
    DisablePedPainAudio(playerClone, true)
    SetPedSuffersCriticalHits(playerClone, false)
    SetPedHearingRange(playerClone, 9999.)
    SetPedConfigFlag(playerClone, 281, true)
    SetPedCanRagdollFromPlayerImpact(playerClone, false)
    SetRagdollBlockingFlags(playerClone, 5)

    SetPedRelationshipGroupHash(playerClone, relationshipGroup)

    if isFriendly then
        SetPedAsGroupMember(playerClone, GetPlayerGroup(playerPed))
    end

    SetPedCombatAttributes(playerClone, 5, true)
    SetPedCombatAttributes(playerClone, 46, true)

    GiveWeaponToPed(playerClone, GetSelectedPedWeapon(playerPed), 9999, true, true)

    SetPedAccuracy(playerClone, 100)
    SetPedFiringPattern(playerClone, 0xC6EE6B4C)
end)

RegisterNetEvent('Chaos:Player:Drunk', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("I think you might've had a bit too much to drink")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerId = PlayerPedId()
        ---@type integer
        local timeUntilSteer = 0
        local enableDrunkSteering = false
        ---@type number
        local steering
        while true do
            if exitMethod then
                break
            end

            if not IsGameplayCamShaking() then
                ShakeGameplayCam("DRUNK_SHAKE", 2.)
            end

            SetPedIsDrunk(playerId, true)

            RequestClipSet("MOVE_M@DRUNK@VERYDRUNK")
            SetPedMovementClipset(playerId, "MOVE_M@DRUNK@VERYDRUNK", 1.)

            SetAudioSpecialEffectMode(2)
            CustomMenuCoordinates(1.)
            N_0x0225778816fdc28c(1.)

            -- Steer randomly
            if IsPedInAnyVehicle(playerId, false) then
                local playerVehicle = GetVehiclePedIsIn(playerId, false)
                if GetPedInVehicleSeat(playerVehicle, -1) == playerId then

                    if enableDrunkSteering then
                        SetVehicleSteerBias(playerVehicle, steering)
                    end

                    local currentTick = GetGameTimer()
                    if timeUntilSteer < currentTick then
                        timeUntilSteer = currentTick

                        if enableDrunkSteering then
                            timeUntilSteer = timeUntilSteer + math.random(100, 500)
                        else
                            steering = math.random(-5, 5) / 10
                            timeUntilSteer = timeUntilSteer + math.random(50, 300)
                        end

                        enableDrunkSteering = not enableDrunkSteering
                    end
                end
            end

            Citizen.Wait(0)
        end

        SetPedIsDrunk(playerId, false)

        ResetPedMovementClipset(playerId, 0.)
        RemoveClipSet("MOVE_M@DRUNK@VERYDRUNK")

        StopGameplayCamShaking(true)

        CustomMenuCoordinates(0.)
        N_0x0225778816fdc28c(0.)
    end)
end)

RegisterNetEvent('Chaos:Player:FlipCamera', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Are you recording your facecam? You look pretty dumb tilting your head")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local flippedCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        RenderScriptCams(true, true, 700, 1, true, true)
        while true do
            if exitMethod then
                break
            end

            SetCamActive(flippedCamera, true)
            local camCoords = GetGameplayCamCoord()
            local camRotation = GetGameplayCamRot(2)
            SetCamParams(
                flippedCamera,
                camCoords.x, camCoords.y, camCoords.z,
                camRotation.x, 180., camRotation.z,
                GetGameplayCamFov(),
                0, 1, 1, 2
            )

            Citizen.Wait(0)
        end
        SetCamActive(flippedCamera, false)
        RenderScriptCams(false, true, 700, 1, true, true)
        DestroyCam(flippedCamera, true)
        flippedCamera = nil
    end)
end)

RegisterNetEvent('Chaos:Player:Fling', function(duration)
    local minValue = 500
    local maxValue = 10000
    local function GetRandomForce(negativeAllowed)
        ---@type number
        local result
        if negativeAllowed then
            result = math.random(minValue, maxValue) * ((math.random(0, 1) == 1) and 1 or -1)
        else
            result = math.random(minValue, maxValue)
        end

        return ToFloat(result)
    end
    
    exports.helpers:DisplayMessage("FLING!")

    local playerId = PlayerPedId()
    ---@type Entity
    local flipTarget

    if IsPedInAnyVehicle(playerId, false) then
        flipTarget = GetVehiclePedIsIn(playerId, false)
    else
        flipTarget = playerId
        SetPedToRagdoll(playerId, 5000, 0, 0, true, true, false)
    end

    ApplyForceToEntityCenterOfMass(
        flipTarget, 1, 
        GetRandomForce(true), GetRandomForce(true), GetRandomForce(false),
        false, false, true, false
    )
end)

RegisterNetEvent('Chaos:Player:GTA2', function(duration)
    local height = 35.0
    local speedFactor = 1.0 + (0.5 / (180. / 2.236936))

    local topCamera = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
    SetCamRot(topCamera, -90., 0., 0., 2)

    RenderScriptCams(true, true, 500, false, true, false)
    local baseFov = 25.

    SetCamAffectsAiming(topCamera, false)

    local exitMethod = false
    exports.helpers:DisplayMessage("Let's play Grand Theft Auto!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local playerSpeed = GetEntitySpeed(PlayerPedId())
            local camOffset = playerSpeed * speedFactor

            SetCamFov(topCamera, baseFov + camOffset)
            local playerPos = GetEntityCoords(PlayerPedId())
            SetCamCoord(topCamera, playerPos.x, playerPos.y, playerPos.z + height)

            Citizen.Wait(0)
        end

        RenderScriptCams(false, false, 500, false, true, false)
        SetCamAffectsAiming(topCamera, true)
        DestroyCam(topCamera, true)
    end)
end)

RegisterNetEvent('Chaos:Player:HeavyRecoil', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Heavy recoil")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local verticalRecoil = 1
        local playerId = PlayerPedId()
        while true do
            if exitMethod then
                break
            end

            if IsPedShooting(playerId) then
                local _, weaponHash = GetCurrentPedWeapon(playerId)
                -- If weapon shoots bullets
                if GetWeaponDamageType(weaponHash) == 3 then
                    local horizontalRecoil = math.random(-100, 100) / 10
                    for i = 0, 10 do
                        SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + (verticalRecoil / 10), 1.)
                        SetGameplayCamRelativeHeading(GetGameplayCamRelativeHeading() + (horizontalRecoil / 10))
                        Citizen.Wait(0)
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Player:Ignite', function(duration)
    exports.helpers:DisplayMessage("You're lit")

    for _, playerId in ipairs(GetActivePlayers()) do
        local playerPed = GetPlayerPed(playerId)
        if IsPedInAnyVehicle(playerPed, false) then
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            SetVehicleEngineHealth(playerVehicle, -1.)
            SetVehiclePetrolTankHealth(playerVehicle, -1.)
            SetVehicleBodyHealth(playerVehicle, -1.)
        else
            StartEntityFire(playerPed)
        end
    end
end)

RegisterNetEvent('Chaos:Player:ImTired', function(duration)
    local sleepDuration = 3000

    local exitMethod = false
    exports.helpers:DisplayMessage("Getting.. sleepy...")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local alpha = 0
        local closingIterator = 20
        local currentMode = 2 -- 0 = closingEyes, 1 = openingEyes, 2 = waiting
        ---@type integer
        local nextTimestamp = 0
        local playerPed = PlayerPedId()
        local steeringDirection = 0.
        while true do
            if exitMethod then
                break
            end

            local gameTime = GetGameTimer()
            if currentMode == 0 then
                alpha = alpha + closingIterator
                -- Chance for player who's on foot to ragdoll halfway through blinking
                if alpha / closingIterator == math.floor(255. / closingIterator / 2.) and math.random(0, 10) / 10 < .25 then
                    if not IsPedInAnyVehicle(playerPed, false) then
                        SetPedToRagdoll(playerPed, sleepDuration, sleepDuration, 0, true, true, false)
                    end
                end

                if alpha > 200 then
                    if IsPedInAnyVehicle(playerPed, false) then
                        SetVehicleSteerBias(GetVehiclePedIsIn(playerPed, false), steeringDirection)
                    end
                end

                if alpha >= 255 then
                    currentMode = 1
                    nextTimestamp = gameTime + (20 - closingIterator) * 20
                end
            elseif currentMode == 1 then
                if gameTime > nextTimestamp then
                    alpha = alpha - 30
                    if alpha <= 0 then
                        alpha = 0
                        currentMode = 2
                        nextTimestamp = gameTime + math.random(250, 3000)
                    end
                end
            else
                if gameTime > nextTimestamp then
                    currentMode = 0
                    steeringDirection = math.random(0, 1) == 1 and 1. or -1.
                end
            end
            DrawRect(.5, .5, 1., 1., 0, 0, 0, alpha)

            Citizen.Wait(0)
        end
        DrawRect(.5, .5, 1., 1., 0, 0, 0, 0)
    end)
end)

RegisterNetEvent('Chaos:Player:KeepRunning', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Ain't nothing gonna break my stride", false)
    exports.helpers:DisplayMessage("Nobody gonna slow me down, oh no", false)

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            SimulatePlayerInputGait(PlayerPedId(), 5., 100, 1., true, false)

            SetControlNormal(0, 32, 1.)
            SetControlNormal(0, 71, 1.)
            SetControlNormal(0, 77, 1.)
            SetControlNormal(0, 87, 1.)
            SetControlNormal(0, 129, 1.)
            SetControlNormal(0, 136, 1.)
            SetControlNormal(0, 150, 1.)
            SetControlNormal(0, 232, 1.)
            SetControlNormal(0, 280, 1.)

            -- Disable all brake and descend actions
            DisableControlAction(0, 72, true)
            DisableControlAction(0, 76, true)
            DisableControlAction(0, 88, true)
            DisableControlAction(0, 138, true)
            DisableControlAction(0, 139, true)
            DisableControlAction(0, 152, true)
            DisableControlAction(0, 153, true)

            -- Disable aiming actions, would cancel forward movement
            DisableControlAction(0, 25, true) -- INPUT_AIM
            DisableControlAction(0, 44, true) -- INPUT_COVER
            DisableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
            DisableControlAction(0, 68, true) -- INPUT_VEH_AIM

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Player:Kickflip', function(duration)
    TriggerEvent("Client:SoundToClient", "barrel_roll", 1.0)
    exports.helpers:DisplayMessage("Do a barrel roll")

    local playerPed = PlayerPedId()
    ---@type Entity
    local flipTarget

    Citizen.Wait(1000)
    if IsPedInAnyVehicle(playerPed, false) then
        flipTarget = GetVehiclePedIsIn(playerPed, false)
    else
        flipTarget = playerPed
        SetPedToRagdoll(playerPed, 200, 0, 0, true, true, false)
    end

    ApplyForceToEntity(
        flipTarget, 1, 0., 0., 10., 2., 0., 0.,
        0, true, true, true, false, true
    )
end)

RegisterNetEvent('Chaos:Player:Pacifist', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Pacifism rocks!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastPlayerHits = -1
        local playerPed = PlayerPedId()
        while true do
            if exitMethod then
                break
            end

            local _, playerHits = StatGetInt("MP0_HITS", -1)
            if lastPlayerHits >= 0 and playerHits > lastPlayerHits then
                Citizen.CreateThread(function()
                    StartEntityFire(playerPed)
                    Citizen.Wait(1000)
                    StopEntityFire(playerPed)
                end)
            end
            lastPlayerHits = playerHits

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Player:Poof', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Deadly Aim")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerId = PlayerId()
        while true do
            if exitMethod then
                break
            end

            StopGameplayCamShaking(true)

            local targetExists, aimTarget = GetEntityPlayerIsFreeAimingAt(playerId)
            if targetExists then
                if IsEntityAPed(aimTarget) or IsEntityAVehicle(aimTarget) and not IsEntityDead(aimTarget, false) then
                    local targetPos = GetEntityCoords(aimTarget)
                    SetEntityHealth(aimTarget, 0, 0)
                    SetEntityInvincible(aimTarget, false)
                    AddExplosion(targetPos.x, targetPos.y, targetPos.z, 9, 100., true, false, 3.)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Player:QuakeFOV', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Remember Quake?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local fovCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        RenderScriptCams(true, true, 700, 1, true, true)
        while true do
            if exitMethod then
                break
            end

            SetCamActive(fovCamera, true)
            local camCoords = GetGameplayCamCoord()
            local camRotation = GetGameplayCamRot(2)
            SetCamParams(
                fovCamera,
                camCoords.x, camCoords.y, camCoords.z,
                camRotation.x, camRotation.y, camRotation.z,
                120., 0, 1, 1, 2
            )

            Citizen.Wait(0)
        end
        SetCamActive(fovCamera, false)
        RenderScriptCams(false, true, 700, 1, true, true)
        DestroyCam(fovCamera, true)
        fovCamera = nil
    end)
end)

RegisterNetEvent('Chaos:Player:SimeonSays', function(duration)
    exports.helpers:DisplayMessage("Simeon Says...")

    local randomActionIndex = math.random(1, #SimonSaysActions)
    local flipCommand = (math.random(0, 1) == 1) and true or false
    local currentlyDead = false

    local function ShowPopup()
        local message = flipCommand and "Simeon Says: " or "Don't "

        message = message .. SimonSaysActions[randomActionIndex][1]

        local scaleForm = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
        while not HasScaleformMovieLoaded(scaleForm) do
            Citizen.Wait(100)
        end

        local exitLoop = false
        Citizen.SetTimeout(2000 * 0.1, function() exitLoop = true end)

        SetTimeScale(0.1)
        BeginScaleformMovieMethod(scaleForm, "SHOW_SHARD_RANKUP_MP_MESSAGE")
        ScaleformMovieMethodAddParamPlayerNameString(message)
        EndScaleformMovieMethod()

        while not exitLoop do
            Citizen.Wait(0)
            DrawScaleformMovieFullscreen(scaleForm, 255, 255, 255, 255, 0)
        end

        SetTimeScale(1.)
    end

    exports.helpers:ScaleformMessage("Pay very close attention to the command...", 2)
    ShowPopup()

    local exitMethod = false

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            local killPlayer = false
            if flipCommand then
                for _, actionKey in pairs(SimonSaysActions[randomActionIndex][2]) do
                    if IsControlPressed(0, actionKey) or IsControlJustPressed(0, actionKey) then
                        killPlayer = true
                    end
                end
            else
                if not IsPlayerCamControlDisabled() then
                    killPlayer = true
                    for _, actionKey in pairs(SimonSaysActions[randomActionIndex][2]) do
                        if IsControlPressed(0, actionKey) or IsControlJustPressed(0, actionKey) then
                            killPlayer = false
                        end
                    end
                end
            end

            if IsPedDeadOrDying(PlayerPedId(), false) or not IsScreenFadedIn() then
                currentlyDead = true
            elseif currentlyDead then
                ShowPopup()
                currentlyDead = false
            elseif killPlayer then
                local playerPos = GetEntityCoords(PlayerPedId())
                SetEntityHealth(PlayerPedId(), 0)
                AddExplosion(playerPos.x, playerPos.y, playerPos.z, 9, 100., true, false, 3., false)
            end

            Citizen.Wait(0)
        end


        exports.helpers:ScaleformMessage("Finished!", 2)
    end)
end)

RegisterNetEvent('Chaos:Player:SuperRunJump', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Super Jump!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerId = PlayerId()
        SetRunSprintMultiplierForPlayer(playerId, 1.49)
        while true do
            if exitMethod then
                break
            end

            SetSuperJumpThisFrame(playerId)

            Citizen.Wait(0)
        end
        SetRunSprintMultiplierForPlayer(playerId, 1.)
    end)
end)

RegisterNetEvent('Chaos:Player:VR', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Let's play virtual reality!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        -- Recall position
        local playerHeading = GetEntityHeading(playerPed)
        local playerCoords = GetEntityCoords(playerPed)
        local playerRotation = GetEntityRotation(playerPed, 0)

        local camModes = {
            GetFollowPedCamViewMode(),
            GetFollowVehicleCamViewMode(),
            GetFollowVehicleCamZoomLevel()
        }

        -- Create clone. ClonePed() wasn't playing nice with entity deletion
        local pedType = GetPedType(playerPed)
        local playerModel = GetEntityModel(playerPed)

        RequestModel(playerModel)
        while not HasModelLoaded(playerModel) do
            Citizen.Wait(100)
        end
        
        local playerClone = CreatePed(
            pedType, playerModel,
            playerCoords.x, playerCoords.y, playerCoords.z,
            playerHeading
        )
        SetModelAsNoLongerNeeded(playerModel)
        ClonePedToTarget(playerPed, playerClone) -- Ensure that clone looks like player

        -- Fix an issue where the clone is placed above the player
        local _, groundZ = GetGroundZFor_3dCoord(playerCoords.x, playerCoords.y, playerCoords.z, false)
        playerCoords = vector3(playerCoords.x, playerCoords.y, groundZ)
        
        SetEntityCoords(playerClone, playerCoords.x, playerCoords.y, playerCoords.z, false, false, false, true)
        SetEntityRotation(playerClone, playerRotation.x, playerRotation.y, playerRotation.z, 0, true)
        SetEntityInvincible(playerClone, true)
        FreezeEntityPosition(playerClone, true)
        StopPedSpeaking(playerClone, true)
        DisablePedPainAudio(playerClone, true)

        -- Handle cars
        ---@type Vehicle
        local vehicleClone
        if IsPedInAnyVehicle(playerPed, false) then
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)

            local vehicleModel = GetEntityModel(playerVehicle)
            local vehicleLocation = GetEntityCoords(playerVehicle)
            local vehicleColours = GetVehicleColourCombination(playerVehicle)


            RequestModel(vehicleModel)
            while not HasModelLoaded(vehicleModel) do
                Citizen.Wait(100)
            end
            
            vehicleClone = CreateVehicle(
                vehicleModel,
                vehicleLocation.x, vehicleLocation.y, vehicleLocation.z,
                GetEntityHeading(playerVehicle)
            )
            SetModelAsNoLongerNeeded(vehicleModel)

            SetVehicleColourCombination(vehicleClone, vehicleColours)
            SetEntityInvincible(vehicleClone, true)
            SetEntityNoCollisionEntity(vehicleClone, playerVehicle, false)
            
            -- Find seat player is in
            local maxSeats = GetVehicleModelNumberOfSeats(vehicleModel)
            local vehicleSeat = 0
            for i = -1, maxSeats do
                if GetPedInVehicleSeat(playerVehicle, i) == playerPed then
                    vehicleSeat = i
                    break
                end
            end

            SetPedIntoVehicle(playerClone, vehicleClone, vehicleSeat)
        end

        PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", false)
        while true do
            if exitMethod then
                break
            end

            if GetTimecycleTransitionModifierIndex() == -1 and GetTimecycleModifierIndex() == -1 then
                SetTransitionTimecycleModifier("secret_camera", 1.5)
            end

            -- Replicate weapon
            GiveWeaponToPed(playerClone, GetSelectedPedWeapon(playerPed), 9999, true, true)

            -- Force first person
            SetCinematicModeActive(false)

            SetFollowPedCamViewMode(4)
            SetFollowVehicleCamViewMode(4)
            SetFollowVehicleCamZoomLevel(4)

            DisableControlAction(0, 0, true)

            Citizen.Wait(0)
        end

        TeleportPlayer(playerCoords)
        SetEntityHeading(playerPed, playerHeading)
        SetEntityRotation(playerPed, playerRotation.x, playerRotation.y, playerRotation.z, 0, true)
        PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 1)

        -- Clean up clone
        SetEntityAsMissionEntity(playerClone, false, false)
        DeletePed(playerClone)

        SetEntityAsMissionEntity(vehicleClone, true, true)
        DeleteVehicle(vehicleClone)

        -- Clean up first person
        SetFollowPedCamViewMode(camModes[1])
        SetFollowVehicleCamViewMode(camModes[2])
        SetFollowVehicleCamZoomLevel(camModes[3])

        -- Clear camera effects
        ClearTimecycleModifier()
    end)
end)

RegisterNetEvent('Chaos:Player:WalkOnWater', function(duration)
    local displayModel = "prop_huge_display_01"

    local exitMethod = false
    exports.helpers:DisplayMessage("Take a leaf out of your favourite messiah's book and walk on water!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        ---@type Object
        local waterScreenObject
        RequestModel(displayModel)
        while not HasModelLoaded(displayModel) do
            Citizen.Wait(100)
        end

        while true do
            if exitMethod then
                break
            end

            local playerCoords = GetEntityCoords(playerPed)

            waterScreenObject = GetClosestObjectOfType(
                playerCoords.x, playerCoords.y, playerCoords.z,
                300., displayModel, true, false, true
            )

            local _, waterZ = GetWaterHeight(playerCoords.x, playerCoords.y, playerCoords.z)
            if waterZ > -1000. then
                if DoesEntityExist(waterScreenObject) then
                    SetEntityCoords(waterScreenObject, playerCoords.x, playerCoords.y, waterZ, true, false, false, false)
                    if playerCoords.z < waterZ then
                        if IsPedInAnyVehicle(playerPed, false) then
                            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
                            local vehicleCoords = GetEntityCoords(playerVehicle)
                            SetEntityCoords(playerVehicle, vehicleCoords.x, vehicleCoords.y, vehicleCoords.z)
                        end
                    end
                end
            else
                waterScreenObject = CreateObject(displayModel, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
                SetEntityRotation(waterScreenObject, 90., 0., 0., 2, true)
                FreezeEntityPosition(waterScreenObject, true)
                SetEntityVisible(waterScreenObject, false, false)
            end

            Citizen.Wait(0)
            end
        SetModelAsNoLongerNeeded(displayModel)
        if DoesEntityExist(waterScreenObject) then
            DeleteObject(waterScreenObject)
        end
    end)
end)

RegisterNetEvent('Chaos:Player:ZoomZoomCam', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Zooooooooooom in")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        local zoomCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        RenderScriptCams(true, true, 10, true, true)
        local camZoom = 80.
        local camZoomRate = .6
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if currentTick > lastTick + 5 then
                lastTick = currentTick

                if camZoom < 11 or camZoom > 119 then
                    camZoomRate = camZoomRate * -1
                end
                camZoom = camZoom + camZoomRate
            end

            SetCamActive(zoomCamera, true)
            local camCoords = GetGameplayCamCoord()
            local camRotation = GetGameplayCamRot(2)
            SetCamParams(
                    zoomCamera, camCoords.x, camCoords.y, camCoords.z,
                    camRotation.x, camRotation.y, camRotation.z, camZoom,
                    0, 1, 1, 2
            )

            Citizen.Wait(0)
        end
        SetCamActive(zoomCamera, false)
        RenderScriptCams(false, true, 700, true, true)
        DestroyCam(zoomCamera, true)
        zoomCamera = nil
    end)
end)
