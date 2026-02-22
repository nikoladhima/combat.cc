local ThreadManager = {}
ThreadManager.__index = ThreadManager

function ThreadManager.new()
    return setmetatable({
        Threads = {},
        Running = false
    }, ThreadManager)
end

function ThreadManager:Start(Name, Function, Interval)
    if self.Threads[Name] then
		return
	end

    self.Running = true

    local Thread = task.spawn(function()
        while self.Running and self.Threads[Name] do
            Function()
            task.wait(Interval)
        end
    end)

    self.Threads[Name] = Thread
end

function ThreadManager:Stop(Name)
    self.Threads[Name] = nil
end

function ThreadManager:StopAll()
    self.Running = false
    table.clear(self.Threads)
end
