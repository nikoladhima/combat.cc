local CachedPlayers = (...)
if CachedPlayers and type(CachedPlayers) == "table" then
	local function CachePlayerPositions()
		for _,Cache in next, CachedPlayers do
			if not Cache then
				continue
			end

			local Head = Cache.Head
			Cache.LastHeadPosition = Head and Head.CFrame.Position or Vector3zero

			local Root = Cache.Root
			local RootCFrame = Root and Root.CFrame or CFrameZero
			Cache.LastRootCFrame = RootCFrame
			Cache.LastRootPosition = RootCFrame.Position
		end
	end
	return CachePlayerPositions
end
