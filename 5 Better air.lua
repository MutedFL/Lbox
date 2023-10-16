-- Shit code, lovingly created by chatgpt and Muted -- 

local autoStrafeValue = 0 -- Initial value for "Auto Strafe"
local duckJumpValue = 1 -- Default value for "Duck Jump"

local function onMove(cmd)
    local spaceHeld = input.IsButtonDown(KEY_SPACE)
    local wHeld = input.IsButtonDown(KEY_W)
    local aHeld = input.IsButtonDown(KEY_A)
    local sHeld = input.IsButtonDown(KEY_S)
    local dHeld = input.IsButtonDown(KEY_D)
    local controlHeld = input.IsButtonDown(KEY_LCONTROL) or input.IsButtonDown(KEY_RCONTROL) -- Check if Control key is held down

    if controlHeld then
        gui.SetValue("Duck Jump", 0) -- Set "Duck Jump" to 0 when Control key is held down
    else
        if gui.GetValue("Duck Jump") ~= duckJumpValue then
            gui.SetValue("Duck Jump", duckJumpValue) -- Set "Duck Jump" to the default value (1) when Control key is not held down
        end
    end

    if spaceHeld and (wHeld or aHeld or sHeld or dHeld) then
        -- Set "Auto Strafe" to 2 when "Space" key and any of the WASD keys are held
        if autoStrafeValue ~= 2 then
            gui.SetValue("Auto Strafe", 2)
            autoStrafeValue = 2
        end
    else
        -- Set "Auto Strafe" to 0 when no movement keys or "Space" key are held
        if autoStrafeValue ~= 0 then
            gui.SetValue("Auto Strafe", 0)
            autoStrafeValue = 0
        end
    end
end

callbacks.Register("CreateMove", "CheckMovementKeysAndSpaceHold", onMove)
