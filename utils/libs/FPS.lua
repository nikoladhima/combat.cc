local FPS = {Value = 0, Connection = nil}
local RunService = (...)

if RunService and typeof(RunService) == "Instance" then
    local FrameTimer = tick()
    local FrameCounter = 0

    local Success,_ = pcall(function(...)
        FPS.Connection = RunService.RenderStepped:Connect(function()
            FrameCounter += 1
            if (tick() - FrameTimer) >= 1 then
                FPS.Value = FrameCounter
                FrameTimer = tick()
                FrameCounter = 0
            end
        end)
    end)

    if not Success then
        print("[nikoletoscripts/combat.cc]: Failed to load FPS Library - RenderStepped Error")
    end
else
    print("[nikoletoscripts/combat.cc]: Failed to load FPS Library - RunService Error")
end

function FPS:Disconnect()
    FPS.Connection:Disconnect()
    FPS.Connection = nil
end

return FPS
