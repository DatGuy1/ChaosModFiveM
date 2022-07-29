local entityEnumerator = {
  __gc = function(enum)
    if enum.destructor and enum.handle then
      enum.destructor(enum.handle)
    end
    enum.destructor = nil
    enum.handle = nil
  end
}

local MaxObjects = 400
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
  return coroutine.wrap(function()
    local i = 0
    local iter, id = initFunc()
    if not id or id == 0 then
      disposeFunc(iter)
      return
    end
    
    local enum = {handle = iter, destructor = disposeFunc}
    setmetatable(enum, entityEnumerator)
    
    local next = true
    repeat
      coroutine.yield(id)
      next, id = moveFunc(iter)
      i = i + 1
    until not next or i >= MaxObjects
    
    enum.destructor, enum.handle = nil, nil
    disposeFunc(iter)
  end)
end

exports('EnumerateObjects', function()
  return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end)

exports('EnumeratePeds', function()
  return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end)

exports('EnumerateVehicles', function()
  return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end)

exports('EnumeratePickups', function()
  return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end)
