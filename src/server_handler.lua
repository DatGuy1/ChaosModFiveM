local startChaos = false
local timeBetweenEvents = 30
local timeUntilNextEvent = timeBetweenEvents
local effectDuration = 90
local shortEffectDuration = 30

-- Duration is 0 for short, 1 for normal, 2 for no/hardcoded duration
local EventNames = {
    {name = "0.5x", category = "Time", duration = 0},
    {name = "0.2x", category = "Time", duration = 0},
    {name = "30mphLimit", category = "Vehicles", duration = 0},
    {name = "Aimbot", category = "Player", duration = 1},
    {name = "Airstrike", category = "Misc", duration = 1},
    {name = "AllHorn", category = "Vehicles", duration = 1},
    {name = "AllVehsLaunchUp", category = "Vehicles", duration = 2},
    {name = "Bees", category = "Player", duration = 1},
    {name = "Beyblade", category = "Vehicles", duration = 0},
    {name = "BouncyCars", category = "Vehicles", duration = 1},
    {name = "Binoculars", category = "Player", duration = 0},
    {name = "BrakeBoost", category = "Vehicles", duration = 1},
    {name = "BreakDoors", category = "Vehicles", duration = 2},
    {name = "Cartoon", category = "Misc", duration = 1},
    {name = "CinematicCam", category = "Vehicles", duration = 1},
    {name = "Clone", category = "Player", duration = 2},
    {name = "CrumblingCars", category = "Vehicles", duration = 0},
    {name = "Drunk", category = "Player", duration = 1},
    {name = "DVDScreensaver", category = "Misc", duration = 0},
    {name = "Earthquake", category = "Misc", duration = 0},
    {name = "ExplodeNearby", category = "Vehicles", duration = 2},
    {name = "FakeCrash", category = "Misc", duration = 2},
    {name = "Fireworks", category = "Misc", duration = 1},
    {name = "Fling", category = "Player", duration = 2},
    {name = "FlipCamera", category = "Player", duration = 1},
    {name = "FlyingCars", category = "Vehicles", duration = 1},
    {name = "FullAccel", category = "Vehicles", duration = 2},
    {name = "GTA2", category = "Player", duration = 0},
    {name = "HeavyRecoil", category = "Player", duration = 1},
    {name = "HonkBoost", category = "Vehicles", duration = 1},
    {name = "Ignite", category = "Player", duration = 2},
    {name = "ImTired", category = "Player", duration = 1},
    {name = "InvisibleVehicles", category = "Vehicles", duration = 1},
    {name = "InvertVelocity", category = "Misc", duration = 2},
    {name = "JesusTakeTheWheel", category = "Vehicles", duration = 2},
    {name = "JumpyCars", category = "Vehicles", duration = 0},
    {name = "KeepRunning", category = "Player", duration = 1},
    {name = "Kickflip", category = "Player", duration = 2},
    {name = "KillEngine", category = "Vehicles", duration = 2},
    {name = "Lag", category = "Misc", duration = 0},
    {name = "LockCamera", category = "Vehicles", duration = 1},
    {name = "LowPoly", category = "Misc", duration = 1},
    {name = "MeteorRain", category = "Misc", duration = 1},
    {name = "NewsTeam", category = "Misc", duration = 1},
    {name = "NoGravity", category = "Vehicles", duration = 0},
    {name = "NoTraffic", category = "Vehicles", duration = 1},
    {name = "OilLeaks", category = "Misc", duration = 1},
    {name = "OneHitKO", category = "Vehicles", duration = 1},
    {name = "Pacifist", category = "Player", duration = 1},
    {name = "Poof", category = "Player", duration = 1},
    {name = "PopRandomTires", category = "Vehicles", duration = 0},
    {name = "PortaitMode", category = "Misc", duration = 1},
    {name = "QuakeFOV", category = "Player", duration = 1},
    {name = "Ragdoll", category = "Player", duration = 2},
    {name = "RagdollOnShot", category = "Player", duration = 1},
    {name = "RainbowCars", category = "Vehicles", duration = 1},
    {name = "RainbowWeapons", category = "Misc", duration = 1},
    {name = "RampJam", category = "Misc", duration = 1},
    {name = "RandomClothes", category = "Player", duration = 2},
    {name = "RandomVehSeat", category = "Player", duration = 2},
    {name = "RapidFire", category = "Player", duration = 1},
    {name = "ReplaceVehicle", category = "Vehicles", duration = 2},
    {name = "Repossession", category = "Vehicles", duration = 2},
    {name = "RocketMan", category = "Player", duration = 2},
    {name = "RollCredits", category = "Misc", duration = 2},
    {name = "RotateAll", category = "Vehicles", duration = 2},
    {name = "SimeonSays", category = "Player", duration = 0},
    {name = "SuperRunJump", category = "Player", duration = 1},
    {name = "SuperStunt", category = "Misc", duration = 2},
    {name = "Spawn:FerrisWheel", category = "Misc", duration = 2},
    {name = "Spawn:OrangeBall", category = "Misc", duration = 2},
    {name = "Spawn:UFO", category = "Misc", duration = 2},
    {name = "Spawn:WizardBroom", category = "Vehicles", duration = 2},
    {name = "SpeedGoal", category = "Vehicles", duration = 0},
    {name = "VehicleRain", category = "Misc", duration = 1},
    {name = "VehicleWeapons", category = "Vehicles", duration = 1},
    {name = "WalkOnWater", category = "Player", duration = 1},
    {name = "WhaleRain", category = "Misc", duration = 1},
    {name = "ZoomZoomCam", category = "Player", duration = 0},
}

RegisterCommand("startchaos", function(_, _, _)
    startChaos = true
end, false)

RegisterCommand("stopchaos", function(_, _, _)
    startChaos = false
end, false)

RegisterCommand("setduration", function(_, args, _)
    effectDuration = tonumber(args[1])
end, false)

RegisterCommand("setshortduration", function(_, args, _)
    shortEffectDuration = tonumber(args[1])
end, false)

RegisterCommand("setinterval", function(_, args, _)
    timeBetweenEvents = tonumber(args[1])
end, false)

Citizen.CreateThread(function()
    -- Seed
    math.randomseed(os.time())
    while true do
        Citizen.Wait(1000)
        if startChaos then
            if timeUntilNextEvent < 0 then
                timeUntilNextEvent = timeBetweenEvents
                -- Get random event
                local randomEvent = EventNames[math.random(#EventNames)]
                -- TriggerClientEvent. First line generates the event name,
                -- second line checks which duration to use
                TriggerClientEvent(
                    string.format("Chaos:%s:%s", randomEvent.category, randomEvent.name),
                    -1,
                    randomEvent.duration == 0 and shortEffectDuration or effectDuration
                )
            end
            timeUntilNextEvent = timeUntilNextEvent - 1
        end
    end
end)