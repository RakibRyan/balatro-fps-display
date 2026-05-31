-- Initialize optional features as requested by the framework
SMODS.current_mod.optional_features = {
    retrigger_joker = true
}

local fps_enabled = true
local default_present = love.graphics.present

-- Hook directly into the frame presentation to bypass Balatro's canvas/shader pipeline
love.graphics.present = function(...)
    if fps_enabled then
        -- Push state to isolate our rendering from the engine's memory
        love.graphics.push("all")
        
        local fps = love.timer.getFPS()
        local current_fps_text = "FPS: " .. fps

        -- Layer 1: Shadow (Black, 70% opacity)
        love.graphics.setColor(0, 0, 0, 0.7)
        love.graphics.print(current_fps_text, 11, 11)

        -- Layer 2: Main text (White, Fully opaque)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(current_fps_text, 10, 10)

        -- Pop state to restore the exact environment we interrupted
        love.graphics.pop()
    end

    -- Execute the engine's native presentation function
    return default_present(...)
end

