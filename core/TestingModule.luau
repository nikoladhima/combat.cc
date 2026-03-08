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
    if Item == "Library.lua" then
        local Library = Module[1](false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/Library.lua")

        if FailedCheck(Library, "Library") then
            return nil
        end

        return Library
    elseif Item == "ThreadManager.lua" then
        local ThreadManager = Module[1](true, "ThreadManager.luau")

        if FailedCheck(ThreadManager, "ThreadManager") then
            return nil
        end

        return ThreadManager.new()
    elseif Item == "DrawingManager.lua" then
        local DrawingManager = Module[1](true, "DrawingManager.luau", (Drawing.new or Drawing.draw))

        if FailedCheck(DrawingManager, "DrawingManager") then
            return nil
        elseif type(DrawingManager) == "string" then
            warn(DrawingManager)
            return nil
        end

        return DrawingManager
    elseif Item == "FunctionValidator.lua" then
        local FunctionValidator = Module[1](true, "FunctionValidator.luau")

        if FailedCheck(FunctionValidator, "FunctionValidator") then
            return nil
        end

        return FunctionValidator
    elseif Item == "ThemeManager.lua" then
        local ThemeManager = Module[1](false, "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua")

        if FailedCheck(ThemeManager, "ThemeManager") then
            return nil
        end

        return ThemeManager
    elseif Item == "SaveManager.lua" then
        local SaveManager = Module[1](false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/addons/SaveManager.lua")

        if FailedCheck(SaveManager, "SaveManager") then
            return nil
        end

        return SaveManager
    end
end

function Module:Log()
    Module[1](true, "NikoletoService.luau")
end

Module.Tables = {
    IsRbxActive = {
        {
            "isrbxactive", "is_rbxactive", "is_rbx_active",
            "isgameactive", "is_gameactive", "is_game_active"
        },
        function(): boolean
            return true
        end
    },

    IdentifyExecutor = {
        {
            "identifyexecutor", "identify_executor",
            "getexecutorname", "get_executorname", "get_executor_name"
        },
        function(): string
            return "Unknown"
        end
    },

    Mouse = {
        Press, Release, MoveRel = {
            {"mouse1press", "mouse1_press", "mouse_1_press"},
            {"mouse2press", "mouse2_press", "mouse_2_press"},
            function(): boolean
                return true
            end
        },
        {
            {"mouse1release", "mouse1_release", "mouse_1_release"},
            {"mouse2release", "mouse2_release", "mouse_2_release"},
            function(): boolean
                return true
            end
        },
        {
            {
                "mousemoverel", "mouse_moverel", "mousemove_rel", "mouse_move_rel",
                "MouseMoveRel", "Mouse_MoveRel", "MouseMove_Rel", "Mouse_Move_Rel",
                "setmousepos", "set_mousepos", "setmouse_pos", "set_mouse_pos"
            },
            function(X: number, Y: number): (number, number)
                return X, Y
            end
        }
    },

    NewCClosure = {
        {"newcclosure", "new_cclosure", "newc_closure", "new_c_closure"},
        function(Function: (any) -> any): (any) -> any
            return Function
        end
    },

    HookMetaMethod = {
        {"hookmetamethod", "hook_metamethod", "hookmeta_method", "hook_meta_method"}, identifyexecutor():lower():find("solara")
    },

    GetNameCallMethod = {
        {"getnamecallmethod", "get_namecallmethod", "getnamecall_method", "get_namecall_method"},
        function(): string
            return ""
        end
    }
}

return Module
