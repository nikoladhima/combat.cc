local FPS = {Value = 0, Connection = nil}
local Script = (...)

local RunService = Script[1]
local Stats = Script[2]

if RunService and Stats then
    local Success,_ = pcall(function()
		local Heartbeat = Stats:WaitForChild("Workspace"):WaitForChild("Heartbeat")
        FPS.Connection = RunService.RenderStepped:Connect(function()
			FPS.Value = Heartbeat:GetValue()
        end)
    end)

    if not Success then
        print("[nikoletoscripts/combat.cc]: Failed to load FPS Library - RenderStepped Error")
    end
else
    print("[nikoletoscripts/combat.cc]: Failed to load FPS Library - RunService or Stats Error")
end

function FPS:Disconnect()
    FPS.Connection:Disconnect()
    FPS.Connection = nil
end

return FPS, Stats
