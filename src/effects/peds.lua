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

RegisterNetEvent('Chaos:Peds:Aimbot', function(duration)
    local exitMethod = false
    exports.helpers:DisplayMessage("Don't aggro the AI")

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
            if not IsPedAPlayer(ped) and not IsPedDeadOrDying(ped, false) then
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
    exports.helpers:DisplayMessage("Police here, police there, police everywhere!")

    Citizen.SetTimeout(duration * 1000, function() exitMethod = true end)
    Citizen.CreateThread(function()
        while true do
            if exitMethod then
                break
            end

            for ped in exports.helpers:EnumeratePeds() do
                local pedType = GetPedType(ped)
                if not IsPedAPlayer(ped) and pedType > 2 then
                    SetPedAsCop(ped, true)
                end
            end

            Citizen.Wait(0)
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
    local DRIVING_STYLE = 1024; -- "Drive in reverse gear" bit

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
                    SetBlockingOfNonTemporaryEvents(ped, true)

                    GiveWeaponToPed(ped, weaponHash, 9999, true, true)
                    TaskDriveBy(ped, playerPed, 0, 0., 0., 0., -1., 5, false, "FIRING_PATTERN_FULL_AUTO")
                end
            end

            Citizen.Wait(0)
        end
    end)
end)