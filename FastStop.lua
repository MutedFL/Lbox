local keyHeld = {}
local releaseTick = {}

local function handleMovement(cmd)
    local currentTick = globals.TickCount()
    
    -- Check if the space key is not held
    if not input.IsButtonDown(KEY_SPACE) then
        local sideSpeed = 0
        local forwardSpeed = 0
        
        -- Define movement speed
        local moveSpeed = 650
        
        -- Handle 'A' key
        if input.IsButtonDown(KEY_A) then
            keyHeld[KEY_A] = true
            sideSpeed = -moveSpeed
            releaseTick[KEY_A] = 0
        elseif keyHeld[KEY_A] then
            if releaseTick[KEY_A] == 0 then
                releaseTick[KEY_A] = currentTick
            end
            
            -- Check if exactly 2 ticks have passed since 'A' key was released
            if currentTick - releaseTick[KEY_A] <= 3 then
                sideSpeed = moveSpeed
            else
                keyHeld[KEY_A] = false
            end
        end
        
        -- Handle 'D' key
        if input.IsButtonDown(KEY_D) then
            keyHeld[KEY_D] = true
            sideSpeed = moveSpeed
            releaseTick[KEY_D] = 0
        elseif keyHeld[KEY_D] then
            if releaseTick[KEY_D] == 0 then
                releaseTick[KEY_D] = currentTick
            end
            
            -- Check if exactly 2 ticks have passed since 'D' key was released
            if currentTick - releaseTick[KEY_D] <= 3 then
                sideSpeed = -moveSpeed
            else
                keyHeld[KEY_D] = false
            end
        end

        -- Handle 'W' key
        if input.IsButtonDown(KEY_W) then
            keyHeld[KEY_W] = true
            forwardSpeed = moveSpeed
            releaseTick[KEY_W] = 0
        elseif keyHeld[KEY_W] then
            if releaseTick[KEY_W] == 0 then
                releaseTick[KEY_W] = currentTick
            end
            
            -- Check if exactly 2 ticks have passed since 'W' key was released
            if currentTick - releaseTick[KEY_W] <= 3 then
                forwardSpeed = -moveSpeed
            else
                keyHeld[KEY_W] = false
            end
        end
        
        -- Handle 'S' key
        if input.IsButtonDown(KEY_S) then
            keyHeld[KEY_S] = true
            forwardSpeed = -moveSpeed
            releaseTick[KEY_S] = 0
        elseif keyHeld[KEY_S] then
            if releaseTick[KEY_S] == 0 then
                releaseTick[KEY_S] = currentTick
            end
            
            -- Check if exactly 2 ticks have passed since 'S' key was released
            if currentTick - releaseTick[KEY_S] <= 3 then
                forwardSpeed = moveSpeed
            else
                keyHeld[KEY_S] = false
            end
        end
        
        -- Set the movement speeds
        cmd.forwardmove = forwardSpeed
        cmd.sidemove = sideSpeed
    end
end

callbacks.Register("CreateMove", "handleMovement", handleMovement)
