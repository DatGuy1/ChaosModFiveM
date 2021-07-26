---Handles creation and disposal of ped
---@param pedType integer
---@param modelName string
---@param spawnPos vector3
---@param spawnHeading number
---@return Ped Created ped
local function CreatePoolPed(pedType, modelName, spawnPos, spawnHeading)
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Citizen.Wait(100)
    end

    local createdPed = CreatePed(pedType, modelName, spawnPos.x, spawnPos.y, spawnPos.z, spawnHeading, true, false)

    SetModelAsNoLongerNeeded(modelName)
    return createdPed
end

---Handles creation and disposal of ped inside vehicle
---@param targetVehicle Vehicle
---@param pedType integer
---@param modelName string
---@param seatIndex integer
---@return Ped Created ped
local function CreatePoolPedInsideVehicle(targetVehicle, pedType, modelName, seatIndex)
    RequestModel(modelName)
    while not HasModelLoaded(modelName) do
        Citizen.Wait(100)
    end

    local createdPed = CreatePedInsideVehicle(targetVehicle, pedType, modelName, seatIndex, true, false)

    SetModelAsNoLongerNeeded(modelName)
    return createdPed
end

---Creates ped 'modelName' hostile to player, immune to fire and explosions, with optional weapon 'weaponHash', in player's vehicle (if exists), and can't ragdoll from player
---@param modelName string
---@param weaponHash string
---@return Ped Created hostile ped
local function CreateHostilePed(modelName, weaponHash)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed, false)

    local playerGroup = "PLAYER"
    local civGroup = "CIVMALE"
    local femCivGroup = "CIVFEMALE"

    local _, relationshipGroup =  AddRelationshipGroup("_HOSTILE_PED")
    SetRelationshipBetweenGroups(5, relationshipGroup, playerGroup)
    SetRelationshipBetweenGroups(5, relationshipGroup, civGroup)
    SetRelationshipBetweenGroups(5, relationshipGroup, femCivGroup)

    local createdPed = CreatePoolPed(4, modelName, playerPos.x, playerPos.y, playerPos.z, 0.)
    if IsPedInAnyVehicle(playerPed, false) then
        SetPedIntoVehicle(createdPed, GetVehiclePedIsIn(playerPed, false), -2)
    end

    SetPedRelationshipGroupHash(createdPed, relationshipGroup)
    SetPedHearingRange(createdPed, 9999.)
    SetPedConfigFlag(createdPed, 281, true)

    -- Make immune to fire and explosions
    SetEntityProofs(createdPed, false, true, true, false, false, false, false, false)

    -- BF_CanFightArmedPedsWhenNotArmed
    SetPedCombatAttributes(createdPed, 5, true)
    -- BF_AlwaysFight
    SetPedCombatAttributes(createdPed, 46, true)

    SetPedCanRagdollFromPlayerImpact(createdPed, false)
    SetRagdollBlockingFlags(createdPed, 5)
    SetPedSuffersCriticalHits(createdPed, false)

    if weaponHash then
        GiveWeaponToPed(createdPed, weaponHash, 9999, true, true)
    end
    TaskCombatPed(createdPed, playerPed, 0, 16)

    SetPedFiringPattern(createdPed, "FIRING_PATTERN_FULL_AUTO")
    return createdPed
end

---Takes vector3 of degrees and converts to radians
---@param angles vector3 vector3 of angles in degrees
---@return vector3 vector3 of angles in radians
local function DegToRadian(angles)
    local magicNumber = .0174532925199433
    return vector3(
            angles.x * magicNumber,
            angles.y * magicNumber,
            angles.z * magicNumber
    )
end

---Gives ped a red (enemy) blip on the map, automatically handled by the game
---@param ped Ped
---@return void
local function GivePedEnemyBlip(ped)
    SetPedHasAiBlip(ped, true)
    SetBlipAsFriendly(GetAiBlip(ped), false)
end

