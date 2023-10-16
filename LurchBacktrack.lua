-- Shit code, lovingly created by chatgpt and Muted -- 
local targetLatency = 250  -- The target value you want to reach
local initialLatency = 1  -- The initial value when you press 'z'
local incrementAmount = 220  -- The amount to increment per second

local currentLatency = initialLatency
local isIncrementing = false
local lastIncrementTime = 0

local function setLatencyValue()
    local currentTime = globals.CurTime()

    if input.IsButtonPressed(KEY_Z) then
        isIncrementing = true
        gui.SetValue("Fake Latency Value (ms)", math.floor(currentLatency + 0.5))  -- Round to nearest integer
        lastIncrementTime = currentTime
    end

    if isIncrementing then
        local timeElapsed = currentTime - lastIncrementTime
        currentLatency = currentLatency + incrementAmount * timeElapsed

        -- Check if we've reached the maximum value, and if so, reset to the initial value
        if currentLatency > targetLatency then
            currentLatency = initialLatency
        end

        gui.SetValue("Fake Latency Value (ms)", math.floor(currentLatency + 0.5))  -- Round to nearest integer
        lastIncrementTime = currentTime
    else
        isIncrementing = false
    end
end

callbacks.Register("CreateMove", "SetLatencyValue", setLatencyValue)
