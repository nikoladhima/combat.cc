if not (...) or type(...) ~= "function" then
    return nil
end

local Module = {...}

local function FailedCheck(Result: any, Name: string): boolean
    if type(Result) == "table" and Result.nsFailed then
        warn(("Failed to load %s: %s"):format(Name, Result[3] or "Unknown"))
        return true
    end

    if type(Result) == "string" then
        warn(("Failed to load %s: %s"):format(Name, Result))
        return true
    end

    return false
end

local loadstringFunction = Module[1]
local function Load(Name: string, ...: any): table?
    local Item = loadstringFunction(...)

    if FailedCheck(Item, Name) then
        return nil
    end

    return Item
end

local function Return(...): any
    return ...
end

local Items = {
    ["Library"] = Return(
        Load("Library.luau", true, "core/Library.luau")
    ),

    ["ThreadManager"] = Return(
        Load("ThreadManager.luau", true, "utils/ThreadManagerTesting.luau")
    ),

    ["DrawingManager"] = Return(
        Load("DrawingManager.luau", true, "utils/DrawingManager.luau", Drawing.new or Drawing.draw)
    ),

    ["FunctionValidator"] = Return(
        Load("FunctionValidator.luau", true, "utils/FunctionValidator.luau")
    ),

    ["ThemeManager"] = Return(
        Load("ThemeManager.luau", false, "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua")
    ),

    ["SaveManager"] = Return(
        Load("SaveManager.luau", false, "https://raw.githubusercontent.com/nikoladhima/Obsidian/main/addons/SaveManager.lua")
    )
}

function Module:Get(Item: string): table?
    return Items[Item]
end

function Module:Log(Table: {any}): table?
    return Load("NikoletoService.luau", true, "utils/NikoletoService.luau", Table)
end

Module.Tables = {
    Blank = function(): string
        return "this executor ass bro :skull:"
    end,

    False = function(): boolean
        return false
    end,

    True = function(): boolean
        return true
    end,

    String = function(): string
        return "Unknown"
    end,

    Workspace = {
        ListFiles = {
            {"listfiles", "list_files"},
            function(String: string): {string}
                return {}
            end
        },
        MakeFolder = {"makefolder", "make_folder", "createfolder", "create_folder"},
        IsFolder = {"isfolder", "is_folder"},
        IsFile = {"isfile", "is_file"},
        ReadFile = {
            {"readfile", "read_file", "readfileasync", "readfile_async", "read_file_async"},
            function(... : any): string
                return "{}"
            end
        },
        WriteFile = {"writefile", "write_file", "writefileasync", "writefile_async", "write_file_async"},
        DelFile = {"delfile", "del_file", "deletefile", "delete_file"},
    },


    IsRbxActive = {
        "isrbxactive", "is_rbxactive", "isrbx_active", "is_rbx_active",
        "iswindowactive", "is_windowactive", "iswindow_active", "is_window_active",
        "isgameactive", "is_gameactive", "isgame_active", "is_game_active"
    },

    IdentifyExecutor = {
        "identifyexecutor", "identify_executor",
        "getexecutorname", "get_executorname", "getexecutor_name", "get_executor_name"
    },

    Mouse = {
        Press = {"mouse1press", "mouse_1press", "mouse1_press", "mouse_1_press"},
        Release = {"mouse1release", "mouse_1release", "mouse1_release", "mouse_1_release"},
        MoveRel = {
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
        function(LClosure: (any) -> any): (any) -> any
            return LClosure
        end
    },

    HookMetaMethod = {"hookmetamethod", "hook_metamethod", "hookmeta_method", "hook_meta_method"},

    Get = {
        NameCallMethod = {"getnamecallmethod", "get_namecallmethod", "getnamecall_method", "get_namecall_method", "get_name_call_method"},
        CustomAsset = {"getcustomasset", "get_customasset", "getcustom_asset", "get_custom_asset"},
        Connections = {"getconnections", "get_connections"}
    },

    SetFFlag = {"setfflag", "set_fflag", "set_fastflag", "set_fast_flag"},

    Clone = {
        Function = {"clonefunction", "clone_function","copyfunction", "copy_function"},
        Ref = {"cloneref", "clone_ref", "clonereference", "clone_reference"}
    },

    HttpRequest = {"httprequest", "http_request", "request", "HttpPost", "Http_Post"}
}

Module.Errors = 0

return Module