RegisterNetEvent('Chaos:Peds:Aimbot', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Enemies have aimbot")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    SetPedAccuracy(ped, 100)
                    SetPedFiringPattern(ped, "FIRING_PATTERN_FULL_AUTO")
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:AttackPlayer', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("AI attacks player")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local _, relationshipGroup = AddRelationshipGroup("_ATTACK_PLAYER")
        local enemyGroupHash = "_ATTACK_PLAYER"
        local playerGroupHash = "PLAYER"

        SetRelationshipBetweenGroups(5, enemyGroupHash, playerGroupHash)
        SetRelationshipBetweenGroups(5, playerGroupHash, enemyGroupHash)

        local playerId = PlayerId()
        local playerPed = PlayerPedId()
        local playerGroup = GetPlayerGroup(playerId)
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    if IsPedInGroup(ped) and GetPedGroupIndex(ped) == playerGroup then
                        RemovePedFromGroup(ped)
                    end

                    SetPedRelationshipGroupHash(ped, enemyGroupHash)

                    -- BF_CanFightArmedPedsWhenNotArmed
                    SetPedCombatAttributes(ped, 5, true)
                    -- BF_AlwaysFight
                    SetPedCombatAttributes(ped, 46, true)
                    -- Never flee
                    SetPedFleeAttributes(ped, 2, true)

                    TaskCombatPed(ped, playerPed, 0, 16)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Blind', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Blind AI")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerId = PlayerId()
        for ped in exports.helpers:EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                ClearPedTasks(ped)
            end
        end
        while true do
            if exitMethod then
                break
            end

            SetEveryoneIgnorePlayer(playerId, true)
            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    SetPedSeeingRange(ped, .0)
                    SetPedHearingRange(ped, .0)

                    SetBlockingOfNonTemporaryEvents(ped, true)
                    SetPedShootRate(ped, 0)
                    SetPedFiringPattern(ped, "FIRING_PATTERN_SLOW_FIRE_TANK")
                    -- BF_PlayerCanUseFiringWeapons, basically don't let ped use weapons
                    SetPedCombatAttributes(ped, 1424, false)
                end
            end

            Citizen.Wait(0)
        end

        SetEveryoneIgnorePlayer(playerId, false)
        for ped in exports.helpers:EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                SetPedSeeingRange(ped, 9999.)
                SetPedHearingRange(ped, 9999.)

                SetBlockingOfNonTemporaryEvents(ped, false)
                SetPedShootRate(ped, 100)
                SetPedFiringPattern(ped, "FIRING_PATTERN_FULL_AUTO")
                SetPedCombatAttributes(ped, 1424, true)
            end
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:BusBoys', function(duration)
    -- not sure exactly what to make this, 60 seemed to work ok
    local MaxDistance = 60.
    exports.helpers:DisplayMessage("Watch out, the bus boys are coming for you")

    Citizen.CreateThread(function()
        local busName = "BUS"
        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed, true)

        for ped in exports.helpers:EnumeratePeds() do
            if not IsPedAPlayer(ped) and not IsPedDeadOrDying(ped, true) then
                local pedPos = GetEntityCoords(ped, true)
                if GetDistanceBetweenCoords(
                        pedPos.x, pedPos.y, pedPos.z,
                        playerPos.x, playerPos.y, playerPos.z,
                        true
                ) <= MaxDistance then
                    -- If we're already in bus, continue
                    if IsPedInAnyVehicle(ped, false) then
                        local playerVehicle = GetVehiclePedIsIn(ped, false)
                        if GetEntityModel(playerVehicle) == busName then
                            goto continue
                        end
                    end

                    -- Otherwise, create the bus
                    local pedHeading = GetEntityHeading(ped)

                    SetEntityCoords(ped, pedPos.x, pedPos.y, pedPos.z + 10., false, false, false, false)
                    SetPedCombatAttributes(ped, 3, false) -- Disallow leaving vehicle
                    SetBlockingOfNonTemporaryEvents(ped, true)

                    RequestModel(busName)
                    while not HasModelLoaded(busName) do
                        Citizen.Wait(100)
                    end

                    local busVehicle = CreateVehicle(busName, pedPos.x, pedPos.y, pedPos.z, pedHeading, true, false)
                    SetModelAsNoLongerNeeded(busName)

                    SetPedIntoVehicle(ped, busVehicle, -1)
                    -- missionType 13 = ?
                    TaskVehicleMissionPedTarget(ped, busVehicle, playerPed, 13, 9999., 4176732, .0, .0, false)
                end
            end
            ::continue::
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:CatGuns', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Cat in a hat. Or a gun. Same thing.")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local shotgunHash = 860033945
        local catHash = "a_c_cat_01"
        RequestModel(catHash)
        while not HasModelLoaded(catHash) do
            Citizen.Wait(100)
        end

        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if IsPedShooting(ped) then
                    ---@type vector3
                    local spawnPos
                    ---@type vector3
                    local spawnRot

                    if ped == playerPed then
                        spawnRot = GetGameplayCamRot(2)
                        local camCoords = GetGameplayCamCoord()
                        local pedPos = GetEntityCoords(ped, false)

                        local distCamToPed = GetDistanceBetweenCoords(
                                pedPos.x, pedPos.y, pedPos.z,
                                camCoords.x, camCoords.y, camCoords.z,
                                true
                        ) + .5

                        -- Get coords from gameplay cam
                        local camRotation = DegToRadian(spawnRot)
                        local rotationY = distCamToPed * math.cos(spawnRot.x)

                        spawnPos = vector3(
                                camCoords.x + rotationY * math.sin(spawnRot.z * -1),
                                camCoords.y + rotationY * math.cos(spawnRot.z * -1),
                                camCoords.z + distCamToPed * math.sin(spawnRot.x)
                        )
                    else
                        spawnPos = GetOffsetFromEntityInWorldCoords(ped, .0, 1., .0)
                        spawnRot = GetEntityRotation(ped, 2)
                    end

                    local isShotgun = GetWeapontypeGroup(GetSelectedPedWeapon(playerPed)) == shotgunHash
                    local catCount = isShotgun and 3 or 1
                    for i = 0, catCount do
                        if i > 0 then
                            Citizen.Wait(0)
                        end

                        if isShotgun then
                            spawnPos = vector3(spawnPos.x, spawnPos.y, spawnPos.z + (i - 1) * .25)
                        end

                        local catPed = CreatePed(28, catHash, spawnPos.x, spawnPos.y, spawnPos.z, .0, true, false)
                        SetEntityRotation(catPed, spawnRot.x, spawnRot.y, spawnRot.z, 2, true)

                        SetPedToRagdoll(catPed, 3000, 3000, 0, true, true, false)
                        ApplyForceToEntityCenterOfMass(catPed, 1, .0, 300., 0., false, true, true, false)

                        SetPedAsNoLongerNeeded(catPed)
                    end
                end
            end

            Citizen.Wait(0)
        end

        SetModelAsNoLongerNeeded(catHash)
    end)
