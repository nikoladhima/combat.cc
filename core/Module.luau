local Module = {}

local function nsloadstring(UseUtilsRepository: boolean, Url: string, Argument: any): any
	local Success, Result = pcall(function()
		return loadstring(game:HttpGet(
            UseUtilsRepository and "https://raw.githubusercontent.com/nikoladhima/combat.cc/main/utils/" .. Url or Url
        ))(Argument)
	end)

	return Success and Result or {nsFailed = true, Value = "Unknown", tostring(Result)}
end

local function FailedCheck(PossibleTable: table?, PossibleTableName: string): boolean
	if type(PossibleTable) == "table" and PossibleTable.nsFailed then
		warn("Failed to load " .. PossibleTableName .. ". " .. PossibleTable[3])
		return true
	end
	return false
end

function Module:Get(Item: string): table?
    if Item == "Library" then
        local Library = nsloadstring(false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/Library.lua")

        if FailedCheck(Library, "Library") then
            return nil
        end

        return Library
    elseif Item == "ThreadManager" then
        local ThreadManager = nsloadstring(true, "ThreadManager.luau")

        if FailedCheck(ThreadManager, "ThreadManager") then
            return nil
        end

        return ThreadManager.new()
    elseif Item == "DrawingUtils" then
        local DrawingUtils = nsloadstring(true, "DrawingUtils.luau", Drawing.new or Drawing.draw)

        if FailedCheck(DrawingUtils, "DrawingUtils") then
            return nil
        elseif type(DrawingUtils) == "string" then
            warn(DrawingUtils)
            return nil
        end

        return DrawingUtils
    end
end

return Module
