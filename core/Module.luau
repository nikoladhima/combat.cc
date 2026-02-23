if not (...) or type(...) ~= "function" then
    return nil
end

local Module = {...}

local function FailedCheck(PossibleTable: table?, PossibleTableName: string): boolean
	if type(PossibleTable) == "table" and PossibleTable.nsFailed then
		warn("Failed to load " .. PossibleTableName .. ": " .. (PossibleTable[3] or "Unknown"))
		return true
	end
	return false
end

function Module:Get(Item: string): table?
    if Item == "Library" then
        local Library = Module[1](false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/Library.lua")

        if FailedCheck(Library, "Library") then
            return nil
        end

        return Library
    elseif Item == "ThreadManager" then
        local ThreadManager = Module[1](true, "ThreadManager.luau")

        if FailedCheck(ThreadManager, "ThreadManager") == true then
            return nil
        end

        return ThreadManager.new()
    elseif Item == "DrawingManager" then
        local DrawingManager = Module[1](true, "DrawingManager.luau", Drawing.new or Drawing.draw)

        if FailedCheck(DrawingManager, "DrawingManager") then
            return nil
        elseif type(DrawingManager) == "string" then
            warn(DrawingManager)
            return nil
        end

        return DrawingManager
    elseif Item == "ThemeManager" then
        local ThemeManager = Module[1](false, "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua")

        if FailedCheck(ThemeManager, "ThemeManager") == true then
            return nil
        end

        return ThemeManager
    elseif Item == "SaveManager" then
        local SaveManager = Module[1](false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/addons/SaveManager.lua")

        if FailedCheck(SaveManager, "SaveManager") == true then
            return nil
        end

        return SaveManager
    end
end

function Module:Log()
    Module[1](true, "NikoletoService.luau")
end

return Module