end)

RegisterNetEvent('Chaos:Peds:Cops', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Police here, police there, police everywhere! Just don't commit a crime!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                local pedType = GetPedType(ped)
                if not IsPedAPlayer(ped) and pedType > 2 and pedType ~= 6 then
                    SetPedAsCop(ped, true)
                    GiveWeaponToPed(ped, "weapon_pistol", 9999, true, false)
                    SetPedCombatAttributes(ped, 46, true)
                end
            end

            Citizen.Wait(300)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:DriveBackwards', function(duration)
    local DRIVING_STYLE = 1024; -- "Drive in reverse gear" bit

    local exitMethod = false
    exports.helpers:DisplayMessage("Put it in reverse Terry!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) and IsPedInAnyVehicle(ped, false) then
                    SetDriveTaskDrivingStyle(ped, DRIVING_STYLE)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:DriveByPlayer', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("POV: You're John Wick during the third movie")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local weaponHash = "WEAPON_MACHINEPISTOL"

        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) and IsPedInAnyVehicle(ped, false) then
                    GivePedEnemyBlip(ped)

                    SetBlockingOfNonTemporaryEvents(ped, true)

                    GiveWeaponToPed(ped, weaponHash, 9999, true, true)
                    TaskDriveBy(ped, playerPed, 0, 0., 0., 0., -1., 5, false, "FIRING_PATTERN_FULL_AUTO")
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:EternalScreams', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHH")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                PlayPain(ped, 8, 0, 0)
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:ExplosivePeds', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Explosive People")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    local maxHealth = GetEntityMaxHealth(ped)

                    if maxHealth > 0 and (IsPedInjured(ped) or IsPedRagdoll(ped)) then
                        local pedPos = GetEntityCoords(ped, false)

                        AddExplosion(pedPos.x, pedPos.y, pedPos.z, 4, 9999., true, false, 1.)
                        SetEntityHealth(ped, 0)
                        SetEntityMaxHealth(ped, 0)
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:ExplosiveCombat', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Explosive Combat")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerId = PlayerId()
        while true do
            if exitMethod then
                break
            end

            SetExplosiveAmmoThisFrame(playerId)
            SetExplosiveMeleeThisFrame(playerId)
            for ped in exports.helpers:EnumeratePeds() do
                local coordFound, impactCoords = GetPedLastWeaponImpactCoord(ped)
                if coordFound then
                    AddExplosion(impactCoords.x, impactCoords.y, impactCoords.z, 4, 9999., true, false, 1.)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Famous', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("I'm a Celebrity... Get Me Out of Here!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        ---@type Vehicle
        local savedPlayerVehicle
        local lastTick = GetGameTimer()
        while true do
            if exitMethod then
                break
            end

            local playerInVehicle = IsPedInAnyVehicle(playerPed, false)
            if playerInVehicle then
                savedPlayerVehicle = GetVehiclePedIsIn(playerPed, false)
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 2000 then
                local count = 3
                for ped in exports.helpers:EnumeratePeds() do
                    if not IsPedAPlayer(ped) then
                        local pedInVehicle = IsPedInAnyVehicle(ped, true)
                        local pedGettingIntoVehicle = IsPedGettingIntoAVehicle(ped)
                        local pedVehicle = GetVehiclePedIsIn(ped, false)
                        local pedTargetVehicle = GetVehiclePedIsEntering(ped)

                        if playerInVehicle and (not pedInVehicle or pedVehicle ~= savedPlayerVehicle) and (not pedGettingIntoVehicle or pedTargetVehicle ~= savedPlayerVehicle) then
                            TaskEnterVehicle(ped, savedPlayerVehicle, -1, -2, 2., 1, 0)
                        elseif (pedInVehicle and pedVehicle == savedPlayerVehicle) or (pedGettingIntoVehicle and pedTargetVehicle == savedPlayerVehicle) then
                            if GetPedInVehicleSeat(savedPlayerVehicle, -1, 0) == ped then
                                TaskVehicleDriveWander(ped, savedPlayerVehicle, 9999., 10)
                            end
                        else
                            TaskFollowToOffsetOfEntity(ped, playerPed, .0, .0, .0, 9999., -1, .0, true)
                        end

                        SetBlockingOfNonTemporaryEvents(ped, true)

                        count = count - 1
                        if count == 0 then
                            count = 3
                            Citizen.Wait(0)
                        end
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:FlipAll', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("The AI joined a ballerina troupe")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedInAnyVehicle(ped, false) and not IsPedAPlayer(ped) then
                    local playerRotation = GetEntityRotation(ped, 2)
                    SetEntityRotation(ped, playerRotation.x + 40., playerRotation.y + 40., playerRotation.z, 2, true)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:GunSmoke', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Gun smoke!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local particleAsset = "scr_sr_tr"

        RequestNamedPtfxAsset(particleAsset)
        while not HasNamedPtfxAssetLoaded(particleAsset) do
            Citizen.Wait(100)
        end
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if IsPedShooting(ped) then
                    local pedPos = GetEntityCoords(ped, false)
                    UseParticleFxAsset(particleAsset)
                    StartParticleFxNonLoopedAtCoord(
                            "scr_sr_tr_car_change",
                            pedPos.x, pedPos.y, pedPos.z,
                            0., 0., 0., 1.,
                            false, true, false
                    )
                end
            end

            Citizen.Wait(0)
        end

        RemoveNamedPtfxAsset(particleAsset)
    end)
end)

RegisterNetEvent('Chaos:Peds:HandsUp', function(duration)
    exports.helpers:DisplayMessage("Hands up!")

    Citizen.CreateThread(function()
        for ped in exports.helpers:EnumeratePeds() do
            local pedType = GetPedType()
            -- 6 = cop, 27 = NOOSE
            if pedType ~= 6 and pedType ~= 27 and not IsPedDeadOrDying(ped, true) then
                TaskHandsUp(ped, 5000, 0, -1, true)
                SetPedDropsWeapon(ped)
            end
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:InTheHood', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Just Dance!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local animationDict = "missfbi3_sniping"
        RequestAnimDict(animationDict)
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsEntityPlayingAnim(ped, animationDict, "dance_m_default", 3) then
                    if IsPedAPlayer(ped) then
                        Citizen.SetTimeout(duration * 1000, function() ClearPedTasksImmediately(ped) end)
                    end
                    TaskPlayAnim(ped, animationDict, "dance_m_default", 4., -4., -1, 1, 0., false, false, false)
                end
            end

            Citizen.Wait(0)
        end

        RemoveAnimDict(animationDict)
    end)
end)

RegisterNetEvent('Chaos:Peds:JamesBond', function(duration)
    exports.helpers:DisplayMessage("The name's...")

    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local bondModel = "cs_milton"
        local carModel = "JB700"

        local playerGroup = "PLAYAER"
        local _, relationshipGroup = AddRelationshipGroup("_HOSTILE_BOND")
        SetRelationshipBetweenGroups(5, relationshipGroup, playerGroup)

        local playerPos = GetEntityCoords(playerPed, false)
        local playerHeading = GetEntityHeading(IsPedInAnyVehicle(playerPed, false) and GetVehiclePedIsIn(playerPed, false) or playerPed)

        local xPos = math.sin((360 - playerHeading) * math.pi / 180) * 100
        local yPos = math.cos((360 - playerHeading) * math.pi / 180) * 100

        RequestModel(carModel)
        while not HasModelLoaded(carModel) do
            Citizen.Wait(50)
        end

        local createdVehicle = CreateVehicle(carModel, playerPos.x - xPos, playerPos.y - yPos, playerPos.z, playerHeading)
        SetModelAsNoLongerNeeded(carModel)

        SetVehicleEngineOn(createdVehicle, true, true, false)
        local playerVelocity = GetEntityVelocity(playerPed)
        SetEntityVelocity(createdVehicle, playerVelocity.x, playerVelocity.y, playerVelocity.z)

        local bondPed = CreatePoolPedInsideVehicle(createdVehicle, 4, bondModel, -1)

        SetPedRelationshipGroupHash(bondPed, relationshipGroup)

        TaskSetBlockingOfNonTemporaryEvents(bondPed, true)

        SetPedHearingRange(bondPed, 9999.)
        SetPedConfigFlag(bondPed, 281, true)
        SetPedCombatAbility(bondPed, 2)
        -- BF_CanFightArmedPedsWhenNotArmed
        SetPedCombatAttributes(bondPed, 5, true)
        -- BF_AlwaysFight
        SetPedCombatAttributes(bondPed, 46, true)
        SetPedSuffersCriticalHits(bondPed, false)

        -- Give switchblade and suppressed vintage pistol
        GiveWeaponToPed(bondPed, "WEAPON_SWITCHBLADE", 9999, true, true)
        GiveWeaponToPed(bondPed, "WEAPON_VINTAGEPISTOL", 9999, true, true)
        GiveWeaponComponentToPed(bondPed, "WEAPON_VINTAGEPISTOL", "COMPONENT_AT_PI_SUPP")
        -- Make 100% accurate and set to combat player
        SetPedAccuracy(bondPed, 100)
        TaskCombatPed(bondPed, playerPed, 0, 16)

        GivePedEnemyBlip(bondPed)
    end)
end)

RegisterNetEvent('Chaos:Peds:JumpyPeds', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Do the Cha-Cha slide")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedInAnyVehicle(ped, false) then
                    TaskJump(ped, false, false, false)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:KillerClowns', function(duration)
    local MaxClowns = 10
    local exitMethod = false
    exports.helpers:DisplayMessage("Killer Clowns")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local clownEnemies = {}
        local particleAsset = "scr_rcbarry2"
        local playerPed = PlayerPedId()
        local playerGroup = "PLAYER"
        ---@type integer
        local spawnTimer = -1
        local _, relationshipGroup = AddRelationshipGroup("_HOSTILE_KILLER_CLOWNS")
        SetRelationshipBetweenGroups(5, relationshipGroup, playerGroup)
        SetRelationshipBetweenGroups(5, playerGroup, relationshipGroup)
        SetRelationshipBetweenGroups(0, relationshipGroup, relationshipGroup)

        RequestNamedPtfxAsset(particleAsset)
        while not HasNamedPtfxAssetLoaded(particleAsset) do
            Citizen.Wait(100)
        end
        while true do
            if exitMethod then
                break
            end

            local playerPos = GetEntityCoords(playerPed, false)
            local currentTime = GetGameTimer()

            for i = 1, #clownEnemies do
                local currentClown = clownEnemies[i]
                local clownPos = GetEntityCoords(currentClown, false)
                if IsPedDeadOrDying(currentClown, true) or IsPedInjured(currentClown)
                        or GetDistanceBetweenCoords(playerPos.x, playerPos.y, playerPos.z, clownPos.x, clownPos.y, clownPos.z, false) > 100. then
                    SetEntityHealth(currentClown, 0)
                    UseParticleFxAsset(particleAsset)
                    StartParticleFxNonLoopedAtCoord(
                            "scr_clown_death",
                            clownPos.x, clownPos.y, clownPos.z,
                            0., 0., 0.,
                            3., false, false, false
                    )
                    Citizen.Wait(300)
                    SetEntityAlpha(currentClown, 0, true)
                    SetPedAsNoLongerNeeded(currentClown)
                    DeletePed(currentClown)
                    table.remove(clownEnemies, i)
                    Citizen.Wait(0)
                end
            end

            if #clownEnemies < MaxClowns and currentTime > spawnTimer + 2000 then
                spawnTimer = currentTime
                local spawnPos = playerPos
                for i = 0, 10 do
                    if math.random(0, 1) == 1 then
                        spawnPos = vector3(
                                spawnPos.x + math.random(10, 25),
                                spawnPos.y, spawnPos.z
                        )
                    else
                        spawnPos = vector3(
                                spawnPos.x - math.random(10, 25),
                                spawnPos.y, spawnPos.z
                        )
                    end
                    if math.random(0, 1) == 1 then
                        spawnPos = vector3(
                                spawnPos.x,
                                spawnPos.y + math.random(10, 25),
                                spawnPos.z
                        )
                    else
                        spawnPos = vector3(
                                spawnPos.x,
                                spawnPos.y - math.random(10, 25),
                                spawnPos.z
                        )
                    end
                    local groundExists, groundZ = GetGroundZFor_3dCoord(spawnPos.x, spawnPos.y, spawnPos.z, false)
                    if groundExists then
                        spawnPos = vector3(spawnPos.x, spawnPos.y, groundZ)
                    end
                end

                UseParticleFxAsset(particleAsset)
                StartParticleFxNonLoopedAtCoord(
                        "scr_clown_appears",
                        spawnPos.x, spawnPos.y, spawnPos.z,
                        0., 0., 0.,
                        2., true, true, true
                )
                Citizen.Wait(300)

                local createdClown = CreatePoolPed(-1, "s_m_y_clown_01", spawnPos, 0.)
                SetEntityAsMissionEntity(createdClown, true, true)
                SetBlockingOfNonTemporaryEvents(createdClown, true)
                SetPedRelationshipGroupHash(createdClown, relationshipGroup)
                SetPedHearingRange(createdClown, 9999.)

                GiveWeaponToPed(createdClown, "WEAPON_MICROSMG", 9999, true, true)
                SetPedAccuracy(createdClown, 20)
                TaskCombatPed(createdClown, playerPed, 0, 16)
                GivePedEnemyBlip(createdClown)
                table.insert(clownEnemies, createdClown)
            end

            Citizen.Wait(0)
        end

        for i = 1, #clownEnemies do
            local currentClown = clownEnemies[i]
            local clownPos = GetEntityCoords(currentClown, false)
            SetEntityHealth(currentClown, 0)
            UseParticleFxAsset(particleAsset)
            StartParticleFxNonLoopedAtCoord(
                    "scr_clown_death",
                    clownPos.x, clownPos.y, clownPos.z,
                    0., 0., 0.,
                    3., false, false, false
            )
            Citizen.Wait(300)
            SetEntityAlpha(currentClown, 0, true)
            SetPedAsNoLongerNeeded(currentClown)
            DeletePed(currentClown)
        end
        RemoveNamedPtfxAsset(particleAsset)
    end)
end)

RegisterNetEvent('Chaos:Peds:LooseTrigger', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Loose trigger finger")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        local count = 3
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                SetPedInfiniteAmmoClip(ped, true)
                local weaponHash = GetSelectedPedWeapon(ped)
                if GetWeaponDamageType(weaponHash) ~= 2 and IsPedWeaponReadyToShoot(ped) then
                    local pedWeapon = GetCurrentPedWeaponEntityIndex(ped)
                    local targetOffset = GetOffsetFromEntityInWorldCoords(pedWeapon, 0., 1., 0.)

                    SetPedShootsAtCoord(ped, targetOffset.x, targetOffset.y, targetOffset.z, true)

                    count = count - 1
                    if count == 0 then
                        count = 3
                        Citizen.Wait(0)
                    end
                end
            end

            Citizen.Wait(0)
        end

        for ped in exports.helpers:EnumeratePeds() do
            SetPedInfiniteAmmoClip(ped, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:NoRagdoll', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("No Ragdolling")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                SetPedCanRagdoll(ped, false)
            end

            Citizen.Wait(0)
        end

        for ped in exports.helpers:EnumeratePeds() do
            SetPedCanRagdoll(ped, true)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:ObliterateNearby', function(duration)
    exports.helpers:DisplayMessage("OBLITERATION")

    Citizen.CreateThread(function()
        RequestNamedPtfxAsset("scr_xm_orbital")
        RequestNamedPtfxAsset("scr_xm_orbital_blast")

        local count = 5

        for ped in exports.helpers:EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                local pedPos = GetEntityCoords(ped, false)

                UseParticleFxAsset("scr_xm_orbital")
                StartNetworkedParticleFxNonLoopedAtCoord(
                        "scr_xm_orbital_blast",
                        pedPos.x, pedPos.y, pedPos.z,
                        .0, .0, .0,
                        1., false, false, false
                )
                PlaySoundFromCoord(-1, "DLC_XM_Explosions_Orbital_Cannon", pedPos.x, pedPos.y, pedPos.z,0, true, 0, false)
                AddExplosion(pedPos.x, pedPos.y, pedPos.z, 9, 100., true, false, 3.)
                SetEntityHealth(ped, 0)

                count = count - 1
                if count == 0 then
                    count = 5
                    Citizen.Wait(0)
                end
            end
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Phones', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Whose phone is ringing?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if not IsPedRingtonePlaying(ped) then
                    PlayPedRingtone("Remote_Ring", ped, true)
                end
            end

            Citizen.Wait(0)
        end

        for ped in exports.helpers:EnumeratePeds() do
            StopPedRingtone(ped)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:RagdollOnTouch', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("You've got a sensitive touch")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                SetPedRagdollOnCollision(ped, true)
            end

            Citizen.Wait(0)
        end

        for ped in exports.helpers:EnumeratePeds() do
            SetPedRagdollOnCollision(ped, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:SlipperyPeds', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Can't tie my shoes")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                if GetEntitySpeed(ped) > 5.2 then
                    SetPedToRagdoll(ped, 3000, 3000, 0, true, true, false)
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:CompanionCats', function(duration)
    local CATS_AMOUNT = 3
    exports.helpers:DisplayMessage("You've got a friend in me")

    Citizen.CreateThread(function()
        local companionModel = "a_c_cat_01"
        local playerPed = PlayerPedId()

        local _, relationshipGroup = AddRelationshipGroup("_FAN_CATS")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")
        SetRelationshipBetweenGroups(0, "PLAYER", relationshipGroup)

        local playerPos = GetEntityCoords(playerPed, false)

        for i = 1, CATS_AMOUNT do
            local companionPed = CreatePoolPed(28, companionModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed))

            SetPedRelationshipGroupHash(companionPed, relationshipGroup)
            SetPedAsGroupMember(companionPed, GetPlayerGroup(PlayerId()))
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:CompanionChimp', function(duration)
    exports.helpers:DisplayMessage("You've got a friend in me")

    Citizen.CreateThread(function()
        local companionModel = "a_c_chimp"
        local playerPed = PlayerPedId()

        local _, relationshipGroup = AddRelationshipGroup("_COMPANION_CHIMP")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")
        SetRelationshipBetweenGroups(0, "PLAYER", relationshipGroup)

        local playerPos = GetEntityCoords(playerPed, false)

        local companionPed = CreatePoolPed(28, companionModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed))

        if IsPedInAnyVehicle(playerPed, false) then
            SetPedIntoVehicle(companionPed, GetVehiclePedIsIn(playerPed, false), -2)
        end

        SetPedSuffersCriticalHits(companionPed, false)
        SetPedHearingRange(companionPed, 9999.)

        SetPedRelationshipGroupHash(companionPed, relationshipGroup)
        SetPedAsGroupMember(companionPed, GetPlayerGroup(PlayerId()))

        SetPedCombatAttributes(companionPed, 5, true)
        SetPedCombatAttributes(companionPed, 46, true)

        SetPedAccuracy(companionPed, 100)
        SetPedFiringPattern(companionPed, "FIRING_PATTERN_FULL_AUTO")

        GiveWeaponToPed(companionPed, "WEAPON_PISTOL", 9999, false, true)
        GiveWeaponToPed(companionPed, "WEAPON_CARBINERIFLE", 9999, false, true)
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:CompanionChop', function(duration)
    exports.helpers:DisplayMessage("You've got a friend in me")

    Citizen.CreateThread(function()
        local companionModel = "a_c_chop"
        local playerPed = PlayerPedId()

        local _, relationshipGroup = AddRelationshipGroup("_COMPANION_CHOP")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")
        SetRelationshipBetweenGroups(0, "PLAYER", relationshipGroup)

        local playerPos = GetEntityCoords(playerPed, false)

        local companionPed = CreatePoolPed(28, companionModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed))


        SetPedRelationshipGroupHash(companionPed, relationshipGroup)
        SetPedAsGroupMember(companionPed, GetPlayerGroup(PlayerId()))

        SetPedHearingRange(companionPed, 9999.)
        SetPedCombatAttributes(companionPed, 0, false)
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:DancingApes', function(duration)
    local APE_AMOUNT = 3
    exports.helpers:DisplayMessage("Dancing Apes")

    Citizen.CreateThread(function()
        local animationDict = "missfbi3_sniping"
        local playerPed = PlayerPedId()

        local _, relationshipGroup = AddRelationshipGroup("_DANCING_APES")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")
        SetRelationshipBetweenGroups(0, "PLAYER", relationshipGroup)

        local playerPos = GetEntityCoords(playerPed, false)

        RequestAnimDict(animationDict)

        for i = 1, APE_AMOUNT do
            local apePed = CreatePoolPed(
                    28,
                    math.random(0, 1) == 1 and "a_c_chimp" or "a_c_rhesus",
                    playerPos.x, playerPos.y, playerPos.z,
                    GetEntityHeading(playerPed)
            )
            SetPedRelationshipGroupHash(apePed, relationshipGroup)

            if IsPedInAnyVehicle(playerPed, false) then
                SetPedIntoVehicle(apePed, GetVehiclePedIsIn(playerPed, false), -2)
            end

            SetPedCanRagdoll(apePed, false)
            SetPedSuffersCriticalHits(apePed, false)

            TaskPlayAnim(apePed, animationDict, "dance_m_default", 4., -4., -1, 1, 0., false, false, false)
            Citizen.Wait(0)

            SetPedConfigFlag(apePed, 292, true)
        end

        RemoveAnimDict(animationDict)
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:Juggernaut', function(duration)
    exports.helpers:DisplayMessage("I am the juggernaut, *****")

    Citizen.CreateThread(function()
        local enemyModel = "u_m_y_juggernaut_01"
        local weaponHash = "weapon_minigun"

        local hostilePed = CreateHostilePed(enemyModel, weaponHash)
        SetPedArmour(hostilePed, 250)
        SetPedAccuracy(hostilePed, 3)
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:RoastingLamar', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Yee yee ass haircut")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        local lamarModel = "ig_lamardavis"
        local playerPed = PlayerPedId()

        local _, relationshipGroup = AddRelationshipGroup("_ROASTING_LAMAR")
        SetRelationshipBetweenGroups(0, relationshipGroup, "PLAYER")
        SetRelationshipBetweenGroups(0, "PLAYER", relationshipGroup)

        local playerPos = GetEntityCoords(playerPed, false)

        RequestModel(lamarModel)
        while not HasModelLoaded(lamarModel) do
            Citizen.Wait(100)
        end

        local lamarPed = CreatePed(4, lamarModel, playerPos.x, playerPos.y, playerPos.z, GetEntityHeading(playerPed), true, false)
        SetModelAsNoLongerNeeded(lamarModel)

        if IsPedInAnyVehicle(playerPed, false) then
            SetPedIntoVehicle(lamarPed, GetVehiclePedIsIn(playerPed, false), -2)
        end

        SetPedRelationshipGroupHash(lamarPed, relationshipGroup)
        SetPedAsGroupMember(lamarPed, GetPlayerGroup(PlayerId()))
        SetEntityInvincible(lamarPed, true)

        PlayPedAmbientSpeechNative(lamarPed, "GENERIC_HI", "SPEECH_PARAMS_FORCE_SHOUTED", 1)
        Citizen.Wait(4000)
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 500 then
                lastTick = currentTick
                if DoesEntityExist(lamarPed) then
                    PlayPedAmbientSpeechNative(lamarPed, "GENERIC_INSULT_MED", "SPEECH_PARAMS_FORCE_SHOUTED")
                end
            end

            Citizen.Wait(0)
            end

        if DoesEntityExist(lamarPed) then
            if not IsPedDeadOrDying(lamarPed, true) then
                RequestAnimDict("mp_player_int_upperfinger")

                TaskTurnPedToFaceEntity(lamarPed, playerPed, 1000)
                TaskLookAtEntity(lamarPed, playerPed, 1000, 2048, 3)
                Citizen.Wait(1000)
                TaskPlayAnim(lamarPed, "mp_player_int_upperfinger", "mp_player_int_finger_02", 8., -1., 1000, 1, 0., false, false, false)
                Citizen.Wait(2000)

                if IsPedInAnyVehicle(lamarPed, false) then
                    local lamarVehicle = GetVehiclePedIsIn(lamarPed, false)
                    TaskLeaveVehicle(lamarPed, lamarVehicle, 4160)
                end
            end

            SetPedAsNoLongerNeeded(lamarPed)
            SetEntityInvincible(lamarPed, false)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Spawn:SpaceRanger', function(duration)
    exports.helpers:DisplayMessage("He comes from space!")

    Citizen.CreateThread(function()
        local enemyModel = "u_m_y_rsranger_01"
        local weaponHash = "weapon_raycarbine"

        local hostilePed = CreateHostilePed(enemyModel, weaponHash)
    end)
end)

RegisterNetEvent('Chaos:Peds:Speech:Friendly', function(duration)
    local speechesFriendly = { "GENERIC_HI", "GENERIC_HOWS_IT_GOING", "GENERIC_THANKS" }

    local exitMethod = false
    exports.helpers:DisplayMessage("Why's everyone so friendly?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 1000 then
                lastTick = currentTick
                for ped in exports.helpers:EnumeratePeds() do
                    if not IsPedAPlayer(ped) and IsPedHuman(ped) then
                        local randomSpeech = math.random(1, #speechesFriendly)
                        PlayPedAmbientSpeechNative(ped, speechesFriendly[randomSpeech], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Speech:Kifflom', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Kifflom!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 1000 then
                lastTick = currentTick
                for ped in exports.helpers:EnumeratePeds() do
                    if not IsPedAPlayer(ped) and IsPedHuman(ped) then
                        PlayPedAmbientSpeechNative(ped, "KIFFLOM_GREET", "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:Speech:Unfriendly', function(duration)
    local speechesUnfriendly = { "GENERIC_CURSE_HIGH", "GENERIC_INSULT_HIGH", "GENERIC_WAR_CRY" }

    local exitMethod = false
    exports.helpers:DisplayMessage("Why's everyone so unfriendly?")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        ---@type integer
        local lastTick = 0
        while true do
            if exitMethod then
                break
            end

            local currentTick = GetGameTimer()
            if lastTick < currentTick - 1000 then
                lastTick = currentTick
                for ped in exports.helpers:EnumeratePeds() do
                    if not IsPedAPlayer(ped) and IsPedHuman(ped) then
                        local randomSpeech = math.random(1, #speechesUnfriendly)
                        PlayPedAmbientSpeechNative(ped, speechesUnfriendly[randomSpeech], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
                end
            end

            Citizen.Wait(0)
        end
    end)
end)

RegisterNetEvent('Chaos:Peds:StopAndStare', function(duration)
    exports.helpers:DisplayMessage("Didn't your mother teach you not to stare?")

    Citizen.CreateThread(function()
        local playerPed = PlayerPedId()
        for ped in exports.helpers:EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                if IsPedInAnyVehicle(ped, true) then
                    local pedVehicle = GetVehiclePedIsIn(ped, true)
                    TaskLeaveVehicle(ped, pedVehicle, 256)
                    BringVehicleToHalt(pedVehicle, 0.1, 10, false)
                end

                if ped ~= playerPed then
                    TaskTurnPedToFaceEntity(ped, playerPed, -1)
                    TaskLookAtEntity(ped, playerPed, -1, 2048, 3)
                end
            end
        end
    end)
end)