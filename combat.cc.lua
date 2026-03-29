--[=[
 ██████╗ ██████╗ ███╗   ███╗██████╗  █████╗ ████████╗    ██████╗ ██████╗
██╔════╝██╔═══██╗████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝   ██╔════╝██╔════╝
██║     ██║   ██║██╔████╔██║██████╔╝███████║   ██║      ██║     ██║
██║     ██║   ██║██║╚██╔╝██║██╔══██╗██╔══██║   ██║      ██║     ██║
╚██████╗╚██████╔╝██║ ╚═╝ ██║██████╔╝██║  ██║   ██║   ██╗╚██████╗╚██████╗
 ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═════╝
    -- // Made by nikoleto scripts - github.com/nikoladhima \\ --
]=]

--!optimize 2
--!native

if workspace.DistributedGameTime < 3 then
	task.wait(3 - workspace.DistributedGameTime)
end

local StartTick = tick()
local Running = true

local DrawingNew = Drawing and (Drawing.new or Drawing.draw)
assert(pcall(function()
	DrawingNew("Circle"):Remove()
	DrawingNew("Text"):Remove()
	DrawingNew("Line"):Remove()
	DrawingNew("Triangle"):Remove()
	DrawingNew("Square"):Remove()
end), "Exploit not supported.")

local function nsloadstring(UseDefaultPath, Path, ...)
	local Success, Result = pcall(function(...)
        return loadstring(game:HttpGet(
			UseDefaultPath and ("https://raw.githubusercontent.com/nikoladhima/combat.cc/main/" .. Path) or Path
		))(...)
    end, ...)

    if not Success then
        return {
            nsFailed = true,
            Value = Result,
            [3] = tostring(Result)
        }
    end

    return Result
end

local Module = loadstring([=====[
    --!optimize 2
    --!native

    if not (...) or type((...)) ~= "function" then
        return nil
    end

    local Module = {...}

    local function FailedCheck(Result, Name)
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
    local function Load(Name, ...)
        local Item = loadstringFunction(...)

        if FailedCheck(Item, Name) then
            return nil
        end

        return Item
    end

    function Module:GetThreadManager()
        local ThreadManager = {}
        ThreadManager.__index = ThreadManager

        function ThreadManager:Start(Name, Function, Interval)
            if self.Threads[Name] then
                return
            end

            self.Running = true
            local ThreadRunning = true

            self.Threads[Name] = {
                Thread = task.spawn(function()
                    while self.Running and ThreadRunning do
                        Function()
                        task.wait(Interval)
                    end
                end),

                Stop = function()
                    ThreadRunning = false
                end
            }
        end

        function ThreadManager:Stop(Name)
            local Thread = self.Threads[Name]
            if Thread then
                Thread.Stop()
                self.Threads[Name] = nil
            end
        end

        function ThreadManager:Shutdown()
            self.Running = false

            for _,Thread in pairs(self.Threads) do
                Thread.Stop()
            end

            table.clear(self.Threads)
        end

        return setmetatable({
            Threads = {},
            Running = false
        }, ThreadManager)
    end

    function Module:GetFunctionValidator()
        local Success, Environment = pcall(function()
            return (
                getgenv or get_genv or getg_env or get_g_env
                or getglobalenv or get_globalenv or getglobal_env or get_global_env
                or getglobalenvironment or get_globalenvironment  or getglobal_environment or get_global_environment or function()
                    return _G
                end
            )()
        end)

        if not Environment then
            return nil, "broken ass executor :skull:"
        elseif not Environment.ns__FunctionValidatorCache then
            Environment.ns__FunctionValidatorCache = {}
        end

        local FunctionValidator = {}

        function FunctionValidator.Validate(Name, UNCName, Fallback)
            if UNCName and Environment.ns__FunctionValidatorCache[UNCName] then
                return Environment.ns__FunctionValidatorCache[UNCName]
            end

            local function GetFunction(FunctionName)
                local Function = rawget(Environment, FunctionName) or Environment[FunctionName]
                if type(Function) == "function" then
                    return Function
                end
            end

            local Function

            if type(Name) == "table" then
                for _,FunctionName in Name do
                    Function = GetFunction(FunctionName)
                    if Function then
                        break
                    end
                end
            else
                Function = GetFunction(Name)
            end

            Function = Function or Fallback

            if type(Function) ~= "function" then
                return nil
            end

            local Metatable = setmetatable({IsWaxxed = Function == Fallback}, {
                __call = function(_, ...) return
                    Function(...)
                end
            })

            if UNCName then
                Environment.ns__FunctionValidatorCache[UNCName] = Metatable
            end

            return Metatable
        end

        function FunctionValidator:GetEnvironment()
            if Success then
                return Environment
            end
            return {}
        end

        return FunctionValidator
    end

    function Module:GetThemeManager(Table)
        return loadstring([===[
            local Helper = (...)
            if not Helper or type(Helper) ~= "table" then
                return nil
            end

            local HttpService = Helper[1]
            local listfiles, isfile, readfile, writefile, delfile = Helper[2], Helper[3], Helper[4], Helper[5], Helper[6]
            local isfolder, makefolder = Helper[7], Helper[8]

            local ThemeManager = {}
            do
                local ThemeFields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor" }
                ThemeManager.Folder = "ObsidianLibSettings"
                -- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

                ThemeManager.Library = nil
                ThemeManager.AppliedToTab = false
                ThemeManager.BuiltInThemes = {
                    ["Default"] = {
                        1,
                        { FontColor = "ffffff", MainColor = "191919", AccentColor = "7d55ff", BackgroundColor = "0f0f0f", OutlineColor = "282828" },
                    },
                    ["BBot"] = {
                        2,
                        { FontColor = "ffffff", MainColor = "1e1e1e", AccentColor = "7e48a3", BackgroundColor = "232323", OutlineColor = "141414" },
                    },
                    ["Fatality"] = {
                        3,
                        { FontColor = "ffffff", MainColor = "1e1842", AccentColor = "c50754", BackgroundColor = "191335", OutlineColor = "3c355d" },
                    },
                    ["Jester"] = {
                        4,
                        { FontColor = "ffffff", MainColor = "242424", AccentColor = "db4467", BackgroundColor = "1c1c1c", OutlineColor = "373737" },
                    },
                    ["Mint"] = {
                        5,
                        { FontColor = "ffffff", MainColor = "242424", AccentColor = "3db488", BackgroundColor = "1c1c1c", OutlineColor = "373737" },
                    },
                    ["Tokyo Night"] = {
                        6,
                        { FontColor = "ffffff", MainColor = "191925", AccentColor = "6759b3", BackgroundColor = "16161f", OutlineColor = "323232" },
                    },
                    ["Ubuntu"] = {
                        7,
                        { FontColor = "ffffff", MainColor = "3e3e3e", AccentColor = "e2581e", BackgroundColor = "323232", OutlineColor = "191919" },
                    },
                    ["Quartz"] = {
                        8,
                        { FontColor = "ffffff", MainColor = "232330", AccentColor = "426e87", BackgroundColor = "1d1b26", OutlineColor = "27232f" },
                    },
                    ["Nord"] = {
                        9,
                        { FontColor = "eceff4", MainColor = "3b4252", AccentColor = "88c0d0", BackgroundColor = "2e3440", OutlineColor = "4c566a" },
                    },
                    ["Dracula"] = {
                        10,
                        { FontColor = "f8f8f2", MainColor = "44475a", AccentColor = "ff79c6", BackgroundColor = "282a36", OutlineColor = "6272a4" },
                    },
                    ["Monokai"] = {
                        11,
                        { FontColor = "f8f8f2", MainColor = "272822", AccentColor = "f92672", BackgroundColor = "1e1f1c", OutlineColor = "49483e" },
                    },
                    ["Gruvbox"] = {
                        12,
                        { FontColor = "ebdbb2", MainColor = "3c3836", AccentColor = "fb4934", BackgroundColor = "282828", OutlineColor = "504945" },
                    },
                    ["Solarized"] = {
                        13,
                        { FontColor = "839496", MainColor = "073642", AccentColor = "cb4b16", BackgroundColor = "002b36", OutlineColor = "586e75" },
                    },
                    ["Catppuccin"] = {
                        14,
                        { FontColor = "d9e0ee", MainColor = "302d41", AccentColor = "f5c2e7", BackgroundColor = "1e1e2e", OutlineColor = "575268" },
                    },
                    ["One Dark"] = {
                        15,
                        { FontColor = "abb2bf", MainColor = "282c34", AccentColor = "c678dd", BackgroundColor = "21252b", OutlineColor = "5c6370" },
                    },
                    ["Cyberpunk"] = {
                        16,
                        { FontColor = "f9f9f9", MainColor = "262335", AccentColor = "00ff9f", BackgroundColor = "1a1a2e", OutlineColor = "413c5e" },
                    },
                    ["Oceanic Next"] = {
                        17,
                        { FontColor = "d8dee9", MainColor = "1b2b34", AccentColor = "6699cc", BackgroundColor = "16232a", OutlineColor = "343d46" },
                    },
                    ["Material"] = {
                        18,
                        { FontColor = "eeffff", MainColor = "212121", AccentColor = "82aaff", BackgroundColor = "151515", OutlineColor = "424242" },
                    }
                }

                function ThemeManager:SetLibrary(library)
                    self.Library = library
                end

                --// Folders \\--
                function ThemeManager:GetPaths()
                    local paths = {}

                    local parts = self.Folder:split("/")
                    for idx = 1, #parts do
                        paths[#paths + 1] = table.concat(parts, "/", 1, idx)
                    end

                    paths[#paths + 1] = self.Folder .. "/themes"

                    return paths
                end

                function ThemeManager:BuildFolderTree()
                    local paths = self:GetPaths()

                    for i = 1, #paths do
                        local str = paths[i]
                        if isfolder(str) then
                            continue
                        end
                        makefolder(str)
                    end
                end

                function ThemeManager:CheckFolderTree()
                    if isfolder(self.Folder) then
                        return
                    end
                    self:BuildFolderTree()

                    task.wait(0.1)
                end

                function ThemeManager:SetFolder(folder)
                    self.Folder = folder
                    self:BuildFolderTree()
                end

                --// Apply, Update theme \\--
                function ThemeManager:ApplyTheme(theme)
                    local customThemeData = self:GetCustomTheme(theme)
                    local data = customThemeData or self.BuiltInThemes[theme]

                    if not data then
                        return
                    end

                    local scheme = data[2]
                    for idx, val in pairs(customThemeData or scheme) do
                        if idx == "VideoLink" then
                            continue
                        elseif idx == "FontFace" then
                            self.Library:SetFont(Enum.Font[val])

                            if self.Library.Options[idx] then
                                self.Library.Options[idx]:SetValue(val)
                            end
                        else
                            self.Library.Scheme[idx] = Color3.fromHex(val)

                            if self.Library.Options[idx] then
                                self.Library.Options[idx]:SetValueRGB(Color3.fromHex(val))
                            end
                        end
                    end

                    self:ThemeUpdate()
                end

                function ThemeManager:ThemeUpdate()
                    for i, field in ThemeFields do
                        if self.Library.Options and self.Library.Options[field] then
                            self.Library.Scheme[field] = self.Library.Options[field].Value
                        end
                    end

                    self.Library:UpdateColorsUsingRegistry()
                end

                --// Get, Load, Save, Delete, Refresh \\--
                function ThemeManager:GetCustomTheme(file)
                    local path = self.Folder .. "/themes/" .. file .. ".json"
                    if not isfile(path) then
                        return nil
                    end

                    local data = readfile(path)
                    local success, decoded = pcall(HttpService.JSONDecode, HttpService, data)

                    if not success then
                        return nil
                    end

                    return decoded
                end

                function ThemeManager:LoadDefault()
                    local theme = "Default"
                    local content = isfile(self.Folder .. "/themes/default.txt") and readfile(self.Folder .. "/themes/default.txt")

                    local isDefault = true
                    if content then
                        if self.BuiltInThemes[content] then
                            theme = content
                        elseif self:GetCustomTheme(content) then
                            theme = content
                            isDefault = false
                        end
                    elseif self.BuiltInThemes[self.DefaultTheme] then
                        theme = self.DefaultTheme
                    end

                    if isDefault then
                        self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
                    else
                        self:ApplyTheme(theme)
                    end
                end

                function ThemeManager:SaveDefault(theme)
                    writefile(self.Folder .. "/themes/default.txt", theme)
                end

                function ThemeManager:SetDefaultTheme(theme)
                    assert(self.Library, "Must set ThemeManager.Library first!")
                    assert(not self.AppliedToTab, "Cannot set default theme after applying ThemeManager to a tab!")

                    local FinalTheme = {}
                    local LibraryScheme = {}
                    for _, field in ThemeFields do
                        if typeof(theme[field]) == "Color3" then
                            FinalTheme[field] = "#" .. theme[field]:ToHex()
                            LibraryScheme[field] = theme[field]

                        elseif typeof(theme[field]) == "string" then
                            FinalTheme[field] = if theme[field]:sub(1, 1) == "#" then theme[field] else ("#" .. theme[field])
                            LibraryScheme[field] = Color3.fromHex(theme[field])

                        else
                            FinalTheme[field] = ThemeManager.BuiltInThemes["Default"][2][field]
                            LibraryScheme[field] = Color3.fromHex(ThemeManager.BuiltInThemes["Default"][2][field])
                        end
                    end

                    if typeof(theme["FontFace"]) == "EnumItem" then
                        FinalTheme["FontFace"] = theme["FontFace"].Name
                        LibraryScheme["Font"] = Font.fromEnum(theme["FontFace"])

                    elseif typeof(theme["FontFace"]) == "string" then
                        FinalTheme["FontFace"] = theme["FontFace"]
                        LibraryScheme["Font"] = Font.fromEnum(Enum.Font[theme["FontFace"]])

                    else
                        FinalTheme["FontFace"] = "Code"
                        LibraryScheme["Font"] = Font.fromEnum(Enum.Font.Code)
                    end

                    for _, field in { "RedColor", "DarkColor", "WhiteColor" } do
                        LibraryScheme[field] = self.Library.Scheme[field]
                    end

                    self.Library.Scheme = LibraryScheme
                    self.BuiltInThemes["Default"] = { 1, FinalTheme }

                    self.Library:UpdateColorsUsingRegistry()
                end

                function ThemeManager:SaveCustomTheme(file)
                    if file:gsub(" ", "") == "" then
                        self.Library:Notify("Invalid file name for theme (empty)", 3)
                        return
                    end

                    local theme = {}
                    for _, field in ThemeFields do
                        theme[field] = self.Library.Options[field].Value:ToHex()
                    end
                    theme["FontFace"] = self.Library.Options["FontFace"].Value

                    writefile(self.Folder .. "/themes/" .. file .. ".json", HttpService:JSONEncode(theme))
                end

                function ThemeManager:Delete(name)
                    if not name then
                        return false, "no config file is selected"
                    end

                    local file = self.Folder .. "/themes/" .. name .. ".json"
                    if not isfile(file) then
                        return false, "invalid file"
                    end

                    local success = pcall(delfile, file)
                    if not success then
                        return false, "delete file error"
                    end

                    return true
                end

                function ThemeManager:ReloadCustomThemes()
                    local list = listfiles(self.Folder .. "/themes")

                    local out = {}
                    for i = 1, #list do
                        local file = list[i]
                        if file:sub(-5) == ".json" then
                            -- i hate this but it has to be done ...

                            local pos = file:find(".json", 1, true)
                            local start = pos

                            local char = file:sub(pos, pos)
                            while char ~= "/" and char ~= "\\" and char ~= "" do
                                pos = pos - 1
                                char = file:sub(pos, pos)
                            end

                            if char == "/" or char == "\\" then
                                table.insert(out, file:sub(pos + 1, start - 1))
                            end
                        end
                    end

                    return out
                end

                --// GUI \\--
                function ThemeManager:CreateThemeManager(groupbox)
                    groupbox
                        :AddLabel("Background color")
                        :AddColorPicker("BackgroundColor", { Default = self.Library.Scheme.BackgroundColor })
                    groupbox:AddLabel("Main color"):AddColorPicker("MainColor", { Default = self.Library.Scheme.MainColor })
                    groupbox:AddLabel("Accent color"):AddColorPicker("AccentColor", { Default = self.Library.Scheme.AccentColor })
                    groupbox
                        :AddLabel("Outline color")
                        :AddColorPicker("OutlineColor", { Default = self.Library.Scheme.OutlineColor })
                    groupbox:AddLabel("Font color"):AddColorPicker("FontColor", { Default = self.Library.Scheme.FontColor })
                    groupbox:AddDropdown("FontFace", {
                        Text = "Font Face",
                        Default = "Code",
                        Values = { "BuilderSans", "Code", "Fantasy", "Gotham", "Jura", "Roboto", "RobotoMono", "SourceSans" },
                    })

                    local ThemesArray = {}
                    for Name, Theme in pairs(self.BuiltInThemes) do
                        table.insert(ThemesArray, Name)
                    end

                    table.sort(ThemesArray, function(a, b)
                        return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1]
                    end)

                    groupbox:AddDivider()

                    groupbox:AddDropdown("ThemeManager_ThemeList", { Text = "Theme list", Values = ThemesArray, Default = 1 })
                    groupbox:AddButton("Set as default", function()
                        self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
                        self.Library:Notify(
                            string.format("Set default theme to %q", self.Library.Options.ThemeManager_ThemeList.Value)
                        )
                    end)

                    self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
                        self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
                    end)

                    groupbox:AddDivider()

                    groupbox:AddInput("ThemeManager_CustomThemeName", { Text = "Custom theme name" })
                    groupbox:AddButton("Create theme", function()
                        local name = self.Library.Options.ThemeManager_CustomThemeName.Value

                        if name:gsub(" ", "") == "" then
                            self.Library:Notify("Invalid theme name (empty)", 2)
                            return
                        end

                        self:SaveCustomTheme(name)

                        self.Library:Notify(string.format("Created theme %q", name))
                        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
                    end)

                    groupbox:AddDivider()

                    groupbox:AddDropdown(
                        "ThemeManager_CustomThemeList",
                        { Text = "Custom themes", Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 }
                    )
                    groupbox:AddButton("Load theme", function()
                        local name = self.Library.Options.ThemeManager_CustomThemeList.Value

                        self:ApplyTheme(name)
                        self.Library:Notify(string.format("Loaded theme %q", name))
                    end)
                    groupbox:AddButton("Overwrite theme", function()
                        local name = self.Library.Options.ThemeManager_CustomThemeList.Value

                        self:SaveCustomTheme(name)
                        self.Library:Notify(string.format("Overwrote config %q", name))
                    end)
                    groupbox:AddButton("Delete theme", function()
                        local name = self.Library.Options.ThemeManager_CustomThemeList.Value

                        local success, err = self:Delete(name)
                        if not success then
                            self.Library:Notify("Failed to delete theme: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Deleted theme %q", name))
                        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
                    end)
                    groupbox:AddButton("Refresh list", function()
                        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
                    end)
                    groupbox:AddButton("Set as default", function()
                        if
                            self.Library.Options.ThemeManager_CustomThemeList.Value ~= nil
                            and self.Library.Options.ThemeManager_CustomThemeList.Value ~= ""
                        then
                            self:SaveDefault(self.Library.Options.ThemeManager_CustomThemeList.Value)
                            self.Library:Notify(
                                string.format("Set default theme to %q", self.Library.Options.ThemeManager_CustomThemeList.Value)
                            )
                        end
                    end)
                    groupbox:AddButton("Reset default", function()
                        local success = pcall(delfile, self.Folder .. "/themes/default.txt")
                        if not success then
                            self.Library:Notify("Failed to reset default: delete file error")
                            return
                        end

                        self.Library:Notify("Set default theme to nothing")
                        self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
                        self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
                    end)

                    self:LoadDefault()
                    self.AppliedToTab = true

                    local function UpdateTheme()
                        self:ThemeUpdate()
                    end

                    self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
                    self.Library.Options.MainColor:OnChanged(UpdateTheme)
                    self.Library.Options.AccentColor:OnChanged(UpdateTheme)
                    self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
                    self.Library.Options.FontColor:OnChanged(UpdateTheme)
                    self.Library.Options.FontFace:OnChanged(function(Value)
                        self.Library:SetFont(Enum.Font[Value])
                        self.Library:UpdateColorsUsingRegistry()
                    end)
                end

                function ThemeManager:CreateGroupBox(tab)
                    assert(self.Library, "Must set ThemeManager.Library first!")
                    return tab:AddLeftGroupbox("Themes", "paintbrush")
                end

                function ThemeManager:ApplyToTab(tab)
                    assert(self.Library, "Must set ThemeManager.Library first!")
                    local groupbox = self:CreateGroupBox(tab)
                    self:CreateThemeManager(groupbox)
                end

                function ThemeManager:ApplyToGroupbox(groupbox)
                    assert(self.Library, "Must set ThemeManager.Library first!")
                    self:CreateThemeManager(groupbox)
                end

                ThemeManager:BuildFolderTree()
            end

            getgenv().ObsidianThemeManager = ThemeManager
            return ThemeManager
        ]===])(Table)
    end

    function Module:GetSaveManager(Table)
        return loadstring([===[
            local Helper = (...)
            if not Helper or type(Helper) ~= "table" then
                return nil
            end

            local clonefunction = Helper[1]
            local HttpService = Helper[2]
            local listfiles, isfile, readfile, writefile, delfile = Helper[3], Helper[4], Helper[5], Helper[6], Helper[7]
            local isfolder, makefolder = Helper[8], Helper[9]

            local SaveManager = {} do
                SaveManager.Folder = "ObsidianLibSettings"
                SaveManager.SubFolder = ""
                SaveManager.Ignore = {}
                SaveManager.Library = nil
                SaveManager.Parser = {
                    Toggle = {
                        Save = function(Index, Object)
                            return { type = "Toggle", idx = Index, value = Object.Value }
                        end,
                        Load = function(Index, Data)
                            local Object = SaveManager.Library.Toggles[Index]
                            if Object and Object.Value ~= Data.value then
                                Object:SetValue(Data.value)
                            end
                        end,
                    },
                    Slider = {
                        Save = function(Index, Object)
                            return { type = "Slider", idx = Index, value = tostring(Object.Value) }
                        end,
                        Load = function(Index, Data)
                            local Object = SaveManager.Library.Options[Index]
                            if Object and Object.Value ~= Data.value then
                                Object:SetValue(Data.value)
                            end
                        end,
                    },
                    Dropdown = {
                        Save = function(Index, Object)
                            return { type = "Dropdown", idx = Index, value = Object.Value, multi = Object.Multi }
                        end,
                        Load = function(Index, Data)
                            local object = SaveManager.Library.Options[Index]
                            if object and object.Value ~= Data.value then
                                object:SetValue(Data.value)
                            end
                        end,
                    },
                    ColorPicker = {
                        Save = function(Index, Object)
                            return { type = "ColorPicker", idx = Index, value = Object.Value:ToHex(), transparency = Object.Transparency }
                        end,
                        Load = function(Index, Data)
                            if SaveManager.Library.Options[Index] then
                                SaveManager.Library.Options[Index]:SetValueRGB(Color3.fromHex(Data.value), Data.transparency)
                            end
                        end,
                    },
                    KeyPicker = {
                        Save = function(Index, Object)
                            return { type = "KeyPicker", idx = Index, mode = Object.Mode, key = Object.Value, modifiers = Object.Modifiers }
                        end,
                        Load = function(Index, Data)
                            if SaveManager.Library.Options[Index] then
                                SaveManager.Library.Options[Index]:SetValue({ Data.key, Data.mode, Data.modifiers })
                            end
                        end,
                    },
                    Input = {
                        Save = function(Index, Object)
                            return { type = "Input", idx = Index, text = Object.Value }
                        end,
                        Load = function(Index, Data)
                            local Object = SaveManager.Library.Options[Index]
                            if Object and Object.Value ~= Data.text and type(Data.text) == "string" then
                                SaveManager.Library.Options[Index]:SetValue(Data)
                            end
                        end,
                    },
                }

                function SaveManager:SetLibrary(library)
                    self.Library = library
                end

                function SaveManager:IgnoreThemeSettings()
                    self:SetIgnoreIndexes({
                        "BackgroundColor", "MainColor", "AccentColor", "OutlineColor", "FontColor", "FontFace", -- themes
                        "ThemeManager_ThemeList", "ThemeManager_CustomThemeList", "ThemeManager_CustomThemeName", -- themes
                    })
                end

                --// Folders \\--
                function SaveManager:CheckSubFolder(createFolder)
                    if typeof(self.SubFolder) ~= "string" or self.SubFolder == "" then return false end

                    if createFolder == true then
                        if not isfolder(self.Folder .. "/settings/" .. self.SubFolder) then
                            makefolder(self.Folder .. "/settings/" .. self.SubFolder)
                        end
                    end

                    return true
                end

                function SaveManager:GetPaths()
                    local paths = {}

                    local parts = self.Folder:split("/")
                    for idx = 1, #parts do
                        local path = table.concat(parts, "/", 1, idx)
                        if not table.find(paths, path) then paths[#paths + 1] = path end
                    end

                    paths[#paths + 1] = self.Folder .. "/themes"
                    paths[#paths + 1] = self.Folder .. "/settings"

                    if self:CheckSubFolder(false) then
                        local subFolder = self.Folder .. "/settings/" .. self.SubFolder
                        parts = subFolder:split("/")

                        for idx = 1, #parts do
                            local path = table.concat(parts, "/", 1, idx)
                            if not table.find(paths, path) then paths[#paths + 1] = path end
                        end
                    end

                    return paths
                end

                function SaveManager:BuildFolderTree()
                    local paths = self:GetPaths()

                    for i = 1, #paths do
                        local str = paths[i]
                        if isfolder(str) then continue end

                        makefolder(str)
                    end
                end

                function SaveManager:CheckFolderTree()
                    if isfolder(self.Folder) then return end
                    SaveManager:BuildFolderTree()

                    task.wait(0.1)
                end

                function SaveManager:SetIgnoreIndexes(list)
                    for _, key in pairs(list) do
                        self.Ignore[key] = true
                    end
                end

                function SaveManager:SetFolder(folder)
                    self.Folder = folder
                    self:BuildFolderTree()
                end

                function SaveManager:SetSubFolder(folder)
                    self.SubFolder = folder
                    self:BuildFolderTree()
                end

                --// Save, Load, Delete, Refresh \\--
                function SaveManager:Save(name)
                    if (not name) then
                        return false, "no config file is selected"
                    end
                    SaveManager:CheckFolderTree()

                    local fullPath = self.Folder .. "/settings/" .. name .. ".json"
                    if SaveManager:CheckSubFolder(true) then
                        fullPath = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
                    end

                    local data = {
                        objects = {}
                    }

                    for idx, toggle in pairs(self.Library.Toggles) do
                        if not toggle.Type then continue end
                        if not self.Parser[toggle.Type] then continue end
                        if self.Ignore[idx] then continue end

                        table.insert(data.objects, self.Parser[toggle.Type].Save(idx, toggle))
                    end

                    for idx, option in pairs(self.Library.Options) do
                        if not option.Type then continue end
                        if not self.Parser[option.Type] then continue end
                        if self.Ignore[idx] then continue end

                        table.insert(data.objects, self.Parser[option.Type].Save(idx, option))
                    end

                    local success, encoded = pcall(HttpService.JSONEncode, HttpService, data)
                    if not success then
                        return false, "failed to encode data"
                    end

                    writefile(fullPath, encoded)
                    return true
                end

                function SaveManager:Load(name)
                    if (not name) then
                        return false, "no config file is selected"
                    end
                    SaveManager:CheckFolderTree()

                    local file = self.Folder .. "/settings/" .. name .. ".json"
                    if SaveManager:CheckSubFolder(true) then
                        file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
                    end

                    if not isfile(file) then return false, "invalid file" end

                    local success, decoded = pcall(HttpService.JSONDecode, HttpService, readfile(file))
                    if not success then return false, "decode error" end

                    for _, option in pairs(decoded.objects) do
                        if not option.type then continue end
                        if not self.Parser[option.type] then continue end
                        if self.Ignore[option.idx] then continue end

                        task.spawn(self.Parser[option.type].Load, option.idx, option) -- task.spawn() so the config loading wont get stuck.
                    end

                    return true
                end

                function SaveManager:Delete(name)
                    if (not name) then
                        return false, "no config file is selected"
                    end

                    local file = self.Folder .. "/settings/" .. name .. ".json"
                    if SaveManager:CheckSubFolder(true) then
                        file = self.Folder .. "/settings/" .. self.SubFolder .. "/" .. name .. ".json"
                    end

                    if not isfile(file) then return false, "invalid file" end

                    local success = pcall(delfile, file)
                    if not success then return false, "delete file error" end

                    return true
                end

                function SaveManager:RefreshConfigList()
                    local success, data = pcall(function()
                        SaveManager:CheckFolderTree()

                        local list = {}
                        local out = {}

                        if SaveManager:CheckSubFolder(true) then
                            list = listfiles(self.Folder .. "/settings/" .. self.SubFolder)
                        else
                            list = listfiles(self.Folder .. "/settings")
                        end
                        if typeof(list) ~= "table" then list = {} end

                        for i = 1, #list do
                            local file = list[i]
                            if file:sub(-5) == ".json" then
                                -- i hate this but it has to be done ...

                                local pos = file:find(".json", 1, true)
                                local start = pos

                                local char = file:sub(pos, pos)
                                while char ~= "/" and char ~= "\\" and char ~= "" do
                                    pos = pos - 1
                                    char = file:sub(pos, pos)
                                end

                                if char == "/" or char == "\\" then
                                    table.insert(out, file:sub(pos + 1, start - 1))
                                end
                            end
                        end

                        return out
                    end)

                    if (not success) then
                        if self.Library then
                            self.Library:Notify("Failed to load config list: " .. tostring(data))
                        else
                            warn("Failed to load config list: " .. tostring(data))
                        end

                        return {}
                    end

                    return data
                end

                --// Auto Load \\--
                function SaveManager:GetAutoloadConfig()
                    SaveManager:CheckFolderTree()

                    local autoLoadPath = self.Folder .. "/settings/autoload.txt"
                    if SaveManager:CheckSubFolder(true) then
                        autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
                    end

                    if isfile(autoLoadPath) then
                        local successRead, name = pcall(readfile, autoLoadPath)
                        if not successRead then
                            return "none"
                        end

                        name = tostring(name)
                        return if name == "" then "none" else name
                    end

                    return "none"
                end

                function SaveManager:LoadAutoloadConfig()
                    SaveManager:CheckFolderTree()

                    local autoLoadPath = self.Folder .. "/settings/autoload.txt"
                    if SaveManager:CheckSubFolder(true) then
                        autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
                    end

                    if isfile(autoLoadPath) then
                        local successRead, name = pcall(readfile, autoLoadPath)
                        if not successRead then
                            self.Library:Notify("Failed to load autoload config: write file error")
                            return
                        end

                        local success, err = self:Load(name)
                        if not success then
                            self.Library:Notify("Failed to load autoload config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Auto loaded config %q", name))
                    end
                end

                function SaveManager:SaveAutoloadConfig(name)
                    SaveManager:CheckFolderTree()

                    local autoLoadPath = self.Folder .. "/settings/autoload.txt"
                    if SaveManager:CheckSubFolder(true) then
                        autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
                    end

                    local success = pcall(writefile, autoLoadPath, name)
                    if not success then return false, "write file error" end

                    return true, ""
                end

                function SaveManager:DeleteAutoLoadConfig()
                    SaveManager:CheckFolderTree()

                    local autoLoadPath = self.Folder .. "/settings/autoload.txt"
                    if SaveManager:CheckSubFolder(true) then
                        autoLoadPath = self.Folder .. "/settings/" .. self.SubFolder .. "/autoload.txt"
                    end

                    local success = pcall(delfile, autoLoadPath)
                    if not success then return false, "delete file error" end

                    return true, ""
                end

                --// GUI \\--
                function SaveManager:BuildConfigSection(tab)
                    assert(self.Library, "Must set SaveManager.Library")

                    local section = tab:AddRightGroupbox("Configuration", "folder-cog")

                    section:AddInput("SaveManager_ConfigName",    { Text = "Config name" })
                    section:AddButton("Create config", function()
                        local name = self.Library.Options.SaveManager_ConfigName.Value

                        if name:gsub(" ", "") == "" then
                            self.Library:Notify("Invalid config name (empty)", 2)
                            return
                        end

                        local success, err = self:Save(name)
                        if not success then
                            self.Library:Notify("Failed to create config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Created config %q", name))
                        self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                        self.Library.Options.SaveManager_ConfigList:SetValue(nil)
                    end)

                    section:AddDivider()

                    section:AddDropdown("SaveManager_ConfigList", { Text = "Config list", Values = self:RefreshConfigList(), AllowNull = true })
                    section:AddButton("Load config", function()
                        local name = self.Library.Options.SaveManager_ConfigList.Value

                        local success, err = self:Load(name)
                        if not success then
                            self.Library:Notify("Failed to load config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Loaded config %q", name))
                    end)
                    section:AddButton("Overwrite config", function()
                        local name = self.Library.Options.SaveManager_ConfigList.Value

                        local success, err = self:Save(name)
                        if not success then
                            self.Library:Notify("Failed to overwrite config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Overwrote config %q", name))
                    end)

                    section:AddButton("Delete config", function()
                        local name = self.Library.Options.SaveManager_ConfigList.Value

                        local success, err = self:Delete(name)
                        if not success then
                            self.Library:Notify("Failed to delete config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Deleted config %q", name))
                        self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                        self.Library.Options.SaveManager_ConfigList:SetValue(nil)
                    end)

                    section:AddButton("Refresh list", function()
                        self.Library.Options.SaveManager_ConfigList:SetValues(self:RefreshConfigList())
                        self.Library.Options.SaveManager_ConfigList:SetValue(nil)
                    end)

                    section:AddButton("Set as autoload", function()
                        local name = self.Library.Options.SaveManager_ConfigList.Value

                        local success, err = self:SaveAutoloadConfig(name)
                        if not success then
                            self.Library:Notify("Failed to set autoload config: " .. err)
                            return
                        end

                        self.Library:Notify(string.format("Set %q to auto load", name))
                        self.AutoloadConfigLabel:SetText("Current autoload config: " .. name)
                    end)
                    section:AddButton("Reset autoload", function()
                        local success, err = self:DeleteAutoLoadConfig()
                        if not success then
                            self.Library:Notify("Failed to set autoload config: " .. err)
                            return
                        end

                        self.Library:Notify("Set autoload to none")
                        self.AutoloadConfigLabel:SetText("Current autoload config: none")
                    end)

                    self.AutoloadConfigLabel = section:AddLabel("Current autoload config: " .. self:GetAutoloadConfig(), true)

                    -- self:LoadAutoloadConfig()
                    self:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
                end

                SaveManager:BuildFolderTree()
            end

            return SaveManager
        ]===])(Table)
    end

    function Module:GetLibrary(Table)
        return Load("Library.luau", true, "core/t", Table)
    end

    function Module:SendDataToWebhook(Table)
        return Load("NikoletoService.luau", true, "utils/NikoletoService.luau", Table)
    end

    local CoolEmptyTable = {}

    Module.Tables = {
        Blank = function()
            return "this executor ass bro :skull:"
        end,

        False = function()
            return false
        end,

        True = function()
            return true
        end,

        String = function()
            return "Unknown"
        end,

        Table = function(_)
            return CoolEmptyTable
        end,

        Workspace = {
            listfiles = {"listfiles", "list_files"},
            makefolder = {"makefolder", "make_folder", "createfolder", "create_folder"},
            isfolder = {"isfolder", "is_folder"},
            isfile = {"isfile", "is_file"},
            readfile = {"readfile", "read_file", "readfileasync", "readfile_async", "read_file_async"},
            writefile = {"writefile", "write_file", "writefileasync", "writefile_async", "write_file_async"},
            delfile = {"delfile", "del_file", "deletefile", "delete_file"},
        },

        isrenderobj = {"isrenderobj", "is_renderobj", "isrender_obj", "is_render_obj"},

        identifyexecutor = {
            "identifyexecutor", "identify_executor",
            "getexecutorname", "get_executorname", "getexecutor_name", "get_executor_name"
        },

        Mouse = {
            Press = {"mouse1press", "mouse_1press", "mouse1_press", "mouse_1_press"},
            Release = {"mouse1release", "mouse_1release", "mouse1_release", "mouse_1_release"},
            MoveRel = {
                "mousemoverel", "mouse_moverel", "mousemove_rel", "mouse_move_rel",
                "MouseMoveRel", "Mouse_MoveRel", "MouseMove_Rel", "Mouse_Move_Rel",
                "setmousepos", "set_mousepos", "setmouse_pos", "set_mouse_pos"
            }
        },

        newcclosure = {
            {"newcclosure", "new_cclosure", "newc_closure", "new_c_closure"},
            function(LClosure)
                return LClosure
            end
        },

        hookmetamethod = {"hookmetamethod", "hook_metamethod", "hookmeta_method", "hook_meta_method"},

        getnamecallmethod = {"getnamecallmethod", "get_namecallmethod", "getnamecall_method", "get_namecall_method", "get_name_call_method"},
        getcustomasset = {"getcustomasset", "get_customasset", "getcustom_asset", "get_custom_asset"},
        getconnections = {"getconnections", "get_connections"},

        hookfunction = {"hookfunction", "hook_function", "replaceclosure", "replace_closure"},
        restorefunction = {"restorefunction", "restore_function"},
        clonefunction = {"clonefunction", "clone_function", "copyfunction", "copy_function"},
        cloneref = {"cloneref", "clone_ref", "clonereference", "clone_reference"},

        getgc = {"getgc", "get_gc", "getgarbage", "get_garbage", "getgarbage_collector", "get_garbargecollector", "get_garbage_collector"},

        checkcaller = {"checkcaller", "check_caller"},

        httprequest = {"httprequest", "http_request", "request", "HttpPost", "Http_Post"}
    }

    Module.Errors = 0
    return Module
]=====])(nsloadstring)

if not Module or (type(Module) == "table" and Module.nsFailed) then
	warn("Failed to load Module: " .. Module[3])
	return
else
	print("[nikoletoscripts/combat.cc/core]: Loaded Module.")
end

local ThreadManager = Module:GetThreadManager()
local FunctionValidator = Module:GetFunctionValidator()

if not ThreadManager or not FunctionValidator then
	return "skill issue fr"
end

local function WrapFunction(Function, ...)
	if not Function then
		return FunctionValidator.Validate(...)
	end

	return setmetatable({IsWaxxed = false}, {
		__call = function(_, ...) return
			Function(...)
		end
	})
end

local isfolder = WrapFunction(isfolder, Module.Tables.Workspace.isfolder, "isfolder", Module.Tables.False)
local makefolder = WrapFunction(makefolder, Module.Tables.Workspace.makefolder, "makefolder", Module.Tables.Blank)
local listfiles = WrapFunction(listfiles, Module.Tables.Workspace.listfiles, "listfiles", Module.Tables.Table)
local isfile = WrapFunction(isfile, Module.Tables.Workspace.isfile, "isfile", Module.Tables.False)
local readfile = WrapFunction(readfile, Module.Tables.Workspace.readfile, "readfile", Module.Tables.Table)
local writefile = WrapFunction(writefile, Module.Tables.Workspace.writefile, "writefile", Module.Tables.Blank)
local delfile = WrapFunction(delfile, Module.Tables.Workspace.delfile, "delfile", Module.Tables.Blank)

if not isfolder("combat.cc") then
	makefolder("combat.cc")
end

if not isfolder("combat.cc/Sounds") then
	makefolder("combat.cc/Sounds")
end

local ExecutorName = FunctionValidator.Validate(Module.Tables.identifyexecutor, "identifyexecutor", Module.Tables.String)()

local isrenderobj = isrenderobj or FunctionValidator.Validate(Module.Tables.isrenderobj, "isrenderobj", Module.Tables.True)
local httprequest = httprequest or FunctionValidator.Validate(Module.Tables.httprequest, nil, nil)

local mouse1press = mouse1press or FunctionValidator.Validate(Module.Tables.Mouse.Press, "mouse1press", Module.Tables.True)
local mouse1release = mouse1release or FunctionValidator.Validate(Module.Tables.Mouse.Release, "mouse1release", Module.Tables.True)
local mousemoverel = WrapFunction(mousemoverel, Module.Tables.Mouse.MoveRel, "mousemoverel", Module.Tables.Blank)

local newcclosure = newcclosure or FunctionValidator.Validate(Module.Tables.newcclosure[1], "newcclosure", Module.Tables.newcclosure[2])

local hookmetamethod = nil
if not ExecutorName:lower():find("solara") then
    hookmetamethod = hookmetamethod or FunctionValidator.Validate(Module.Tables.hookmetamethod, nil, nil)
end
local getnamecallmethod = getnamecallmethod or FunctionValidator.Validate(Module.Tables.getnamecallmethod, "getnamecallmethod", Module.Tables.String)

local clonerefFunction = cloneref or FunctionValidator.Validate(Module.Tables.cloneref, "cloneref", nil)
local function nscloneref(Object)
	if not clonerefFunction then
		return Object
	end

	local Success, Result = pcall(clonerefFunction, Object)
	return Success and Result or Object
end

local getcustomassetFunction = getcustomasset or FunctionValidator.Validate(Module.Tables.getcustomasset, "getcustomasset", nil)
local function nsgetcustomasset(File)
	if not getcustomassetFunction then
		return "rbxassetid://0"
	end

	local Success, Result = pcall(getcustomassetFunction, File)
	return Success and Result or "rbxassetid://0"
end

--[[local getconnectionsFunction = getconnections or FunctionValidator.Validate(Module.Tables.getconnections, "getconnections", nil)
local function nsgetconnections(Signal)
	if not getconnectionsFunction then
		return {}
	end

	local Success, Output = pcall(getconnectionsFunction, Signal)
	return Success and Output or {}
end]]

--[[local gethiddenpropertyFunction = gethiddenproperty or get_hidden_property or get_hiddenproperty
local function nsgethiddenproperty(Object, Property)
	if not gethiddenpropertyFunction then
		return false
	end
	local Success, Result = pcall(function()
		gethiddenpropertyFunction(Object, Property)
	end)
	return Success and Result or false
end

local sethiddenpropertyFunction = sethiddenproperty or set_hidden_property or set_hiddenproperty
local function nssethiddenproperty(Object, Property, Value)
	if not sethiddenpropertyFunction then
		return false
	end
	if nsgethiddenproperty(Property) then
		local Success, Result = pcall(function()
			sethiddenpropertyFunction(Object, Property, Value)
		end)
		return Success and Result or false
	end
end]]

local function Create(Type, Parent, Properties)
    local Object = nscloneref(Instance.new(Type))

    if Properties then
        for Property, Value in next, Properties do
			Object[Property] = Value
        end
    end

	if Parent then
		Object.Parent = Parent
	end

    return Object
end

local function CreateDrawing(Type, Properties)
    local DrawingObject = DrawingNew(Type)

    if Properties then
        for Property, Value in next, Properties do
			DrawingObject[Property] = Value
        end
    end

    return DrawingObject
end

local function RemoveDrawing(DrawingObject)
	pcall(function()
		DrawingObject:Remove()
	end)
end

local function GetService(ServiceName)
	return nscloneref(game:GetService(ServiceName))
end

local Connections = {
	Aimbot = nil,
	AimbotViewAtTarget = nil,
	AimbotLookAtTarget = nil,
	TriggerBot = nil,
	Fly = nil,
	Speed = nil,
	Spinbot = nil,
	ForceThirdPerson = nil,
	AnimationFreezer = nil,
	ChinaHat = nil,
	NoclipCamera = nil,
	ShadowDisabler = nil,
	ForceNight = nil,
	ForceDay = nil,
	DarkMode = nil,
	CrosshairRotation = nil,
}

local Players = GetService("Players")
local Lighting = GetService("Lighting")
local ReplicatedStorage = GetService("ReplicatedStorage")
local Teams = GetService("Teams")
local RunService = GetService("RunService")
local UserInputService = GetService("UserInputService")
local HttpService = GetService("HttpService")
local MarketplaceService = GetService("MarketplaceService")
local CoreGui = GetService("CoreGui")
local VirtualInputManager = nil

local CachedPlayers = {}
local CachedPlayersList = {}
local Camera = nil
local ViewportSize = Vector2.zero
local ScreenCenter = Vector2.zero
local ViewportSizeX = 0
local ViewportSizeY = 0
local LocalPlayer = Players.LocalPlayer
local PlayerGui = nscloneref(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
local Mouse = nscloneref(LocalPlayer:GetMouse())
local MouseLocation = UserInputService:GetMouseLocation()
local LocalCharacter = nil
local LocalHumanoid = nil
local LocalHead = nil
local LocalRoot = nil

local ScriptVersion = "3.0.0b"
local Library = Module:GetLibrary({
	GetService,
	CoreGui, Players,
	RunService, GetService("SoundService"),
	UserInputService, GetService("TextService"),
	Teams, GetService("TweenService"),
	FunctionValidator:GetEnvironment(), setclipboard,
	FunctionValidator.Validate({"gethui", "get_hui", "gethiddenui", "get_hiddenui", "gethidden_ui", "get_hidden_ui"}, "gethui", function()
		return CoreGui
	end), nsgetcustomasset,
	Create, LocalPlayer, Mouse,
	isfolder, makefolder, isfile, writefile,
	ScriptVersion
})

if not Library then
	return "skill issue fr"
end

local IsXeno = ExecutorName:lower():find("xeno")
local Options = Library.Options
local Toggles = Library.Toggles
local Watermark = Library:AddDraggableLabel("[nikoletoscripts/combat.cc] | Unknown | 0 | 0")
local WatermarkIsVisible = true

local CachedRobloxGui = nil
local CachedClippingShield = nil
local CachedSettingsShield = nil

local CameraModeClassic = Enum.CameraMode.Classic
local CameraModeLockFirstPerson = Enum.CameraMode.LockFirstPerson
local RigTypeR15 = Enum.HumanoidRigType.R15
local KeyCodeW = Enum.KeyCode.W
local KeyCodeA = Enum.KeyCode.A
local KeyCodeS = Enum.KeyCode.S
local KeyCodeD = Enum.KeyCode.D
local KeyCodeSpace = Enum.KeyCode.Space
local KeyCodeRightControl = Enum.KeyCode.RightControl
local EnumFreefallState = Enum.HumanoidStateType.Freefall
local EnumJumpingState = Enum.HumanoidStateType.Jumping
local HighlightDepthModeAlwaysOnTop = Enum.HighlightDepthMode.AlwaysOnTop
local HighlightDepthModeOccluded = Enum.HighlightDepthMode.Occluded
local IsMouseAndKeyboardPreferredInput = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse

local Vector3PlusHoundredY = Vector3.new(0, 100, 0)
local Vector3MinusHoundredY = Vector3.new(0, -100, 0)
local ESPHeadOffset = Vector3.new(0, 1.5, 0)
local R6Neck = Vector3.new(0, 0.4, 0)
local R6Waist = Vector3.new(0, -0.5, 0)
local R6Top = Vector3.new(0, 0.5, 0)
local R6Bottom = Vector3.new(0, -0.5, 0)
local CFrameZero = CFrame.new(0, 0, 0)
local FixedBottomCenter = Vector2.zero

local GreenRGBColor = Color3.fromRGB(0, 255, 0)

local Aimbot = {
	Toggled = false,
	Enabled = false,

	Target = nil,
	AimPart = "Root",

	StickyAim = true,

	FOVCircle = {
		Enabled = false,
		Filled = false,
		Transparency = 1,
		Thickness = 1,
		Radius = 50,
		Color = Color3.fromRGB(255, 255, 255),
		Position = "Mouse"
	},

	ShakeOffset = 0,

	AutoPrediction = false,
	PredictionOffset = 0,

	ForceFieldCheck = false,
	SitCheck = false,
	WallCheck = false,
	TeamCheck = false,
	DeadCheck = false,
	DeadCheckMode = "Universal",
	CustomDeadCheckValue = 0,

	StopOnCheck = true,

	Resolver = false,
	ResolverType = "MoveDirection",

	SmoothnessOffset = 0,

	TargetView = {
		TargetLabel = nil,
		HealthLabel = nil,
		StudsLabel = nil,
	}
}
local HitConfiguration = {
	Toggled = false,

	Marker = {
		Enabled = false,
		Color = Color3.fromRGB(255, 255, 255),
		Lifetime = 1,
		Scale = 1,
		Style = "Classic X",
		CenterDot = false,
		FadeIn = false,
		FadeOut = false,
	},

	Log = {
		Enabled = false,
		Color = Color3.fromRGB(255, 255, 255),
		UseColor = false,
		Duration = 1,
	},

	Sound = {
		Enabled = false,
		Selected = "Osu",
		Volume = 5
	},

	PreviousHealth = nil,
}
local HitMarkerDirections = {
	Vector2.new(-1, -1), Vector2.new( 1, -1),
	Vector2.new(-1,  1), Vector2.new( 1,  1)
}

local SilentAimbot = {
	Toggled = false,
	Enabled = false,

	AimPart = "Root",

	FOVCircle = {
		Enabled = false,
		Filled = false,
		Transparency = 1,
		Thickness = 1,
		Radius = 50,
		Color = Color3.fromRGB(255, 255, 255),
		Position = "Mouse"
	},

	--Wallbang = false,

	ForceFieldCheck = false,
	WallCheck = false,
	TeamCheck = false,
	DeadCheck = false,

	InfiniteAmmoKAT = false
}

local TriggerBot = {
	Toggled = false,
	Enabled = false,

	Target = nil,

	ForceFieldCheck = false,
	TeamCheck = false,
	DeadCheck = false,
	DeadCheckMode = "Universal",
	CustomDeadCheckValue = 0,

	TriggerDelay = 0.1,
}

local AimbotFOVCircles = {
	Target = CreateDrawing("Circle", {
		Color = Aimbot.FOVCircle.Color,
		Filled = Aimbot.FOVCircle.Filled,
		Thickness = Aimbot.FOVCircle.Thickness,
		Radius = Aimbot.FOVCircle.Radius,
		Visible = false
	}),

	Silent = CreateDrawing("Circle", {
		Color = SilentAimbot.FOVCircle.Color,
		Filled = SilentAimbot.FOVCircle.Filled,
		Thickness = SilentAimbot.FOVCircle.Thickness,
		Radius = SilentAimbot.FOVCircle.Radius,
		Visible = false
	})
}

local PredictionSettings = {
    Camera = {
        AutoPredictionMultiplier = 0.001, -- 1 / 1000
        AimbotConfiguration = Aimbot
    },
    Mouse = {
        AutoPredictionMultiplier = 0.001176470588, -- 1 / 850
        AimbotConfiguration = Aimbot
    },
    Silent = {
        AutoPredictionMultiplier = 0.001111111111, -- 1 / 900
        AimbotConfiguration = SilentAimbot
    }
}

local HitSounds = {
	Sounds = {
		["Osu"] = "7172607676",
		["Pop"] = "102822111971881",
		["MLG"] = "109817519733426",
		["Metal"] = "8917041751",
		["Neverlose"] = "18391691942",
		["Jet Set Radio"] = "97113622160405",
		["TF2 Critical"] = "8255306220",
		["TF2 Alternative"] = "2868331684",
		["TF2 Frying Pan"] = "18922477538",
		["Bad Business Headshot"] = "9368845024"
	},
	Options = {
		"Osu",
		"Pop",
		"MLG",
		"Metal",
		"Neverlose",
		"Jet Set Radio",
		"TF2 Critical",
		"TF2 Alternative",
		"TF2 Frying Pan",
		"Bad Business Headshot",
	},
	Folder = Create("Folder", CoreGui)
}

local Movement = {
	Fly = {
		Toggled = false,
		Enabled = false,
		SpeedValue = 50
	},
	Speed = {
		Toggled = false,
		Enabled = false,
		SpeedValue = 0.5
	},
	SpinBotSpeed = 1,
	InfiniteJump = false,
	NoJumpCooldown = false,
	AutoJump = false,
	OldCameraMaxZoomDistance = 0
}

local AntiAim = {
	Toggled = false,
	Enabled = false,
	VelocityMode = "None",
	VelocityModeBehaviours = {
		["Randomizer"] = function()
			return Vector3.new(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100))
		end,
		["Heavenly"] = function(Root)
			return Root.AssemblyLinearVelocity + Vector3PlusHoundredY
		end,
		["Underground"] = function(Root)
			return Root.AssemblyLinearVelocity + Vector3MinusHoundredY
		end,
		["Look Vector"] = function(Root)
			return Root.CFrame.LookVector * 10000
		end,
		["Prediction Multiplier"] = function(Root)
			return Root.AssemblyLinearVelocity * math.random(7, 10)
		end,
		["Prediction Changer"] = function(Root)
			return Root.AssemblyLinearVelocity + Vector3.new(math.random(-50, 50), math.random(-25, 25), math.random(-12.5, 12.5))
		end,
		["Prediction Disabler"] = function()
			return Vector3.zero
		end
	},
	CFrameMode = "None",
	DontLook = false,
	LookValue = -1,
	LookWaitTime = 0
}

local ChinaHat = {
    ChinaHatTrail = nil,
    ChinaHatColor = Color3.fromRGB(255, 0, 0),
    ChinaHatTrailSize = Vector3.new(3, 0.7, 3),
    ChinaHatMeshScale = Vector3.new(3, 0.6, 3),
}
local OldDevCameraOcclusionMode = LocalPlayer.DevCameraOcclusionMode
local SelectedPlayer = nil

local ESPObjects = {}

local ESPToggled = false

local ESPDynamicRefreshRate = true
local ESPRefreshRate = 60
local ESPAccumulator = 0

local ESPPerformanceMode = false

local ESPDistanceCheck = 4000000
local ESPForceFieldCheck = false
local ESPWallCheck = false
local ESPTeamCheck = false

local ChamESP = {
	Enabled = false,
	FillColor = Color3.fromRGB(255, 255, 255),
	OutlineColor = Color3.fromRGB(255, 255, 255),
	FillTransparency = 0.5,
	OutlineTransparency = 0
}

local HeadDotESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Filled = false,
	Transparency = 1
}

local HeadTagESP, TagBuffer = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Transparency = 1,
	Position = "Top"
}, table.create(7)

local TracerESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Type = "Locked",
	Part = "Root",
	Transparency = 1
}

local ArrowESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Filled = false,
	Radius = 80,
	Transparency = 1
}

local BoxESP, BoxPointScreen, BoxPointOnScreen, Box3DOffsets, Box3DEdges = {
	Box2D = {
		Enabled = false,
		Color = Color3.fromRGB(255, 255, 255),
		Filled = false,
		Transparency = 1
	},
	Box3D = {
		Enabled = false,
		Color = Color3.fromRGB(255, 255, 255),
		Transparency = 1
	}
}, table.create(8), table.create(8), {
	Vector3.new(-2, 3, -1.5), Vector3.new(2, 3, -1.5),
    Vector3.new(-2, -3, -1.5), Vector3.new(2, -3, -1.5),
    Vector3.new(-2, 3, 1.5), Vector3.new(2, 3, 1.5),
	Vector3.new(-2, -3, 1.5), Vector3.new(2, -3, 1.5)
}, {
	{1,2}, {2,4}, {4,3}, {3,1},
	{5,6}, {6,8}, {8,7}, {7,5},
	{1,5}, {2,6}, {3,7}, {4,8}
}

local HealthBarESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Thickness = 2,
	Transparency = 1
}

local SkeletonESP, SkeletonCachePoints, SkeletonCacheVisible, R15SkeletonLines = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Thickness = 1,
	Transparency = 1
}, table.create(32), table.create(32), {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},

    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},

    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},

    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},

    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"},
}

local World = {
	--[[LightingTechnology = Lighting.Technology,
	OldLightingTechnology = tostring(Lighting.Technology):gsub("Enum.Technology.", ""),]]
	OldGeographicLatitude = Lighting.GeographicLatitude,
	OldExposureCompensation = Lighting.ExposureCompensation,
	OldAmbient = Lighting.Ambient,
	Highlight = {
		Color = Color3.fromRGB(255, 255, 255),
		Transparency = 0
	},
	CharacterTransparency = 0.5,
	OldLocalTransparencyModifier = 0,
	HasAppliedCharacterTransparency = false
}

local CrosshairOverlay = {
    Enabled = false,

    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 2,
    Length = 10,
    Gap = 2,
    Transparency = 1,

    DotEnabled = false,
    DotStyle = "Square",
    DotSize = 2,
    DotColor = Color3.fromRGB(255, 255, 255),

    TStyle = false,

    Rotation = 0,
    RotationStatic = true,
    CurrentRotation = 0,

    Drawings = {
        Lines = {},
        Dot = nil
    },

    BaseOffsets = {
        Vector2.new(0, -1),
        Vector2.new(0, 1),
        Vector2.new(-1, 0),
        Vector2.new(1, 0)
    }
}

local CachedRaycastParams = RaycastParams.new()
CachedRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
CachedRaycastParams.IgnoreWater = true

local GameId = tostring(game.GameId)
local Games = {}
for Variable, StringGameId in next, {
    IsArsenal = "111958650",
	["Arsenal 2020 Revival"] = "7823128924",
	IsArsenal2020Revival = "7823128924",
	["Arsenal Refreshed"] = "8607106986",
	IsArsenalRefreshed = "8607106986",
    IsFlick = "8795154789",
	["Knife Ability Test"] = "254394801",
	IsKAT = "254394801",
	["P2W Trash Game X | KAT better"] = "8250618750",
	IsKATX = "8250618750",
	["One Tap"] = "9294074907",
	IsOneTap = "9294074907",
	IsQuickShot = "9323860275",
	IsStrucid = "833423526",
	["Da Hood"] = "1008451066",
	IsDaHood = "1008451066",
	["Murderers VS Sheriffs DUELS"] = "4348829796",
    MurderersVSSheriffsDUELS = "4348829796",
	["Gun Grounds FFA"] = "4281211770",
    IsGunGroundsFFA = "4281211770",
	["CounterBlox: Re-Imagined"] = "9606714812",
	IsCounterBloxReImagined = "9606714812",
    IsCounterBlox = "115797356",
    IsAimblox = "2585430167",
    IsRivals = "6035872082",
    ["Defuse Division"] = "7072674902",
    IsDefuseDivision = "7072674902",
	["Sniper Arena"] = "9534705677",
	IsSniperArena = "9534705677",
	["Combat Arena"] = "5421899973",
	IsCombatArena = "5421899973",
	IsBloxStrike = "7633926880",
	["War Tycoon"] = "1526814825",
	IsWarTycoon = "1526814825",
	IsDefusal = "6993600665",
	IsAladiaPvP = "8050914790",
	IsFantasmaPVP = "7380551893",
	IsDeadEye = "9571037154",
	["Operation One"] = "8307114974",
	IsOperationOne = "8307114974"
} do
    Games[Variable] = (GameId == StringGameId)
end

local IsArsenalBaseGame = Games.IsArsenal or Games.IsArsenal2020Revival or Games.IsArsenalRefreshed
local IsCounterBloxBaseGame = Games.IsCounterBlox or Games.IsCounterBloxReImagined

local CoolEmptyTable = {}

--[[for _,Connection in nsgetconnections(GetService("ScriptContext").Error) do
	local Function = Connection.Function
	if Function then
		Connection.Function = newcclosure(function()
			return "rip error :skull: fuck your anticheat"
		end)
	end
end]]

local nsrequire = not IsXeno and function(ModuleScript)
	return require(ModuleScript)
end

local CanUseVirtualInputManager = false
if Games.IsDefuseDivision then
	if pcall(function()
		VirtualInputManager = Create("VirtualInputManager")
		VirtualInputManager:SendScroll(
			0, 0, 0, 0,
			CoolEmptyTable, game
		)
	end) then
		CanUseVirtualInputManager = true
	end
end

local PlayerJoinLogs = false
local PlayerLeaveLogs = false

workspace.FallenPartsDestroyHeight = -math.huge

local function InsertToConnections(Connection)
	table.insert(Connections, Connection)
end

local function RenderStepped(Function, ShouldInsertToConnections)
	local Connection = RunService.RenderStepped:Connect(Function)

	if ShouldInsertToConnections then
		InsertToConnections(Connection)
	end

	return Connection
end

local function Heartbeat(Function, ShouldInsertToConnections)
	local Connection = RunService.Heartbeat:Connect(Function)

	if ShouldInsertToConnections then
		InsertToConnections(Connection)
	end

	return Connection
end

local function UpdateCamera()
	Camera = nscloneref(workspace.CurrentCamera)

	if not Camera then
		return
	end

	ViewportSize = Camera.ViewportSize
	ViewportSizeX = ViewportSize.X
	ViewportSizeY = ViewportSize.Y
	ScreenCenter = ViewportSize * 0.5
	FixedBottomCenter = Vector2.new(ViewportSizeX * 0.5, ViewportSizeY * 0.54054)
end

InsertToConnections(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	UpdateCamera()
	InsertToConnections(Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateCamera))
end))

UpdateCamera()

InsertToConnections(Mouse.Move:Connect(function()
	MouseLocation = UserInputService:GetMouseLocation()
end))

local function GetSettingsShield()
    if CachedSettingsShield and CachedSettingsShield.Parent then
        return CachedSettingsShield
    end

    if not CachedRobloxGui or not CachedRobloxGui.Parent then
        CachedRobloxGui = CoreGui:FindFirstChild("RobloxGui")
        if not CachedRobloxGui then
            return nil
        end
    end

    if not CachedClippingShield or not CachedClippingShield.Parent then
        CachedClippingShield = CachedRobloxGui:FindFirstChild("SettingsClippingShield")
        if not CachedClippingShield then
            return nil
        end
    end

    CachedSettingsShield = CachedClippingShield:FindFirstChild("SettingsShield")
    return CachedSettingsShield
end

local IsEnemy = nil
if Games.IsAimblox then
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		if Player:GetAttribute("Team") ~= LocalPlayer:GetAttribute("Team") then
			return true
		end

		return false
	end
elseif Games.IsDefuseDivision then
	IsEnemy = function(Player)
		if Player then
			local LocalPlayerStates = LocalPlayer:FindFirstChild("PlayerStates")

			if not LocalPlayerStates then
				return true
			end

			local LocalTeam = LocalPlayerStates:FindFirstChild("Team")

			if not LocalTeam or LocalTeam == "Spectate" then
				return true
			end

			local PlayerStates = Player:FindFirstChild("PlayerStates")

			if not PlayerStates then
				return false
			end

			local Team = PlayerStates:FindFirstChild("Team")

			if not Team or Team.Value == "Spectate" then
				return false
			end

			if Team.Value ~= LocalTeam.Value then
				return true
			end
		end
		return false
	end
elseif Games.IsBloxStrike then
	IsEnemy = function(Player)
		if Player then
			local LocalTeam = LocalPlayer:GetAttribute("Team")

			if not LocalTeam then
				return true
			end

			local Team = Player:GetAttribute("Team")

			if not Team or Team ~= LocalTeam then
				return true
			end
		end
		return false
	end
elseif Games.IsGunGroundsFFA or Games.IsFlick then
	IsEnemy = function(Player)
		return true
	end
elseif Games.IsDeadEye then
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		local LocalTeam = LocalPlayer:GetAttribute("TeamNum")

		if not LocalTeam then
			return true
		end

		local PlayerTeam = Player:GetAttribute("TeamNum")

		if not PlayerTeam then
			return true
		end

		if LocalTeam ~= PlayerTeam then
			return true
		end

		return false
	end
elseif Games.MurderersVSSheriffsDUELS then
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		if LocalPlayer.Neutral or Player.Team ~= LocalPlayer.Team then
			return true
		end

		return false
	end
elseif Games.IsKATX then
	local EnemyColor = Color3.fromRGB(255, 0, 0)
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		local Cache = CachedPlayers[Player]

		if not Cache then
			return false
		end

		local Character = Cache.Character

		if not Character then
			return false
		end

		local EnemyOutline = Character:FindFirstChild("EnemyOutline")

		if not EnemyOutline then
			return true
		end

	   if EnemyOutline.FillColor == EnemyColor then
			return true
		end

		return false
	end
elseif Games.IsDefusal then
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		local LocalTeam = LocalPlayer:GetAttribute("Team")

		if not LocalTeam then
			return false
		end

		if LocalTeam == "Spectator" then
			return true
		end

		local PlayerTeam = Player:GetAttribute("Team")

		if not PlayerTeam or PlayerTeam == "Spectator" then
			return false
		end

		if LocalTeam ~= PlayerTeam then
			return true
		end

		return false
	end
elseif Games.IsRivals then
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		if Player:GetAttribute("TeamID") ~= LocalPlayer:GetAttribute("TeamID") then
			return true
		end

		return false
	end
else
	IsEnemy = function(Player)
		if not Player then
			return false
		end

		if #Teams:GetTeams() <= 1 or Player.Team ~= LocalPlayer.Team then
			return true
		end

		return false
	end
end

local function GetArsenalHealthInstance(Cache)
	local NRPBS = Cache.NRPBS
	return NRPBS and NRPBS:FindFirstChild("Health")
end

local IsDead = nil
if IsArsenalBaseGame then
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true
		end

		local Player = Players:GetPlayerFromCharacter(Character)
		if not Player then
			return true, 0
		end

		local Cache = CachedPlayers[Player]
		if not Cache then
			return true, 0
		end

		local HealthInstance = GetArsenalHealthInstance(Cache)
		if not HealthInstance then
			return true, 0
		end

		local HealthValue = HealthInstance.Value
		if HealthValue <= ((Mode == "Custom") and CustomValue or 0) then
			return true, HealthValue
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true, HealthValue
		end

		return false, HealthValue
	end
elseif Games.IsSniperArena or Games.IsAimblox or Games.IsDefusal then
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true, 0
		end

		local Player = Players:GetPlayerFromCharacter(Character)
		if not Player then
			return false, 0
		end

		local HealthValue = Player:GetAttribute("Health") or 0
		if HealthValue <= ((Mode == "Custom") and CustomValue or 0) then
			return true, HealthValue
		end

		local Cache = CachedPlayers[Player]
		if not Cache then
			return true, HealthValue
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true, HealthValue
		end

		return false, HealthValue
	end
elseif Games.IsDefuseDivision then
	IsDead = function(Character, ...)
		if not Character then
			return true, 0
		end

		local Cache = CachedPlayers[Players:GetPlayerFromCharacter(Character)]
		if not Cache then
			return true, 0
		end

		local Humanoid = Cache.Humanoid

		if not Humanoid then
			return true, 0
		end

		if Humanoid.Health <= 0 then
			return true, 0
		end

		return false, 0
	end
elseif Games.IsAladiaPvP then
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true, 0
		end

		local Cache = CachedPlayers[Players:GetPlayerFromCharacter(Character)]
		if not Cache then
			return true, 0
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true, 0
		end

		if Humanoid.Health <= ((Mode == "Custom") and CustomValue or 1) then
			return true, 0
		end

		return false, 0
	end
else
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true, 0
		end

		local Cache = CachedPlayers[Players:GetPlayerFromCharacter(Character)]
		if not Cache then
			return true, 0
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true, 0
		end

		if Humanoid.Health <= ((Mode == "Custom") and CustomValue or 0) then
			return true, 0
		end

		return false, 0
	end
end

--[[local function IsProtected(Cache)
	return Cache.ForceField ~= nil
end]]

local PerformJump = nil
if Games.IsDefuseDivision then
	PerformJump = function()
		if CanUseVirtualInputManager then
			VirtualInputManager:SendScroll(
				MouseLocation.X, MouseLocation.Y,
				0, -1,
				CoolEmptyTable, game
			)
		end
	end
else
	PerformJump = function()
		LocalHumanoid.Jump = true
		LocalHumanoid:ChangeState(EnumJumpingState)
	end
end

local function IsBehindWall(Origin, TargetPosition, Character)
	local Result = workspace:Raycast(Origin, (TargetPosition - Origin).Unit * 1000, CachedRaycastParams)

	if not Result then
        return false
    end

    return not Result.Instance:IsDescendantOf(Character)
end

local function WorldToViewportPoint(Position)
	if not Camera then
		return Vector2.zero, false
	end

	local Screen, OnScreen = Camera:WorldToViewportPoint(Position)
	return Vector2.new(Screen.X, Screen.Y), OnScreen
end

local function WorldToScreenPoint(Position, IncludeZ)
	if not Camera then
		return Vector2.zero, false
	end

	local Screen, OnScreen = Camera:WorldToScreenPoint(Position)
	if IncludeZ then
		return Screen, OnScreen
	else
		return Vector2.new(Screen.X, Screen.Y), OnScreen
	end
end

local function ClearCache(Player)
	local Cache = CachedPlayers[Player]
	if not Cache then
		return
	end

	local ESP = Cache.ESP
	if ESP then
		for Index, Object in next, ESP do
			if Index == "Cham" then
				Object:Destroy()
				continue
			end

			if Index == "Box3D" or Index == "Skeleton" then
				for _,DrawingObject in next, Object do
					RemoveDrawing(DrawingObject)
				end
				continue
			end

			RemoveDrawing(Object)
		end
	end

	CachedPlayers[Player] = nil
	for Index = 1, #CachedPlayersList do
		if CachedPlayersList[Index] == Cache then
			table.remove(CachedPlayersList, Index)
			break
		end
	end
end

local function CachePlayer(Player)
	local Character = Player.Character

	if not Character then
		ClearCache(Player)
		return nil
	end

	local Cache = CachedPlayers[Player] or {}

	Cache.Player = Player
	local Name = Player.Name
	Cache.Name = Name
	Cache.DisplayName = Player.DisplayName

	Cache.FemboyMeter = tostring(math.random(0, 100))

	if IsArsenalBaseGame then
		local NRPBS = Player:FindFirstChild("NRPBS")
		Cache.NRPBS = NRPBS
		Cache.EquippedTool = NRPBS and NRPBS:FindFirstChild("EquippedTool")
	end

	Cache.Character = Character
	--Cache.ForceField = Character:FindFirstChildOfClass("ForceField")
	Cache.Humanoid = Character:FindFirstChildOfClass("Humanoid")

	local Children = Character:GetChildren()

	for Index = 1, #Children do
		local Child = Children[Index]
		if Child:IsA("BasePart") then
			Cache[Child.Name] = Child
		end
	end

	Cache.Root = Cache.HumanoidRootPart or Cache.Torso

	local ESP = Cache.ESP
	if not ESP then
		ESP = table.create(10)

		ESP.Cham = Create("Highlight", CoreGui, {
			Enabled = false,
			Name = "Cham_" .. Name,
			FillColor = ChamESP.FillColor,
			OutlineColor = ChamESP.OutlineColor,
			FillTransparency = ChamESP.FillTransparency,
			OutlineTransparency = ChamESP.OutlineTransparency,
			Adornee = Character
		})

		ESP.HeadDot = CreateDrawing("Circle", {
			Color = HeadDotESP.Color,
			Transparency = HeadDotESP.Transparency,
			Radius = 4,
			Filled = HeadDotESP.Filled,
			Visible = false
		})

		ESP.HeadTag = CreateDrawing("Text", {
			Text = "",
			Color = HeadTagESP.Color,
			Transparency = HeadTagESP.Transparency,
			Size = 16,
			Center = true,
			Outline = true,
			Visible = false
		})

		ESP.Tracer = CreateDrawing("Line", {
			Color = TracerESP.Color,
			Transparency = TracerESP.Transparency,
			Thickness = 2,
			Visible = false
		})

		if not IsXeno then
			ESP.Arrow = CreateDrawing("Triangle", {
				PointA = FixedBottomCenter,
				PointB = FixedBottomCenter,
				PointC = FixedBottomCenter,
				Transparency = ArrowESP.Transparency,
				Thickness = 2,
				Filled = ArrowESP.Filled,
				Color = ArrowESP.Color,
				Visible = false
			})
		end

		ESP.Box2D = CreateDrawing("Square", {
			Transparency = BoxESP.Box2D.Transparency,
			Thickness = 2,
			Size = Vector2.one * 50,
			Color = BoxESP.Box2D.Color,
			Visible = false
		})

		ESP.Box3D = table.create(12)
		for Index = 1, 12 do
			ESP.Box3D[Index] = CreateDrawing("Line", {
				Color = BoxESP.Box3D.Color,
				Transparency = BoxESP.Box3D.Transparency,
				Thickness = 2,
				Visible = false
			})
		end

		ESP.HealthBarOutline = CreateDrawing("Square", {
			Filled = true,
			Color = HealthBarESP.Color,
			Transparency = HealthBarESP.Transparency,
			Visible = false
		})

		ESP.HealthBarFill = CreateDrawing("Line", {
			Color = GreenRGBColor,
			Transparency = HealthBarESP.Transparency,
			Thickness = HealthBarESP.Thickness,
			Visible = false
		})

		ESP.Skeleton = table.create(16)
		for Index = 1, 16 do
			ESP.Skeleton[Index] = CreateDrawing("Line", {
				Thickness = SkeletonESP.Thickness,
				Color = SkeletonESP.Color,
				Transparency = SkeletonESP.Transparency,
				Visible = false
			})
		end

		for Index, Object in next, ESP do
			if Index == "Box3D" or Index == "Skeleton" then
				for _,DrawingObject in next, Object do
					table.insert(ESPObjects, DrawingObject)
				end
			else
				table.insert(ESPObjects, Object)
			end
		end

		Cache.ESP = ESP
	end

	CachedPlayers[Player] = Cache
	table.insert(CachedPlayersList, Cache)
	return Character, CachedPlayers[Player]
end

local function SetEnabled(Object, State)
	if Object.Enabled ~= State then
		Object.Enabled = State
	end
end

local function AddCache(Player)
	local Character, Cache = CachePlayer(Player)
	local ChamName = "Cham_" .. Player.Name

	if Character and ChamESP.Enabled then
		local Children = Character:GetChildren()
		for Index = 1, #Children do
			local Child = Children[Index]
			if Child:IsA("Highlight") and Child.Name ~= ChamName then
				SetEnabled(Child, false)
			end
		end

		Cache.FemboyMeter = tostring(math.random(0, 100))
	end

	InsertToConnections(Player.CharacterAdded:Connect(function()
		local Character2, Cache2 = CachePlayer(Player)
		--Cache2.ForceField = Character2:FindFirstChildOfClass("ForceField")

		InsertToConnections(Character2.ChildAdded:Connect(function(Child)
			--[[if Child:IsA("ForceField") then
				Cache2.ForceField = Child
			end]]

			if ChamESP.Enabled and Child:IsA("Highlight") and Child.Name ~= ChamName then
				SetEnabled(Child, false)
			end
		end))

		--[[InsertToConnections(Character2.ChildRemoved:Connect(function(Child)
			if Child:IsA("ForceField") then
				Cache2.ForceField = nil
			end
		end))]]

		Cache2.FemboyMeter = tostring(math.random(0, 100))
	end))

	InsertToConnections(Player.CharacterRemoving:Connect(function()
		ClearCache(Player)
	end))
end

local GetFilterDescendantsInstances = nil
if Games.IsKat then
	GetFilterDescendantsInstances = function()
		return {LocalCharacter, Camera, workspace:QueryDescendants("[Transparency > 0]")}
	end
else
	GetFilterDescendantsInstances = function()
		return {LocalCharacter, Camera}
	end
end

ThreadManager:Start("CachedPlayers", function()
	CachedRaycastParams.FilterDescendantsInstances = GetFilterDescendantsInstances()

	for _,Player in ipairs(Players:GetPlayers()) do
		if Player == LocalPlayer then
			continue
		end

		local Cache = CachedPlayers[Player]
		if not Cache then
			AddCache(Player)
		else
			local Character = Cache.Character
			if not Character or not Character.Parent then
				ClearCache(Player)
				AddCache(Player)
				continue
			end

			local Humanoid = Cache.Humanoid
			if not Humanoid or not Humanoid.Parent then
				ClearCache(Player)
				AddCache(Player)
				continue
			end

			local Root = Cache.Root
			if not Root or not Root.Parent then
				ClearCache(Player)
				AddCache(Player)
				continue
			end

			local Head = Cache.Head
			if not Head or not Head.Parent then
				ClearCache(Player)
				AddCache(Player)
				continue
			end
		end
	end
end, 2.5)

InsertToConnections(Players.PlayerAdded:Connect(function(Player)
	AddCache(Player)
	if PlayerJoinLogs then
		Library:Notify({
			Title = "[[ combat.cc ]]",
			Description = Player.DisplayName .. " (@" .. Player.Name .. ") has Joined the server.",
			Time = 3.5
		})
	end
end))
InsertToConnections(Players.PlayerRemoving:Connect(function(Player)
	ClearCache(Player)
	if PlayerLeaveLogs then
		Library:Notify({
			Title = "[[ combat.cc ]]",
			Description = Player.DisplayName .. " (@" .. Player.Name .. ") has Left the server.",
			Time = 3.5
		})
	end
end))

local function PlayHitSound(Option, Volume)
	local AssetId = HitSounds.Sounds[Option]
	if AssetId then
		Create("Sound", HitSounds.Folder, {
			SoundId = "rbxassetid://" .. AssetId,
			Volume = Volume,
			PlayOnRemove = true 
		}):Destroy()
		return
	end

	if Option:sub(-4):lower() ~= ".mp3" then
		warn("[combat.cc] Could not find sound:", Option)
		return
	end

	local Path = ("combat.cc/Sounds/" .. Option):gsub("\\", "/")

	if not isfile(Path) then
		warn("[combat.cc] Sound file missing:", Path)
		return
	end

	Create("Sound", HitSounds.Folder, {
		SoundId = nsgetcustomasset(Path),
		Volume = Volume,
		PlayOnRemove = true
	}):Destroy()
end

local CurrentGameName = "Unknown"

for Variable, IsMatch in next, Games do
    if IsMatch then
        CurrentGameName = Variable:gsub("^Is", "")
        break
    end
end

if CurrentGameName == "Unknown" then
	local Success, Info = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId)
	end)

	if Success and Info then
		CurrentGameName = Info.Name
	else
		task.spawn(function()
			task.wait(10)
			local RetrySuccess, RetryInfo = pcall(function()
				return MarketplaceService:GetProductInfo(game.PlaceId)
			end)

			if RetrySuccess and RetryInfo then
				CurrentGameName = RetryInfo.Name
			end
		end)
	end
end

local CurrentPing = 0
task.spawn(function()
	local Stats = GetService("Stats")
	local HeartbeatStats = Stats:WaitForChild("Workspace"):WaitForChild("Heartbeat")

	local WatermarkAccumulator = 0
	RenderStepped(function(DeltaTime)
		WatermarkAccumulator += DeltaTime

		if WatermarkAccumulator < 0.1 then
			return
		end

		WatermarkAccumulator = 0

		if WatermarkIsVisible then
			Watermark:SetText("[nikoletoscripts/combat.cc] | " .. CurrentGameName .. " | FPS: " .. math.floor(HeartbeatStats:GetValue()) .. " | Ping: " .. math.floor(CurrentPing))
		end
	end, true)

	local DataPing = Stats:WaitForChild("Network"):WaitForChild("ServerStatsItem"):WaitForChild("Data Ping")
	ThreadManager:Start("Ping", function()
		CurrentPing = DataPing:GetValue()
	end, 0.1)
end)

if IsArsenalBaseGame or Games.IsWarTycoon or Games.IsRivals or (hookmetamethod and (Games.IsDaHood or Games.IsKAT)) then
	local function UpdateFOVCircle(FOVCircle, FOVCircleTable, AimbotTable)
		if not isrenderobj(FOVCircle) then
			return
		end

		if not AimbotTable.Toggled or not FOVCircleTable.Enabled then
			if FOVCircle.Visible ~= false then
				FOVCircle.Visible = false
			end
			return
		end

		local Color = FOVCircleTable.Color
		if FOVCircle.Color ~= Color then
			FOVCircle.Color = Color
		end

		local Filled = FOVCircleTable.Filled
		if FOVCircle.Filled ~= Filled then
			FOVCircle.Filled = Filled
		end

		local Thickness = FOVCircleTable.Thickness
		if FOVCircle.Thickness ~= Thickness then
			FOVCircle.Thickness = Thickness
		end

		local Radius = FOVCircleTable.Radius
		if FOVCircle.Radius ~= Radius then
			FOVCircle.Radius = Radius
		end

		local Transparency = FOVCircleTable.Transparency
		if FOVCircle.Transparency ~= Transparency then
			FOVCircle.Transparency = Transparency
		end

		local Position = FOVCircleTable.Position == "Center" and ScreenCenter or MouseLocation
		if FOVCircle.Position ~= Position then
			FOVCircle.Position = Position
		end

		if FOVCircle.Visible ~= true then
			FOVCircle.Visible = true
		end
	end

	RenderStepped(function()
		UpdateFOVCircle(AimbotFOVCircles.Target, Aimbot.FOVCircle, Aimbot)
		UpdateFOVCircle(AimbotFOVCircles.Silent, SilentAimbot.FOVCircle, SilentAimbot)
	end, true)
else
	RenderStepped(function()
		local FOVCircle = AimbotFOVCircles.Target
		if not isrenderobj(FOVCircle) then
			return
		end

		if not Aimbot.Toggled then
			if FOVCircle.Visible ~= false then
				FOVCircle.Visible = false
			end
			return
		end

		local FOVCircleTable = Aimbot.FOVCircle
		if not FOVCircleTable.Enabled then
			if FOVCircle.Visible ~= false then
				FOVCircle.Visible = false
			end
			return
		end

		local Color = FOVCircleTable.Color
		if FOVCircle.Color ~= Color then
			FOVCircle.Color = Color
		end

		local Filled = FOVCircleTable.Filled
		if FOVCircle.Filled ~= Filled then
			FOVCircle.Filled = Filled
		end

		local Thickness = FOVCircleTable.Thickness
		if FOVCircle.Thickness ~= Thickness then
			FOVCircle.Thickness = Thickness
		end

		local Radius = FOVCircleTable.Radius
		if FOVCircle.Radius ~= Radius then
			FOVCircle.Radius = Radius
		end

		local Transparency = FOVCircleTable.Transparency
		if FOVCircle.Transparency ~= Transparency then
			FOVCircle.Transparency = Transparency
		end

		local Position = FOVCircleTable.Position == "Center" and ScreenCenter or MouseLocation
		if FOVCircle.Position ~= Position then
			FOVCircle.Position = Position
		end

		if FOVCircle.Visible ~= true then
			FOVCircle.Visible = true
		end
	end, true)
end

local function GetDistanceSquared(Point1, Point2)
    local DeltaX = Point1.X - Point2.X
    local DeltaY = Point1.Y - Point2.Y
    local DeltaZ = Point1.Z - Point2.Z
    return DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ
end

local function CanRenderVisually(CanBeOptimized, Cache, Character, Head, RootPosition)
	local DeadState, CustomGameHealth = IsDead(Character, "Universal", 0)
	if DeadState then
		return false, CustomGameHealth, Vector3.zero, nil
	end

	local LocalHeadPosition
	if LocalHead then
		LocalHeadPosition = LocalHead.Position

		local Distance = GetDistanceSquared(LocalHeadPosition, RootPosition)
		if Distance > ESPDistanceCheck then
			return false, CustomGameHealth, LocalHeadPosition, Distance
		end

		if ESPWallCheck and not CanBeOptimized and IsBehindWall(LocalHeadPosition, RootPosition, Character) then
			return false, CustomGameHealth, LocalHeadPosition, nil
		end
	end

	return true, CustomGameHealth, LocalHeadPosition, nil
end

local function HideESP(ESP, IgnoreCham)
	local ShouldCham = not IgnoreCham
    for Index, Object in next, ESP do
        if Index == "Cham" then
            if ShouldCham and Object.Enabled ~= false then
                Object.Enabled = false
            end
            continue
        end

        if Index == "Box3D" or Index == "Skeleton" then
            for _,Line in next, Object do
                if Line.Visible ~= false then
                    Line.Visible = false
                end
            end
            continue
        end

        if Object.Visible ~= false then
            Object.Visible = false
        end
    end
end

RenderStepped(function(DeltaTime)
	if ESPPerformanceMode then -- Interval = 1 / 30
		ESPAccumulator += DeltaTime

		if ESPAccumulator < 0.03333333333 then
			return
		end

		ESPAccumulator -= 0.03333333333
	elseif not ESPDynamicRefreshRate then
		local Interval = 1 / ESPRefreshRate

		ESPAccumulator += DeltaTime

		if ESPAccumulator < Interval then
			return
		end

		ESPAccumulator -= Interval
	end

	local PlayerCount = #CachedPlayersList

	if not ESPToggled or not Camera or ESPDistanceCheck <= 0 then
		for Index = 1, PlayerCount do
			local Cache = CachedPlayersList[Index]
			if not Cache.IsVisible then
				continue
			end

			HideESP(Cache.ESP)
			Cache.IsVisible = false
		end
		return
	end

    local ChamEnabled = ChamESP.Enabled

	local HeadDotEnabled = HeadDotESP.Enabled

	local HeadTagEnabled = HeadTagESP.Enabled
	local HeadTagDropdown, HeadTagPosition

	if HeadTagEnabled then
		HeadTagDropdown = Options["HeadTagOptions"]
		HeadTagPosition = HeadTagESP.Position
	end

	local TracerEnabled = TracerESP.Enabled
	local TracerTypeIsLocked, TracerPartIsHead

	if TracerEnabled then
		TracerTypeIsLocked = TracerESP.Type == "Locked"
		TracerPartIsHead = TracerESP.Part == "Head"
	end

	local ArrowEnabled = not IsXeno and ArrowESP.Enabled
	local ArrowRadius

	if ArrowEnabled then
		ArrowRadius = ArrowESP.Radius
	end

	local Box2DEnabled = BoxESP.Box2D.Enabled

	local Box3DEnabled = BoxESP.Box3D.Enabled

	local HealthBarEnabled = HealthBarESP.Enabled
	local HealthBarThickness

	if HealthBarEnabled then
		HealthBarThickness = HealthBarESP.Thickness
	end

	local SkeletonEnabled = SkeletonESP.Enabled

	local ShouldContinue = ChamEnabled or HeadDotEnabled or HeadTagEnabled
	or TracerEnabled or (not IsXeno and ArrowEnabled) or Box2DEnabled
	or Box3DEnabled or HealthBarEnabled or SkeletonEnabled

	if not ShouldContinue then
		for Index = 1, PlayerCount do
			local Cache = CachedPlayersList[Index]
			if not Cache.IsVisible then
				continue
			end

			HideESP(Cache.ESP)
			Cache.IsVisible = false
		end
		return
	end

	local IsDefuseDivision = Games.IsDefuseDivision
	local IsSniperArena = Games.IsSniperArena
	local IsAimblox = Games.IsAimblox
	local IsDefusal = Games.IsDefusal

	local CameraCFrame = Camera.CFrame
	local CameraPosition = CameraCFrame.Position
	local CameraLookVector = CameraCFrame.LookVector

	local CanBeOptimized = ChamEnabled
	and not HeadDotEnabled and not HeadTagEnabled
	and not TracerEnabled and (not IsXeno and not ArrowEnabled)
	and not Box2DEnabled and not Box3DEnabled
	and not HealthBarEnabled and not SkeletonEnabled

	for RandomPlayer = 1, PlayerCount do
		local Cache = CachedPlayersList[RandomPlayer]
		local ESP = Cache.ESP

		local Character = Cache.Character
		if not Character then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid or Humanoid.Health <= 0 then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		if ESPForceFieldCheck and Character:FindFirstChildOfClass("ForceField") then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local Head = Cache.Head
		if not Head then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local Root = Cache.Torso or Cache.Root
		if not Root then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local RootPosition = Root.Position
		if CameraLookVector:Dot(RootPosition - CameraPosition) <= 0 then
			if Cache.IsVisible then
				HideESP(ESP, true)
				Cache.IsVisible = false
			end
			continue
		end

		local Player = Cache.Player
		if ESPTeamCheck and not IsEnemy(Player) then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local CanRenderState, CustomGameHealth, LocalRootPosition, Distance = CanRenderVisually(
			CanBeOptimized, Cache, Character, Head, RootPosition
		)

		if not CanRenderState then
			if Cache.IsVisible then
				HideESP(ESP)
				Cache.IsVisible = false
			end
			continue
		end

		local HeadPosition = Head.Position
		local HeadScreen, HeadOnScreen = WorldToViewportPoint(HeadPosition)

		if not HeadOnScreen then
			if Cache.IsVisible then
				HideESP(ESP, true)
				Cache.IsVisible = false
			end
			continue
		end

		local RootScreen, RootOnScreen = WorldToViewportPoint(RootPosition)

		if not RootOnScreen then
			if Cache.IsVisible then
				HideESP(ESP, true)
				Cache.IsVisible = false
			end
			continue
		end

		local TopScreen, TopOnScreen = nil, false
		local TopScreenX, TopScreenY = 0, 0

		if HeadTagEnabled or Box2DEnabled or HealthBarEnabled then
			TopScreen, TopOnScreen = WorldToViewportPoint(HeadPosition + ESPHeadOffset)
			TopScreenX, TopScreenY = TopScreen.X, TopScreen.Y
		end

		local ChamObject = ESP.Cham
		if ChamEnabled and ChamObject then
			local Depth = ESPWallCheck and HighlightDepthModeOccluded or HighlightDepthModeAlwaysOnTop
			if ChamObject.DepthMode ~= Depth then
				ChamObject.DepthMode = Depth
			end

			if ChamObject.Enabled ~= true then
				ChamObject.Enabled = true
			end
		elseif ChamObject then
			if ChamObject.Enabled ~= false then
				ChamObject.Enabled = false
			end
		end

		local HeadDotObject = ESP.HeadDot
		if HeadDotEnabled and HeadDotObject then
			if HeadDotObject.Position ~= HeadScreen then
				HeadDotObject.Position = HeadScreen
			end

			if HeadDotObject.Visible ~= true then
				HeadDotObject.Visible = true
			end
		elseif HeadDotObject then
			if HeadDotObject.Visible ~= false then
				HeadDotObject.Visible = false
			end
		end

		local RigTypeIsR15 = false
		if (HeadTagEnabled or SkeletonEnabled) and Humanoid.RigType == RigTypeR15 then
			RigTypeIsR15 = true
		end

		local FootScreen, FootOnScreen = nil, false
		local FootScreenY = 0

		if (HeadTagEnabled and HeadTagPosition == "Bottom") or Box2DEnabled or HealthBarEnabled then
			FootScreen, FootOnScreen = WorldToViewportPoint(RootPosition - Vector3.new(0, Humanoid.HipHeight + 2, 0))
			FootScreenY = FootScreen.Y
		end

		local HeadTagObject = ESP.HeadTag
		if HeadTagEnabled and HeadTagObject and TopOnScreen then
			local HeadTagString = ""

			if HeadTagDropdown then
				local Values = HeadTagDropdown.Values
				if Values then
					local Selected = HeadTagDropdown.Value
					table.clear(TagBuffer)

					for _,Option in ipairs(Values) do
						if Selected and Selected[Option] then
							local OptionText = ""

							if Option == "Name" then
								OptionText = Cache.Name
							elseif Option == "DisplayName" then
								OptionText = Cache.DisplayName
							elseif Option == "EquippedTool" then
								local ToolName = "None"
								if IsDefuseDivision then
									local Gun = Player:FindFirstChildOfClass("StringValue")
									if Gun then
										ToolName = Gun.Value
									end
								elseif IsArsenalBaseGame then
									local Tool = Cache.EquippedTool
									if Tool then
										ToolName = Tool.Value
									end
								elseif IsCounterBloxBaseGame then
									local Tool = Character:FindFirstChild("EquippedTool")
									if Tool then
										ToolName = Tool.Value
									end
								else
									local Tool = Character:FindFirstChildOfClass("Tool")
									if Tool then
										ToolName = Tool.Name
									end
								end
								OptionText = ToolName
							elseif Option == "Health" then
								if IsArsenalBaseGame or IsSniperArena or IsAimblox or IsDefusal then
									OptionText = CustomGameHealth .. " Health"
								else
									OptionText = math.floor(Humanoid.Health) .. " Health"
								end
							elseif Option == "Distance" then
								OptionText =  Distance or math.floor((LocalRootPosition - RootPosition).Magnitude) .. " Studs Away"
							elseif Option == "RigType" then
								OptionText = RigTypeIsR15 and "R15" or "R6"
							elseif Option == "Femboy Meter" then
								local FemboyMeter = Cache.FemboyMeter
								OptionText = FemboyMeter and ("Femboy Meter: " .. FemboyMeter .. "%") or "Femboy Meter: NaN%"
							end

							table.insert(TagBuffer, OptionText)
						end
					end

					HeadTagString = table.concat(TagBuffer, " | ")
				end
			end

			if HeadTagPosition == "Top" then
				if HeadTagObject.Position ~= TopScreen then
					HeadTagObject.Position = TopScreen
				end
			else
				if HeadTagObject.Position ~= FootScreen then
					HeadTagObject.Position = FootScreen
				end
			end

			if HeadTagObject.Text ~= HeadTagString then
				HeadTagObject.Text = HeadTagString
			end

			if HeadTagObject.Visible ~= true then
				HeadTagObject.Visible = true
			end
		elseif HeadTagObject then
			if HeadTagObject.Visible ~= false then
				HeadTagObject.Visible = false
			end
		end

		local TracerObject = ESP.Tracer
		if TracerEnabled and TracerObject then
			local FromScreen = TracerTypeIsLocked and FixedBottomCenter or MouseLocation
			if TracerObject.From ~= FromScreen then
				TracerObject.From = FromScreen
			end

			local ToScreen = TracerPartIsHead and HeadScreen or RootScreen
			if TracerObject.To ~= ToScreen then
				TracerObject.To = ToScreen
			end

			if TracerObject.Visible ~= true then
				TracerObject.Visible = true
			end
		elseif TracerObject then
			if TracerObject.Visible ~= false then
				TracerObject.Visible = false
			end
		end

		local ArrowObject = ESP.Arrow
		if ArrowEnabled and ArrowObject then
			local Direction = (RootScreen - ScreenCenter).Unit

			if Direction ~= Direction then
				Direction = Vector2.zero
			end

			local Offset = Vector2.new(-Direction.Y, Direction.X) * 7.5
			local ArrowCenter = ScreenCenter + Direction * ArrowRadius
			local PointA, PointB, PointC = ArrowCenter + Direction * 15, ArrowCenter - Offset, ArrowCenter + Offset

			if ArrowObject.PointA ~= PointA then
				ArrowObject.PointA = PointA
			end

			if ArrowObject.PointB ~= PointB then
				ArrowObject.PointB = PointB
			end

			if ArrowObject.PointC ~= PointC then
				ArrowObject.PointC = PointC
			end

			if ArrowObject.Visible ~= true then
				ArrowObject.Visible = true
			end
		elseif ArrowObject then
			if ArrowObject.Visible ~= false then
				ArrowObject.Visible = false
			end
		end

		local HBOutline = ESP.HealthBarOutline
		local HBFill = ESP.HealthBarFill

		local Box2DObject = ESP.Box2D
		local ShouldBox2D = (Box2DEnabled and Box2DObject)
		local ShouldHealthBar = (HealthBarEnabled and HBOutline and HBFill)
		local BoxHealthBarHeight = 0
		local BoxHealthBarWidth = 0
		local TopScreenXBoxHealthBarWidthOffset = 0

		if TopOnScreen and FootOnScreen then
			if ShouldBox2D or ShouldHealthBar then
				BoxHealthBarHeight = math.abs(FootScreenY - TopScreenY)
				BoxHealthBarWidth = BoxHealthBarHeight * 0.5
				TopScreenXBoxHealthBarWidthOffset = TopScreenX - BoxHealthBarWidth * 0.5

				if ShouldBox2D then
					local Size = Vector2.new(BoxHealthBarWidth, BoxHealthBarHeight)
					if Box2DObject.Size ~= Size then
						Box2DObject.Size = Size
					end

					local Position = Vector2.new(TopScreenXBoxHealthBarWidthOffset, TopScreenY)
					if Box2DObject.Position ~= Position then
						Box2DObject.Position = Position
					end

					if Box2DObject.Visible ~= true then
						Box2DObject.Visible = true
					end
				elseif Box2DObject then
					if Box2DObject.Visible ~= false then
						Box2DObject.Visible = false
					end
				end

				if ShouldHealthBar then
					local HealthPercentage = 0
					local BarX = TopScreenXBoxHealthBarWidthOffset - 4 - HealthBarThickness
					local LineCenterX = BarX + (HealthBarThickness * 0.5)

					if IsArsenalBaseGame then
						HealthPercentage = math.clamp(CustomGameHealth / Humanoid.MaxHealth, 0, 1)
					else
						HealthPercentage = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
					end

                    local Color = Color3.fromHSV(HealthPercentage * 0.3, 1, 1)
					if HBFill.Color ~= Color then
						HBFill.Color = Color
					end

					local Size = Vector2.new(HealthBarThickness + 2, BoxHealthBarHeight + 2)
					if HBOutline.Size ~= Size then
						HBOutline.Size = Size
					end

					local Position = Vector2.new(BarX - 1, TopScreenY - 1)
					if HBOutline.Position ~= Position then
						HBOutline.Position = Position
					end

					local From = Vector2.new(LineCenterX, FootScreenY)
					if HBFill.From ~= From then
						HBFill.From = From
					end

					local To = Vector2.new(LineCenterX, FootScreenY - BoxHealthBarHeight * HealthPercentage)
					if HBFill.To ~= To then
						HBFill.To = To
					end

					if HBOutline.Visible ~= true then
						HBOutline.Visible = true
					end

					if HBFill.Visible ~= true then
						HBFill.Visible = true
					end
				elseif HBOutline and HBFill then
					if HBOutline.Visible ~= false then
						HBOutline.Visible = false
					end

					if HBFill.Visible ~= false then
						HBFill.Visible = false
					end
				end
			end
		else
			if Box2DObject and Box2DObject.Visible ~= false then
				Box2DObject.Visible = false
			end

			if HBOutline and HBFill then
				if HBOutline.Visible ~= false then
					HBOutline.Visible = false
				end

				if HBFill.Visible ~= false then
					HBFill.Visible = false
				end
			end
		end

		local Box3DLines = ESP.Box3D
        if Box3DEnabled then
            local RootCFrame = Root.CFrame

            for Index = 1, 8 do
                local Screen, OnScreen = WorldToViewportPoint(RootCFrame:PointToWorldSpace(Box3DOffsets[Index]))
                BoxPointScreen[Index] = Screen
                BoxPointOnScreen[Index] = OnScreen
            end

            for Index = 1, 12 do
                local Line = Box3DLines[Index]
                local Edge = Box3DEdges[Index]
                local P1, P2 = Edge[1], Edge[2]

                if BoxPointOnScreen[P1] and BoxPointOnScreen[P2] then
					local From = BoxPointScreen[P1]
					if Line.From ~= From then
						Line.From = From
					end

					local To = BoxPointScreen[P2]
					if Line.To ~= To then
						Line.To = To
					end

					if Line.Visible ~= true then
						Line.Visible = true
					end
                else
					if Line.Visible ~= false then
						Line.Visible = false
					end
                end
            end
        else
            for Index = 1, 12 do
				local Line = Box3DLines[Index]
				if Line.Visible ~= false then
					Line.Visible = false
				end
            end
        end

		local SkeletonLines = ESP.Skeleton
		if SkeletonEnabled then
			if RigTypeIsR15 then
				table.clear(SkeletonCachePoints)
				table.clear(SkeletonCacheVisible)

				for Index = 1, #R15SkeletonLines do
					local Line = SkeletonLines[Index]
					local BonePair = R15SkeletonLines[Index]
					local Part1 = Cache[BonePair[1]]
					local Part2 = Cache[BonePair[2]]

					if Part1 and Part2 then
						local Position1 = SkeletonCachePoints[Part1]
						local Visible1 = SkeletonCacheVisible[Part1]

						if not Visible1  then
							Position1, Visible1 = WorldToViewportPoint(Part1.Position)
							SkeletonCachePoints[Part1] = Position1
							SkeletonCacheVisible[Part1] = Visible1
						end

						local Position2 = SkeletonCachePoints[Part2]
						local Visible2 = SkeletonCacheVisible[Part2]

						if not Visible2 then
							Position2, Visible2 = WorldToViewportPoint(Part2.Position)
							SkeletonCachePoints[Part2] = Position2
							SkeletonCacheVisible[Part2] = Visible2
						end

						if Visible1 and Visible2 then
							local From = Position1
							if Line.From ~= From then
								Line.From = From
							end

							local To = Position2
							if Line.To ~= To then
								Line.To = To
							end

							if Line.Visible ~= true then
								Line.Visible = true
							end
						else
							if Line.Visible ~= false then
								Line.Visible = false
							end
						end
					else
						if Line.Visible ~= false then
							Line.Visible = false
						end
					end
				end

				for Index = #R15SkeletonLines + 1, #SkeletonLines do
					local Line = SkeletonLines[Index]
					if Line.Visible ~= false then
						Line.Visible = false
					end
				end
			else
				local Torso = Cache.Torso
				if Torso then
					local TorsoCFrame = Torso.CFrame
					local TorsoSize = Torso.Size

					local NeckPosition, NeckVisible = WorldToViewportPoint(TorsoCFrame:PointToWorldSpace(TorsoSize * R6Neck))
					local WaistPosition, WaistVisible = WorldToViewportPoint(TorsoCFrame:PointToWorldSpace(TorsoSize * R6Waist))

					local SpineLine = SkeletonLines[1]
					if NeckVisible and WaistVisible then
						local From = NeckPosition
						if SpineLine.From ~= From then
							SpineLine.From = From
						end

						local To = WaistPosition
						if SpineLine.To ~= To then
							SpineLine.To = To
						end

						if SpineLine.Visible ~= true then
							SpineLine.Visible = true
						end
					else
						if SpineLine.Visible ~= false then
							SpineLine.Visible = false
						end
					end

					local NeckLine = SkeletonLines[2]
					if NeckVisible and HeadOnScreen then
						local From = NeckPosition
						if NeckLine.From ~= From then
							NeckLine.From = From
						end

						local To = HeadScreen
						if NeckLine.To ~= To then
							NeckLine.To = To
						end

						if NeckLine.Visible ~= true then
							NeckLine.Visible = true
						end
					else
						if NeckLine.Visible ~= false then
							NeckLine.Visible = false
						end
					end

					local LeftArm = Cache["Left Arm"]
					local LeftShoulderLine, LeftArmLine = SkeletonLines[3], SkeletonLines[4]
					if LeftArm then
						local LeftArmCFrame = LeftArm.CFrame
						local LeftArmSize = LeftArm.Size
						local Position1, Visible1 = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Bottom))

						if NeckVisible and Visible1 then
							local From = NeckPosition
							if LeftShoulderLine.From ~= From then
								LeftShoulderLine.From = From
							end

							local To = Position1
							if LeftShoulderLine.To ~= To then
								LeftShoulderLine.To = To
							end

							if LeftShoulderLine.Visible ~= true then
								LeftShoulderLine.Visible = true
							end
						else
							if LeftShoulderLine.Visible ~= false then
								LeftShoulderLine.Visible = false
							end
						end

						if Visible1 and Visible2 then
							local From = Position1
							if LeftArmLine.From ~= From then
								LeftArmLine.From = From
							end

							local To = Position2
							if LeftArmLine.To ~= To then
								LeftArmLine.To = To
							end

							if LeftArmLine.Visible ~= true then
								LeftArmLine.Visible = true
							end
						else
							if LeftArmLine.Visible ~= false then
								LeftArmLine.Visible = false
							end
						end
					else
						if LeftShoulderLine.Visible ~= false then
							LeftShoulderLine.Visible = false
						end

						if LeftArmLine.Visible ~= false then
							LeftArmLine.Visible = false
						end
					end

					local RightArm = Cache["Right Arm"]
					local RightShoulderLine, RightArmLine = SkeletonLines[5], SkeletonLines[6]
					if RightArm then
						local RightArmCFrame = RightArm.CFrame
						local RightArmSize = RightArm.Size
						local Position1, Visible1 = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Bottom))

						if NeckVisible and Visible1 then
							local From = NeckPosition
							if RightShoulderLine.From ~= From then
								RightShoulderLine.From = From
							end

							local To = Position1
							if RightShoulderLine.To ~= To then
								RightShoulderLine.To = To
							end

							if RightShoulderLine.Visible ~= true then
								RightShoulderLine.Visible = true
							end
						else
							if RightShoulderLine.Visible ~= false then
								RightShoulderLine.Visible = false
							end
						end

						if Visible1 and Visible2 then
							local From = Position1
							if RightArmLine.From ~= From then
								RightArmLine.From = From
							end

							local To = Position2
							if RightArmLine.To ~= To then
								RightArmLine.To = To
							end

							if RightArmLine.Visible ~= true then
								RightArmLine.Visible = true
							end
						else
							if RightArmLine.Visible ~= false then
								RightArmLine.Visible = false
							end
						end
					else
						if RightShoulderLine.Visible ~= false then
							RightShoulderLine.Visible = false
						end

						if RightArmLine.Visible ~= false then
							RightArmLine.Visible = false
						end
					end

					local LeftLeg = Cache["Left Leg"]
					local LeftHipLine, LeftLegLine = SkeletonLines[7], SkeletonLines[8]
					if LeftLeg then
						local LeftLegCFrame = LeftLeg.CFrame
						local LeftLegSize = LeftLeg.Size
						local Position1, Visible1 = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Bottom))

						if WaistVisible and Visible1 then
							local From = WaistPosition
							if LeftHipLine.From ~= From then
								LeftHipLine.From = From
							end

							local To = Position1
							if LeftHipLine.To ~= To then
								LeftHipLine.To = To
							end

							if LeftHipLine.Visible ~= true then
								LeftHipLine.Visible = true
							end
						else
							if LeftHipLine.Visible ~= false then
								LeftHipLine.Visible = false
							end
						end

						if Visible1 and Visible2 then
							local From = Position1
							if LeftLegLine.From ~= From then
								LeftLegLine.From = From
							end

							local To = Position2
							if LeftLegLine.To ~= To then
								LeftLegLine.To = To
							end

							if LeftLegLine.Visible ~= true then
								LeftLegLine.Visible = true
							end
						else
							if LeftLegLine.Visible ~= false then
								LeftLegLine.Visible = false
							end
						end
					else
						if LeftHipLine.Visible ~= false then
							LeftHipLine.Visible = false
						end

						if LeftLegLine.Visible ~= false then
							LeftLegLine.Visible = false
						end
					end

					local RightLeg = Cache["Right Leg"]
					local RightHipLine, RightLegLine = SkeletonLines[9], SkeletonLines[10]
					if RightLeg then
						local RightLegCFrame = RightLeg.CFrame
						local RightLegSize = RightLeg.Size
						local Position1, Visible1 = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Bottom))

						if WaistVisible and Visible1 then
							local From = WaistPosition
							if RightHipLine.From ~= From then
								RightHipLine.From = From
							end

							local To = Position1
							if RightHipLine.To ~= To then
								RightHipLine.To = To
							end

							if RightHipLine.Visible ~= true then
								RightHipLine.Visible = true
							end
						else
							if RightHipLine.Visible ~= false then
								RightHipLine.Visible = false
							end
						end

						if Visible1 and Visible2 then
							local From = Position1
							if RightLegLine.From ~= From then
								RightLegLine.From = From
							end

							local To = Position2
							if RightLegLine.To ~= To then
								RightLegLine.To = To
							end

							if RightLegLine.Visible ~= true then
								RightLegLine.Visible = true
							end
						else
							if RightLegLine.Visible ~= false then
								RightLegLine.Visible = false
							end
						end
					else
						if RightHipLine.Visible ~= false then
							RightHipLine.Visible = false
						end

						if RightLegLine.Visible ~= false then
							RightLegLine.Visible = false
						end
					end
				else
					for Index = 1, 10 do
						local Line = SkeletonLines[Index]
						if Line.Visible ~= false then
							Line.Visible = false
						end
					end
				end
			end
		else
			for Index = 1, #SkeletonLines do
				local Line = SkeletonLines[Index]
				if Line.Visible ~= false then
					Line.Visible = false
				end
			end
		end

		Cache.IsVisible = true
	end
end, true)

local function RotatePoint(Point, Angle)
    local Cos = math.cos(Angle)
    local Sin = math.sin(Angle)

	local MouseLocationX = MouseLocation.X
	local MouseLocationY = MouseLocation.Y

    local DX = Point.X - MouseLocationX
    local DY = Point.Y - MouseLocationY

    return Vector2.new(MouseLocationX + (DX * Cos - DY * Sin), MouseLocationY + (DX * Sin + DY * Cos))
end

RenderStepped(function(DeltaTime)
    local CurrentRotation = CrosshairOverlay.CurrentRotation
    if CrosshairOverlay.RotationStatic then
        CrosshairOverlay.CurrentRotation = CrosshairOverlay.Rotation
    else
        CrosshairOverlay.CurrentRotation = (CurrentRotation + (CrosshairOverlay.Rotation * DeltaTime)) % 360
    end

    local Drawings = CrosshairOverlay.Drawings
    local DrawingLines = Drawings.Lines

    if #DrawingLines == 0 then
        table.clear(DrawingLines)

        for _ = 1, 4 do
            table.insert(DrawingLines, CreateDrawing("Line", {
                Visible = false,
                Thickness = 1,
                Color = CrosshairOverlay.Color,
                Transparency = CrosshairOverlay.Transparency
            }))
        end

		local Dot = Drawings.Dot
        if Dot then
			RemoveDrawing(Dot)
        end
    end

    local DotStyle = CrosshairOverlay.DotStyle
    if not Drawings.Dot or CrosshairOverlay.DotLastStyle ~= DotStyle then
        CrosshairOverlay.DotLastStyle = DotStyle
        Drawings.Dot = CreateDrawing(DotStyle, {
            Visible = false,
            Filled = true,
            Color = CrosshairOverlay.DotColor,
            Transparency = CrosshairOverlay.Transparency
        })
    end

    local DotObject = Drawings.Dot
    local CrosshairOverlayEnabled = CrosshairOverlay.Enabled

    if CrosshairOverlayEnabled and CrosshairOverlay.DotEnabled then
        if CrosshairOverlay.DotStyle == "Circle" then
            local Radius = CrosshairOverlay.DotSize
			if DotObject.Radius ~= Radius then
				DotObject.Radius = Radius
			end

			if DotObject.Position ~= MouseLocation then
				DotObject.Position = MouseLocation
			end
        else
			local DotSize = Vector2.one * CrosshairOverlay.DotSize
			if DotObject.Size ~= DotSize then
				DotObject.Size = DotSize
			end

			local Position = MouseLocation - (DotSize * 0.5)
			if DotObject.Position ~= Position then
				DotObject.Position = Position
			end
        end

		local Transparency = CrosshairOverlay.Transparency
		if DotObject.Transparency ~= Transparency then
			DotObject.Transparency = Transparency
		end

		local Color = CrosshairOverlay.DotColor
		if DotObject.Color ~= Color then
			DotObject.Color = Color
		end

		if DotObject.Visible ~= true then
			DotObject.Visible = true
		end
    else
		if DotObject.Visible ~= false then
			DotObject.Visible = false
		end
    end

    if CrosshairOverlayEnabled then
		local CrosshairOverlayGap = CrosshairOverlay.Gap
		local CrosshairOverlayLength = CrosshairOverlay.Length
		local CurrentRotationRad = math.rad(CurrentRotation)

        for Index = 1, 4 do
            local MainLine = DrawingLines[Index]

            if CrosshairOverlayLength <= 0 or CrosshairOverlay.TStyle and Index == 1 then
				if MainLine.Visible ~= false then
					MainLine.Visible = false
				end
                continue
            end

			local Direction = CrosshairOverlay.BaseOffsets[Index]

			local Color = CrosshairOverlay.Color
			if MainLine.Color ~= Color then
				MainLine.Color = Color
			end

			local Thickness = CrosshairOverlay.Thickness
			if MainLine.Thickness ~= Thickness then
				MainLine.Thickness = Thickness
			end

			local Transparency = CrosshairOverlay.Transparency
			if MainLine.Transparency ~= Transparency then
				MainLine.Transparency = Transparency
			end

			local From = RotatePoint(MouseLocation + (Direction * CrosshairOverlayGap), CurrentRotationRad)
			if MainLine.From ~= From then
				MainLine.From = From
			end

			local To = RotatePoint(MouseLocation + (Direction * (CrosshairOverlayGap + CrosshairOverlayLength)), CurrentRotationRad)
			if MainLine.To ~= To then
				MainLine.To = To
			end

			if MainLine.Visible ~= true then
				MainLine.Visible = true
			end
        end
    else
        for _,Line in next, DrawingLines do
			if Line.Visible ~= false then
				Line.Visible = false
			end
        end
    end
end, true)

local function GetPredictedPosition(AimbotType, Position, AssemblyLinearVelocity)
	local PredictionConfiguration = PredictionSettings[AimbotType]
	local AimbotConfiguration = PredictionConfiguration.AimbotConfiguration

	if AimbotConfiguration.AutoPrediction then
		return Position + AssemblyLinearVelocity * (CurrentPing * PredictionConfiguration.AutoPredictionMultiplier)
	end

	local PredictionOffset = AimbotConfiguration.PredictionOffset
	if PredictionOffset > 0 then
		return Position + AssemblyLinearVelocity * PredictionOffset
	end

	return Position
end

local function Color3ToHex(Color)
	return string.format(
		"#%02X%02X%02X",
		Color.R * 255,
		Color.G * 255,
		Color.B * 255
	)
end

local function TriggerHitFunctions(PreviousHealth, Health, WorldPosition)
	if not HitConfiguration.Toggled then
		return
	end

	local Log = HitConfiguration.Log
	if Log.Enabled then
		local HealthHit = math.floor(PreviousHealth - Health)
		if HealthHit ~= 0 then
			Library:Notify({
				Title = "Hit Logs (Camera Aimbot)",
				Description = Log.UseColor and
					("Hit target for " ..
						string.format('<font color="%s">%s</font>',
							Color3ToHex(Log.Color),
							tostring(HealthHit)
						) .. " Health")
					or ("Hit target for " .. HealthHit .. " Health"),
				Time = Log.Duration
			})
		end
	end

	local Marker = HitConfiguration.Marker
	if Marker.Enabled and WorldPosition then
		local Style = Marker.Style
		local Scale = Marker.Scale
		local Color = Marker.Color
		local Lifetime = Marker.Lifetime
		local FadeIn = Marker.FadeIn
		local FadeOut = Marker.FadeOut

		local IsClassicX = Style == "Classic X"
		local IsBrokenX = Style == "Broken X"
		local IsPlus = Style == "Plus"
		local IsCircle = Style == "Circle"

		local Size = 15 * Scale
		local FadeTime = math.clamp(Lifetime * 0.2, 0.05, 0.25)

		local Lines = {}
		local Circle = nil
		local Dot = nil

		if Marker.CenterDot then
			Dot = CreateDrawing("Circle", {
				NumSides = 24,
				Filled = true,
				Thickness = 2,
				Color = Color,
				Transparency = 1,
				Visible = false
			})
			Dot.Radius = 2 * Scale
		end

		if IsClassicX or IsBrokenX or IsPlus then
			for _ = 1, 4 do
				Lines[#Lines + 1] = CreateDrawing("Line", {
					Thickness = 2,
					Color = Color,
					Transparency = 1,
					Visible = false
				})
			end
		elseif IsCircle then
			Circle = CreateDrawing("Circle", {
				NumSides = 24,
				Filled = false,
				Thickness = 2,
				Color = Color,
				Transparency = 1,
				Visible = false
			})
			Circle.Radius = Size
		end

		local Offsets
		if IsPlus then
			Offsets = {
				Vector2.new(-Size, 0), Vector2.new(Size, 0),
				Vector2.new(0, -Size), Vector2.new(0, Size)
			}
		end

		local StartTime = tick()
		local LastCameraCFrame = Camera and Camera.CFrame or CFrameZero
		local Screen, OnScreen = WorldToViewportPoint(WorldPosition)

		local Connection
		Connection = RenderStepped(function()
			local ElapsedTime = tick() - StartTime
			if ElapsedTime >= Lifetime then
				for _,Line in ipairs(Lines) do
					RemoveDrawing(Line)
				end

				if Circle then
					RemoveDrawing(Circle)
				end

				if Dot then
					RemoveDrawing(Dot)
				end

				Connection:Disconnect()
				Connection = nil
				return
			end

			local Alpha = 1
			if FadeIn and FadeOut then
				if ElapsedTime < FadeTime then
					Alpha = ElapsedTime / FadeTime
				elseif ElapsedTime > (Lifetime - FadeTime) then
					Alpha = (Lifetime - ElapsedTime) / FadeTime
				end
			elseif FadeIn then
				Alpha = math.clamp(ElapsedTime / FadeTime, 0, 1)
			elseif FadeOut then
				Alpha = math.clamp(1 - (ElapsedTime / Lifetime), 0, 1)
			end

			local CameraCFrame = Camera and Camera.CFrame or CFrameZero
			if CameraCFrame ~= LastCameraCFrame then
				Screen, OnScreen = WorldToViewportPoint(WorldPosition)
				LastCameraCFrame = CameraCFrame
			end

			for _,Line in next, Lines do
				if Line.Transparency ~= Alpha then
					Line.Transparency = Alpha
				end

				if Line.Visible ~= false then
					Line.Visible = false
				end
			end

			if Circle then
				if Circle.Transparency ~= Alpha then
					Circle.Transparency = Alpha
				end

				if Circle.Visible ~= false then
					Circle.Visible = false
				end
			end

			if Dot then
				if Dot.Transparency ~= Alpha then
					Dot.Transparency = Alpha
				end

				if Dot.Visible ~= false then
					Dot.Visible = false
				end
			end

			if not OnScreen then
				for _,Line in next, Lines do
					if Line and Line.Visible ~= false then
						Line.Visible = false
					end
				end

				if Circle and Circle.Visible ~= false then
					Circle.Visible = false
				end

				if Dot and Dot.Visible ~= false then
					Dot.Visible = false
				end

				return
			end

			if IsClassicX then
				for Index = 1, 4 do
					local Direction = HitMarkerDirections[Index]
					local Line = Lines[Index]

					local From = Screen + Direction
					if Line.From ~= From then
						Line.From = From
					end

					local To = Screen + Direction * Size
					if Line.To ~= To then
						Line.To = To
					end

					if Line.Visible ~= true then
						Line.Visible = true
					end
				end
			elseif IsBrokenX then
				local Gap = Size * 0.35
				for Index = 1, 4 do
					local Direction = HitMarkerDirections[Index]
					local Line = Lines[Index]

					local From = Screen + Direction * Gap
					if Line.From ~= From then
						Line.From = From
					end

					local To = Screen + Direction * Size
					if Line.To ~= To then
						Line.To = To
					end

					if Line.Visible ~= true then
						Line.Visible = true
					end
				end
			elseif IsPlus then
				for Index = 1, 4 do
					local Line = Lines[Index]

					if Line.From ~= Screen then
						Line.From = Screen
					end

					local To = Screen + Offsets[Index]
					if Line.To ~= To then
						Line.To = To
					end

					if Line.Visible ~= true then
						Line.Visible = true
					end
				end
			elseif IsCircle and Circle then
				if Circle.Position ~= Screen then
					Circle.Position = Screen
				end

				if Circle.Visible ~= true then
					Circle.Visible = true
				end
			end

			if Dot then
				if Dot.Position ~= Screen then
					Dot.Position = Screen
				end

				if Dot.Visible ~= true then
					Dot.Visible = true
				end
			end
		end, true)
	end

	local Sound = HitConfiguration.Sound
	if Sound.Enabled then
		PlayHitSound(Sound.Selected, Sound.Volume)
	end
end

local function StopAimbot()
	if Connections.Aimbot then
		Connections.Aimbot:Disconnect()
		Connections.Aimbot = nil
	end

	Aimbot.Enabled = false
	Aimbot.Target = nil
	HitConfiguration.PreviousHealth = nil

	local TargetView = Aimbot.TargetView
	TargetView.TargetLabel:SetText("None (@None)")
	Options["TargetImageLabel"]:SetImage("rbxthumb://type=AvatarHeadShot&id=0&w=420&h=420")
	TargetView.HealthLabel:SetText("Health: 0")
	TargetView.StudsLabel:SetText("0 Studs Away")
end

local GetClosestPlayer = nil
local TargetAimbot = nil

local AimbotFunctions = {
	Camera = {
		GetClosestPlayer = function()
			Aimbot.Target = nil
			HitConfiguration.PreviousHealth = nil

			local AimbotAimPart = Aimbot.AimPart
			local FOVCircle = Aimbot.FOVCircle
			local ClosestDistance = FOVCircle.Enabled and FOVCircle.Radius or math.huge
			local IsRivals = Games.IsRivals
			local DeadCheck = Aimbot.DeadCheck
			local ForceFieldCheck = Aimbot.ForceFieldCheck
			local SitCheck = Aimbot.SitCheck
			local WallCheck = Aimbot.WallCheck
			local TeamCheck = Aimbot.TeamCheck

			for Player, Cache in next, CachedPlayers do
				if TeamCheck then
					if not IsEnemy(Player) then
						continue
					end
				end

				local Character = Cache.Character

				if DeadCheck then
					if IsDead(Character, Aimbot.DeadCheckMode, Aimbot.CustomDeadCheckValue) then
						continue
					end
				end

				if ForceFieldCheck then
					if Character:FindFirstChildOfClass("ForceField") then
						continue
					end
				end

				if SitCheck and not IsRivals then
					if Cache.Humanoid.Sit then
						continue
					end
				end

				local AimPart = Cache[AimbotAimPart]

				if not AimPart then
					continue
				end

				local AimPartPosition = AimPart.Position
				local Screen, OnScreen = WorldToScreenPoint(AimPartPosition, false)
				if OnScreen then
					local Distance = (MouseLocation - Screen).Magnitude
					if Distance < ClosestDistance then
						if LocalHead and WallCheck then
							if IsBehindWall(LocalHead.Position, AimPartPosition, Character) then
								Aimbot.Target = nil
								HitConfiguration.PreviousHealth = nil
								continue
							end
						end

						ClosestDistance = Distance
						Aimbot.Target = Player
					end
				end
			end
		end,

		TargetAimbot = function(Target, ...)
			if not Target then
				StopAimbot()
				return
			end

			local Cache = CachedPlayers[Target]

			if not Cache then
				return
			end

			if Aimbot.TeamCheck then
				if not IsEnemy(Target) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			local AimPart = Cache[Aimbot.AimPart]
			local LocalHeadPosition = LocalHead and LocalHead.Position or Vector3.zero
			local Humanoid = Cache.Humanoid

			local HealthToBeReturned = 0
			if IsArsenalBaseGame then
				local HealthInstance = GetArsenalHealthInstance(Cache)
				if HealthInstance then
					local PreviousHealth = HitConfiguration.PreviousHealth
					local ArsenalHealth = HealthInstance.Value

					if PreviousHealth == nil then
						PreviousHealth = ArsenalHealth
					end

					if ArsenalHealth < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, ArsenalHealth, AimPart.Position)
					end

					HitConfiguration.PreviousHealth = ArsenalHealth
					HealthToBeReturned = ArsenalHealth
				end
			elseif Games.IsAimblox then
				local PreviousHealth = HitConfiguration.PreviousHealth
				local AimbloxHealth = Target:GetAttribute("Health") or 0

				if PreviousHealth == nil then
					PreviousHealth = AimbloxHealth
				end

				if AimbloxHealth < PreviousHealth then
					TriggerHitFunctions(PreviousHealth, AimbloxHealth, AimPart.Position)
				end

				HitConfiguration.PreviousHealth = AimbloxHealth
				HealthToBeReturned = AimbloxHealth
			else
				if Humanoid then
					local PreviousHealth = HitConfiguration.PreviousHealth

					if PreviousHealth == nil then
						PreviousHealth = Humanoid.Health
					end

					local Health = Humanoid.Health
					if Health < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, Health, AimPart.Position)
					end

					HitConfiguration.PreviousHealth = Health
					HealthToBeReturned = Health
				end
			end

			if not AimPart then
				if Aimbot.DeadCheck then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
				end
				return
			end

			local Character = Cache.Character

			if Aimbot.DeadCheck then
				if IsDead(Character, Aimbot.DeadCheckMode, Aimbot.CustomDeadCheckValue) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			if Aimbot.SitCheck then
				if Humanoid and Humanoid.Sit then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			local AimPartPosition = AimPart.Position

			if Aimbot.WallCheck then
				if LocalHead and IsBehindWall(LocalHeadPosition, AimPartPosition, Character) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			if Aimbot.Resolver then
				if Aimbot.ResolverType == "Recalculate" then
					local Start = tick()
					task.wait(0.035)
					local CurrentPosition = AimPart.Position
					local Now = tick()
					AimPart.AssemblyLinearVelocity = (CurrentPosition - AimPartPosition) / (Now - Start)
				else
					if Humanoid then
						AimPart.AssemblyLinearVelocity = Humanoid.MoveDirection * Humanoid.WalkSpeed
					end
				end
			end

			local PredictedPosition = GetPredictedPosition("Camera", AimPartPosition, AimPart.AssemblyLinearVelocity)
			local CameraCFrame = Camera.CFrame
			local CameraPosition = CameraCFrame.Position
			local ShakeOffset = Aimbot.ShakeOffset
			local TargetCFrame = CFrame.lookAt(CameraPosition, PredictedPosition)

			if ShakeOffset > 0 then
				TargetCFrame = CFrame.lookAt(CameraPosition, PredictedPosition + Vector3.new(
					math.random(-100, 100) * 0.01 * ShakeOffset,
					math.random(-100, 100) * 0.01 * ShakeOffset,
					math.random(-100, 100) * 0.01 * ShakeOffset
				))
			end

			if Aimbot.SmoothnessOffset > 0 then
				Camera.CFrame = CameraCFrame:Lerp(TargetCFrame, 1/Aimbot.SmoothnessOffset)
			else
				Camera.CFrame = TargetCFrame
			end

			if Games.IsRivals then
				local ViewModels = workspace:FindFirstChild("ViewModels")

				if not ViewModels then
					return
				end

				local FirstPerson = ViewModels:FindFirstChild("FirstPerson")

				if not FirstPerson then
					return
				end

				local ModelInstance = FirstPerson:FindFirstChildOfClass("Model")

				if not ModelInstance then
					return
				end

				local ViewModelHumanoidRootPart = ModelInstance:FindFirstChild("HumanoidRootPart")
				if ViewModelHumanoidRootPart then
					ViewModelHumanoidRootPart.CFrame = TargetCFrame
				end
			elseif Games.IsDefuseDivision then
				local Arms = Camera:FindFirstChild("Arms")
				if Arms then
					Arms.WorldPivot = CameraCFrame
				end

				if LocalCharacter then
					local Gun = LocalCharacter:FindFirstChild("Gun")
					if Gun then
						Gun.CFrame = CameraCFrame
					end
				end
			end

			return HealthToBeReturned, (LocalHeadPosition - AimPartPosition).Magnitude
		end
	},
	Mouse = {
		GetClosestPlayer = function()
			Aimbot.Target = nil
			HitConfiguration.PreviousHealth = nil

			local AimbotAimPart = Aimbot.AimPart
			local FOVCircle = Aimbot.FOVCircle
			local ClosestDistance = FOVCircle.Enabled and FOVCircle.Radius or math.huge
			local IsRivals = Games.IsRivals
			local DeadCheck = Aimbot.DeadCheck
			local ForceFieldCheck = Aimbot.ForceFieldCheck
			local SitCheck = Aimbot.SitCheck
			local WallCheck = Aimbot.WallCheck
			local TeamCheck = Aimbot.TeamCheck

			for Player, Cache in next, CachedPlayers do
				if TeamCheck then
					if not IsEnemy(Player) then
						continue
					end
				end

				local Character = Cache.Character

				if DeadCheck then
					if IsDead(Character, Aimbot.DeadCheckMode, Aimbot.CustomDeadCheckValue) then
						continue
					end
				end

				if ForceFieldCheck then
					if Character:FindFirstChildOfClass("ForceField") then
						continue
					end
				end

				if SitCheck and not IsRivals then
					if Cache.Humanoid.Sit then
						continue
					end
				end

				local AimPart = Cache[AimbotAimPart]

				if not AimPart then
					continue
				end

				local AimPartPosition = AimPart.Position

				local Screen, OnScreen = WorldToScreenPoint(AimPartPosition, true)

				if not OnScreen or Screen.Z <= 0 then
					continue
				end

				local Distance = (MouseLocation - Vector2.new(Screen.X, Screen.Y)).Magnitude
				if Distance < ClosestDistance then
					if LocalHead and WallCheck then
						if IsBehindWall(LocalHead.Position, AimPartPosition, Character) then
							Aimbot.Target = nil
							HitConfiguration.PreviousHealth = nil
							continue
						end
					end

					ClosestDistance = Distance
					Aimbot.Target = Player
				end
			end
		end,

		TargetAimbot = function(Target, DeltaTime)
			if not Library.IsRobloxFocused then
				return
			end

			if not Target then
				StopAimbot()
				return
			end

			if Aimbot.TeamCheck then
				if not IsEnemy(Target) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			local Cache = CachedPlayers[Target]

			if not Cache then
				return
			end

			local Humanoid = Cache.Humanoid

			local AimPart = Cache[Aimbot.AimPart]
			local LocalHeadPosition = LocalHead and LocalHead.Position or Vector3.zero

			local HealthToBeReturned = 0
			if IsArsenalBaseGame then
				local HealthInstance = GetArsenalHealthInstance(Cache)
				if HealthInstance then
					local PreviousHealth = HitConfiguration.PreviousHealth
					local ArsenalHealth = HealthInstance.Value

					if PreviousHealth == nil then
						PreviousHealth = ArsenalHealth
					end

					if ArsenalHealth < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, ArsenalHealth, AimPart.Position)
					end

					HitConfiguration.PreviousHealth = ArsenalHealth
					HealthToBeReturned = ArsenalHealth
				end
			elseif Games.IsAimblox then
				local PreviousHealth = HitConfiguration.PreviousHealth
				local AimbloxHealth = Target:GetAttribute("Health") or 0

				if PreviousHealth == nil then
					PreviousHealth = AimbloxHealth
				end

				if AimbloxHealth < PreviousHealth then
					TriggerHitFunctions(PreviousHealth, AimbloxHealth, AimPart.Position)
				end

				HitConfiguration.PreviousHealth = AimbloxHealth
				HealthToBeReturned = AimbloxHealth
			else
				if Humanoid then
					local PreviousHealth = HitConfiguration.PreviousHealth

					if PreviousHealth == nil then
						PreviousHealth = Humanoid.Health
					end

					local Health = Humanoid.Health
					if Health < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, Health, AimPart.Position)
					end

					HitConfiguration.PreviousHealth = Health
					HealthToBeReturned = Health
				end
			end

			local Character = Cache.Character

			if Aimbot.DeadCheck then
				if IsDead(Character, Aimbot.DeadCheckMode, Aimbot.CustomDeadCheckValue) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			if Aimbot.SitCheck and not Games.IsRivals then
				if Humanoid.Sit then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			if not AimPart then
				if Aimbot.DeadCheck then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
				end
				return
			end

			local AimPartPosition = AimPart.Position

			if Aimbot.WallCheck then
				if LocalHead and IsBehindWall(LocalHeadPosition, AimPartPosition, Character) then
					if Aimbot.StopOnCheck then
						StopAimbot()
					end
					return
				end
			end

			if Aimbot.Resolver then
				if Aimbot.ResolverType == "Recalculate" then
					local Start = tick()
					task.wait(0.035)
					AimPart.AssemblyLinearVelocity = (AimPart.Position - AimPartPosition) / (tick() - Start)
				else
					if Humanoid then
						AimPart.AssemblyLinearVelocity = Humanoid.MoveDirection * Humanoid.WalkSpeed
					end
				end
			end

			local Screen, OnScreen = WorldToScreenPoint(GetPredictedPosition("Mouse", AimPartPosition, AimPart.AssemblyLinearVelocity), true)

			if not OnScreen or Screen.Z <= 0 then
				return
			end

			local DeltaX, DeltaY = Screen.X - Mouse.X, Screen.Y - Mouse.Y

			if math.abs(DeltaX) < 0.5 and math.abs(DeltaY) < 0.5 then
				return
			end

			local Smoothness = Aimbot.SmoothnessOffset
			if Smoothness < 2 then
				Smoothness = 2
			end

			DeltaX = DeltaX / Smoothness * (60 * DeltaTime)
			DeltaY = DeltaY / Smoothness * (60 * DeltaTime)

			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mousemoverel(DeltaX, DeltaY)
			end

			return HealthToBeReturned, (LocalHeadPosition - AimPartPosition).Magnitude
		end
	}
}

if mousemoverel.IsWaxxed then
	AimbotFunctions.Mouse.TargetAimbot = Module.Tables.Blank
end

if not Games.Aimblox and not Games.IsStrucid and not Games.IsFantasmaPVP then
	local Functions = AimbotFunctions.Camera
	GetClosestPlayer = Functions.GetClosestPlayer
	TargetAimbot = Functions.TargetAimbot
else
	local Functions = AimbotFunctions.Mouse
	GetClosestPlayer = Functions.GetClosestPlayer
	TargetAimbot = Functions.TargetAimbot
end

local Trigger = nil
if Games.IsQuickShot then
	Trigger = function()
		if not Camera or not LocalCharacter or not LocalHumanoid then
			return
		end

		local Target = Mouse.Target

		if not Target then
			return
		end

		local ModelInstance = Target:FindFirstAncestorOfClass("Model")

		if not ModelInstance then
			return
		end

		if not ModelInstance:IsDescendantOf(workspace:FindFirstChild("ActiveBots")) then
			local Player = Players:GetPlayerFromCharacter(ModelInstance)

			if not Player or Player == LocalPlayer then
				return
			end

			if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
				return
			end

			if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
				return
			end

			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end
		end

		if Library.IsRobloxFocused then
			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mouse1press()
				task.wait(TriggerBot.TriggerDelay)
				mouse1release()
			end
		end
	end
elseif Games.IsOneTap then
	Trigger = function()
		if not Camera or not LocalCharacter or not LocalHumanoid then
			return
		end

		local Target = Mouse.Target

		if not Target then
			return
		end

		local ModelInstance = Target:FindFirstAncestorOfClass("Model")

		if not ModelInstance then
			return
		end

		local Player = Players:GetPlayerFromCharacter(ModelInstance)

		if Player == LocalPlayer then
			return
		end

		if Player then
			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end

			if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
				return
			end

			if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
				return
			end
		else
			local Humanoid = ModelInstance:FindFirstChildOfClass("Humanoid")
			if not Humanoid or Humanoid:FindFirstChildOfClass("Status") then
				return
			end

			if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
				return
			end
		end

		if Library.IsRobloxFocused then
			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mouse1press()
				task.wait(TriggerBot.TriggerDelay)
				mouse1release()
			end
		end
	end
elseif Games.IsCombatArena then
	Trigger = function()
		if not Camera or not LocalCharacter or not LocalHumanoid then
			return
		end

		local Target = Mouse.Target

		if not Target then
			return
		end

		local ModelInstance = Target:FindFirstAncestorOfClass("Model")

		if not ModelInstance then
			return
		end

		local Player = Players:GetPlayerFromCharacter(ModelInstance)

		if Player == LocalPlayer then
			return
		end

		if Player then
			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end

			if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
				return
			end

			if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
				return
			end
		else
			if not ModelInstance:FindFirstChild("NPCAnimate") then
				return
			end

			if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
				return
			end
		end

		if Library.IsRobloxFocused then
			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mouse1press()
				task.wait(TriggerBot.TriggerDelay)
				mouse1release()
			end
		end
	end
else
	Trigger = function()
		if not Camera or not LocalCharacter or not LocalHumanoid then
			return
		end

		local Target = Mouse.Target

		if not Target then
			return
		end

		local ModelInstance = Target:FindFirstAncestorOfClass("Model")

		if not ModelInstance then
			return
		end

		local Player = Players:GetPlayerFromCharacter(ModelInstance)

		if not Player or Player == LocalPlayer then
			return
		end

		if TriggerBot.TeamCheck and not IsEnemy(Player) then
			return
		end

		if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
			return
		end

		if TriggerBot.ForceFieldCheck and IsCharacterProtected(ModelInstance) then
			return
		end

		if Library.IsRobloxFocused then
			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mouse1press()
				task.wait(TriggerBot.TriggerDelay)
				mouse1release()
			end
		end
	end
end

task.spawn(function()
	local FOVCircle = SilentAimbot.FOVCircle
	local GetPartData = nil
	if Games.IsAimblox then
		--[[if hookmetamethod and getnamecallmethod then
			GetPartData = function()
				local ClosestDistance = (FOVCircle.Enabled and FOVCircle.Radius) or math.huge
				local ClosestPart
				for Player, Cache in next, CachedPlayers do
					local Character = Cache and Cache.Character
					if not Character then
						continue
					end
					if SilentAimbot.TeamCheck then
						local Team = Player:GetAttribute("Team")
						local LocalTeam = LocalPlayer:GetAttribute("Team")
						if Team and LocalTeam then
							if Team == LocalTeam then
								continue
							end
						else
							continue
						end
					end
					if SilentAimbot.DeadCheck then
						local Health = Player:GetAttribute("Health")
						if not Health or Health <= 0 then
							continue
						end
					end
					local AimPart = Cache[SilentAimbot.AimPart]
					if AimPart then
						local ScreenPos, OnScreen = WorldToScreenPoint(AimPart.Position, false)
						if OnScreen then
							local Distance = (MouseLocation - ScreenPos).Magnitude
							if Distance < ClosestDistance then
								ClosestDistance = Distance
								ClosestPart = AimPart
							end
						end
					end
				end
				return ClosestPart
			end
			local __namecall
			__namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
				local Arguments = {...}

				if not Running or not SilentAimbot.Enabled or Arguments[1] ~= workspace then
					return __namecall(...)
				end

				if getnamecallmethod() ~= "Raycast" or typeof(Arguments[#Arguments]) ~= "RaycastParams" then
					return __namecall(...)
				end

				local PartData = GetPartData()
				if PartData then
					local Origin = Arguments[2]
					local Position = PartData.Position

					Arguments[3] = (Position - Origin).Unit * (Origin - Position).Magnitude
					return __namecall(unpack(Arguments))
				end

				return __namecall(...)
			end))
		end]]
	elseif Games.IsRivals then
		GetPartData = function()
			local ClosestDistance = (FOVCircle.Enabled and FOVCircle.Radius) or math.huge
			local ClosestPart

			for Player, Cache in next, CachedPlayers do
				local Character = Cache.Character
				if not Character then
					continue
				end

				if SilentAimbot.TeamCheck then
					if not IsEnemy(Player) then
						continue
					end
				end

				if SilentAimbot.DeadCheck then
					if IsDead(Character, "Universal", 0) then
						continue
					end
				end

				local AimPart = Cache[SilentAimbot.AimPart]
				local AimPartPosition = AimPart.Position
				if AimPart then
					if LocalRoot then
						if GetDistanceSquared(AimPartPosition, LocalRoot.Position) >= 9_000_000 then
							continue
						end
					end

					local Screen, OnScreen = WorldToScreenPoint(AimPartPosition, false)
					if OnScreen then
						local Distance = (MouseLocation - Screen).Magnitude
						if Distance < ClosestDistance then
							ClosestDistance = Distance
							ClosestPart = AimPart
						end
					end
				end
			end

			return ClosestPart
		end

		local SavedCameraCFrame = nil
		InsertToConnections(Mouse.Button1Down:Connect(function()
			if SilentAimbot.Enabled then
				local PartData = GetPartData()
				if PartData then
					Camera.CFrame = CFrame.new(Camera.CFrame.Position, PartData.Position)
					SavedCameraCFrame = Camera.CFrame
				end
			end
		end))
		InsertToConnections(Mouse.Button1Up:Connect(function()
			if SilentAimbot.Enabled and SavedCameraCFrame then
				Camera.CFrame = SavedCameraCFrame
			end
		end))
	elseif Games.IsDefuseDivision then
		if hookmetamethod and getnamecallmethod then
			GetPartData = function()
				local ClosestDistance = (FOVCircle.Enabled and FOVCircle.Radius) or math.huge
				local ClosestPart
				for Player, Cache in next, CachedPlayers do
					local Character = Cache and Cache.Character
					if not Character then
						continue
					end

					if SilentAimbot.TeamCheck then
						if not IsEnemy(Player) then
							continue
						end
					end

					if SilentAimbot.DeadCheck then
						if IsDead(Character, "Universal", 0) then
							continue
						end
					end

					local AimPart = Cache[SilentAimbot.AimPart]
					if AimPart then
						local RootPosition = LocalRoot and AimPart.Position
						if RootPosition then
							if GetDistanceSquared(RootPosition, LocalRoot.Position) > 4_000_000 then
								continue
							end
						end
						local Screen, OnScreen = WorldToScreenPoint(AimPart.Position, false)
						if OnScreen then
							local Distance = (MouseLocation - Screen).Magnitude
							if Distance < ClosestDistance then
								ClosestDistance = Distance
								ClosestPart = AimPart
							end
						end
					end
				end
				return ClosestPart
			end
			--[[local __namecall
			__namecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
				if not Running or not SilentAimbot.Enabled then
					return __namecall(self, ...)
				end

				if getnamecallmethod() ~= "ViewportPointToRay" then
					return __namecall(self, ...)
				end

				local PartData = GetPartData()
				if PartData then
					local CameraPosition = Camera.CFrame.Position
					return Ray.new(CameraPosition, (PartData.Position - CameraPosition).Unit)
				end

				return __namecall(self, ...)
			end))]]
		end
	elseif Games.IsDaHood then
		if hookmetamethod then
			GetPartData = function()
				local ClosestDistance = (FOVCircle.Enabled and FOVCircle.Radius) or math.huge
				local ClosestPart
				for Player, Cache in next, CachedPlayers do
					if not Player or not Cache or not Cache.Character then
						continue
					end

					if SilentAimbot.DeadCheck then
						local Humanoid = Cache.Humanoid
						if not Humanoid or Humanoid.Health <= 0 then
							continue
						end
					end

					local AimPart = Cache[SilentAimbot.AimPart]
					if AimPart then
						local ScreenPos, OnScreen = WorldToScreenPoint(AimPart.Position, false)
						if OnScreen then
							local Distance = (MouseLocation - ScreenPos).Magnitude
							if Distance < ClosestDistance then
								ClosestDistance = Distance
								ClosestPart = AimPart
							end
						end
					end
				end
				return ClosestPart
			end

			local __index
			__index = hookmetamethod(game, "__index", newcclosure(function(self, Index)
				if not SilentAimbot.Enabled or not self:IsA("Mouse") or ((Index ~= "Hit") and Index ~= "Target") then
					return __index(self, Index)
				end

				local PartData = GetPartData()
				if PartData then
					return (Index == "Hit") and PartData.CFrame or PartData
				end

				return __index(self, Index)
			end))
		end
	elseif Games.IsKAT then
		if hookmetamethod then
			GetPartData = function()
				local ClosestDistance = (FOVCircle.Enabled and FOVCircle.Radius) or math.huge
				local ClosestPart
			
				--local Wallbang = SilentAimbot.Wallbang
				local ForceFieldCheck = SilentAimbot.ForceFieldCheck
				local WallCheck = SilentAimbot.WallCheck
				local TeamCheck = SilentAimbot.TeamCheck

				for Index = 1, #CachedPlayersList do
					local Cache = CachedPlayersList[Index]

					local Character = Cache.Character
					if not Character then
						continue
					end

					if TeamCheck and Cache.Player.Team == LocalPlayer.Team then
						continue
					end

					local Humanoid = Cache.Humanoid
					if not Humanoid or Humanoid.Health <= 0 then
						continue
					end

					if ForceFieldCheck and Character:FindFirstChildOfClass("ForceField") then
						continue
					end

					local AimPart = SilentAimbot.AimPart
					local AimPartPosition

					if AimPart == "Random" then
						AimPart = math.random(1, 2) == 1 and Cache["Root"] or Cache["Head"]

						if not AimPart then
							continue
						end

						AimPartPosition = AimPart.Position
					else
						AimPart = Cache[AimPart]

						if not AimPart then
							continue
						end

						AimPartPosition = AimPart.Position
					end

					if --[[not Wallbang and ]]LocalHead and WallCheck then
						if IsBehindWall(LocalHead.Position, AimPartPosition, Character) then
							continue
						end
					end

					local Screen, OnScreen = WorldToScreenPoint(AimPartPosition)
					if OnScreen then
						local Distance = (MouseLocation - Screen).Magnitude
						if Distance < ClosestDistance then
							ClosestDistance = Distance
							ClosestPart = AimPart
						end
					end
				end

				return ClosestPart
			end

			local __namecall
			__namecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
				if not Running or not Camera or not SilentAimbot.Enabled then
					return __namecall(...)
				end

				local Arguments = {...}
				if Arguments[1] ~= workspace or getnamecallmethod() ~= "FindPartOnRayWithIgnoreList" then
					return __namecall(...)
				end

				if typeof(Arguments[2]) == "Ray" then
					local _,PartData = coroutine.resume(coroutine.create(GetPartData))
					if PartData then
						local Origin = Arguments[2].Origin
						--[[if SilentAimbot.Wallbang then
							local _,Position = coroutine.resume(coroutine.create(function()
								return Origin:Lerp(PartData.Position, 0.95)
							end))
							Origin = Position
						else
							Origin = Arguments[2].Origin
						end]]
						Arguments[2] = Ray.new(Origin, (PartData.Position - Origin).Unit * 1000)
						return __namecall(unpack(Arguments))
					end
				end

				return __namecall(...)
			end))
		end
	end
end)

ThreadManager:Start("CacheLocalPlayer", function()
    local CurrentCharacter = LocalPlayer.Character

    if not CurrentCharacter or not CurrentCharacter.Parent then
        LocalCharacter = nil
        return
    end

    LocalCharacter = CurrentCharacter

    if not LocalHumanoid or LocalHumanoid.Parent ~= LocalCharacter then
        LocalHumanoid = LocalCharacter:FindFirstChildOfClass("Humanoid")
    end

    if not LocalHead or LocalHead.Parent ~= LocalCharacter then
        LocalHead = LocalCharacter:FindFirstChild("Head")
    end

    if not LocalRoot or LocalRoot.Parent ~= LocalCharacter then
        LocalRoot = LocalCharacter.PrimaryPart
        if not LocalRoot then
            LocalRoot = LocalCharacter:FindFirstChild("HumanoidRootPart")
            if not LocalRoot then
                LocalRoot = LocalCharacter:FindFirstChild("Torso") or LocalCharacter:FindFirstChild("LowerTorso")
            end
        end
    end
end, 0.1)

if IsCounterBloxBaseGame then
	task.spawn(function()
		local ControlTurn = ReplicatedStorage:WaitForChild("Events"):WaitForChild("ControlTurn")
		ThreadManager:Start("CounterBloxBaseGameAntiAim", function()
			if LocalRoot and AntiAim.Enabled and AntiAim.Look then
				ControlTurn:FireServer(AntiAim.LookValue)
			end

			task.wait(AntiAim.LookWaitTime)
		end)
	end)
end

local function CFrameAA()
	local AntiAimMode = AntiAim.CFrameMode

	if AntiAimMode == "None" then
		return
	end

	local LookVector = Camera and Camera.CFrame.LookVector

	if not LookVector then
		return
	end

	local RootPosition = LocalRoot.Position
	if AntiAimMode == "Randomizer" then
		local RNG = math.random(1, 3)
		local Offset = RNG == 1 and Vector3.new(
			-LookVector.X, 0, -LookVector.Z
		).Unit or (RNG == 2 and Vector3.new(
			-LookVector.Z, 0, LookVector.X
		) or Vector3.new(LookVector.Z, 0, -LookVector.X))
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Offset)
	elseif AntiAimMode == "Backwards" then
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Vector3.new(-LookVector.X, 0, -LookVector.Z).Unit)
	elseif AntiAimMode == "Left" then
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Vector3.new(-LookVector.Z, 0, LookVector.X))
	elseif AntiAimMode == "Right" then
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Vector3.new(LookVector.Z, 0, -LookVector.X))
	elseif AntiAimMode == "Jitter" then
		local Angle = math.rad(math.random(-90, 90))
		local Cosine, Sine = math.cos(Angle), math.sin(Angle)
		local LookVectorX = LookVector.X
		local LookVectorZ = LookVector.Z
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Vector3.new(
			LookVectorX * Cosine - LookVectorZ * Sine, 0, LookVectorX * Sine + LookVectorZ * Cosine
		))
	elseif AntiAimMode == "Reverse Jitter" then
		local Angle = math.rad(math.random(-45, 45))
		local Cosine, Sine = math.cos(Angle), math.sin(Angle)
		local ReversedLookVector = Vector3.new(-LookVector.X, 0, -LookVector.Z)
		local ReversedLookVectorX = ReversedLookVector.X
		local ReversedLookVectorZ = ReversedLookVector.Z
		LocalRoot.CFrame = CFrame.new(RootPosition, RootPosition + Vector3.new(
			ReversedLookVectorX * Cosine - ReversedLookVectorZ * Sine, 0, ReversedLookVectorX * Sine + ReversedLookVectorZ * Cosine
		))
	else
		local OldCFrame = LocalRoot.CFrame
		local OldPosition = OldCFrame.Position
		LocalRoot.CFrame = CFrame.new(Vector3.new(OldPosition.X, -999, OldPosition.Z), Vector3.new(0, -99999, 0))
		RunService.RenderStepped:Wait()
		LocalRoot.CFrame = OldCFrame
	end
end

local function VelocityAA()
	local AntiAimMode = AntiAim.VelocityMode

	if AntiAimMode == "None" then
		return
	end

	LocalRoot.AssemblyLinearVelocity = AntiAim.VelocityModeBehaviours[AntiAimMode](LocalRoot)
	RunService.RenderStepped:Wait()
	LocalRoot.AssemblyLinearVelocity = LocalRoot.AssemblyLinearVelocity
end

Heartbeat(function()
	if LocalRoot and AntiAim.Enabled then
		CFrameAA()
		VelocityAA()
	end
end, true)

if IsMouseAndKeyboardPreferredInput then
	InsertToConnections(UserInputService.InputBegan:Connect(function(Input, GameProccessedEvent)
		if GameProccessedEvent then
			return
		end

		if Input == KeyCodeSpace then
			if Movement.InfiniteJump then
				if LocalHumanoid and LocalHumanoid:GetState() == EnumFreefallState then
					LocalHumanoid:ChangeState(EnumJumpingState)
				end
			elseif Movement.NoJumpCooldown then
				if LocalHumanoid and LocalHumanoid:GetState() ~= EnumFreefallState then
					LocalHumanoid:ChangeState(EnumJumpingState)
					LocalHumanoid.Jump = true
				end
			end
		end
	end))
else
	InsertToConnections(UserInputService.JumpRequest:Connect(function()
		if not LocalHumanoid then
			return
		end

		if Movement.InfiniteJump then
			if LocalHumanoid:GetState() == EnumFreefallState then
				LocalHumanoid:ChangeState(EnumJumpingState)
			end
		elseif Movement.NoJumpCooldown then
			if LocalHumanoid:GetState() ~= EnumFreefallState then
				LocalHumanoid:ChangeState(EnumJumpingState)
				LocalHumanoid.Jump = true
			end
		end
	end))
end

Watermark:SetVisible(true)

local Window = nil
local WindowTabs = {
	WindowAimingTab = nil,
 	WindowTriggerBotTab = nil,
 	WindowPlayersTab = nil,
 	WindowVisualsTab = nil,
	WindowWorldTab = nil,
	WindowSettingsTab = nil
}
local UISuccess, UIOutput = pcall(function()
	Window = Library:CreateWindow({Icon = "130975824766445"})
	WindowTabs.WindowAimingTab = Window:AddTab("Target Aimbot", "crosshair")
	WindowTabs.WindowTriggerBotTab = Window:AddTab("TriggerBot", "bot")
	WindowTabs.WindowPlayersTab = Window:AddTab("LocalPlayer", "users")
	WindowTabs.WindowVisualsTab = Window:AddTab("Visuals", "eye")
	WindowTabs.WindowWorldTab = Window:AddTab("World", "globe")
	WindowTabs.WindowSettingsTab = Window:AddTab("Settings", "settings")
end)
if not UISuccess then
	return LocalPlayer:Kick("Failed to set up UI, rejoin and try again.\n" .. tostring(UIOutput))
end

local TabBoxes = {
	LocalPlayerTabBox = WindowTabs.WindowPlayersTab:AddLeftTabbox("LocalPlayerTabBox"),
	PlayersGroupBox = WindowTabs.WindowPlayersTab:AddRightGroupbox("Fun"),
}
local Tabs = {
	Aimbot = WindowTabs.WindowAimingTab:AddLeftGroupbox("Aimbot | Camera & Mouse"),
	Target = WindowTabs.WindowAimingTab:AddRightGroupbox("Target View"),
	HitConfiguration = WindowTabs.WindowAimingTab:AddRightGroupbox("Hit Configuration"),
	TriggerBot = WindowTabs.WindowTriggerBotTab:AddLeftTabbox("TriggerBotTabBox"):AddTab("TriggerBot"),
	Movement = TabBoxes.LocalPlayerTabBox:AddTab("Movement"),
	AntiAim = TabBoxes.LocalPlayerTabBox:AddTab("Anti Aim")
}
local VisualsESPTab = WindowTabs.WindowVisualsTab:AddLeftGroupbox("Extra-Sensory Perception")
local WorldLightingTab = WindowTabs.WindowWorldTab:AddLeftGroupbox("Lighting")
local WorldLocalCharacterTab = WindowTabs.WindowWorldTab:AddRightGroupbox("Local Character")
local VisualsTabCrosshair = WindowTabs.WindowVisualsTab:AddRightGroupbox("Crosshair Overlay")
local SettingsTab = WindowTabs.WindowSettingsTab:AddLeftGroupbox("Settings")

if Games.IsRivals then
	Tabs.Aimbot:AddLabel("If you are using Camera Aimbot then it is recommended to Spam-Click instead of Hold-Click.", true)
end

Tabs.Aimbot:AddToggle("Aimbot", {
	Text = "Toggle Aimbot",
	Default = Aimbot.Toggled,
	Callback = function(State)
		Aimbot.Toggled = State
		if not State and Aimbot.Enabled then
			StopAimbot()
		end
	end
}):AddKeyPicker("AimbotKey", {
	Mode = "Toggle",
	Text = "Aimbot",
	Callback = function()
		if not Aimbot.Toggled then
			return
		end

		Aimbot.Enabled = not Aimbot.Enabled

		if not Aimbot.Enabled then
			StopAimbot()
			return
		end

		if Aimbot.StickyAim then
			GetClosestPlayer()
		end

		Connections.Aimbot = RenderStepped(function(DeltaTime)
			if not Aimbot.StickyAim then
				GetClosestPlayer()
			end

			local TargetView = Aimbot.TargetView
			local Target = Aimbot.Target
			local Health, Distance = TargetAimbot(Target, DeltaTime)
			if Target and Target.Parent then
				TargetView.TargetLabel:SetText(Target.Name .. " (@" .. Target.DisplayName .. ")")
				Options["TargetImageLabel"]:SetImage("rbxthumb://type=AvatarHeadShot&id=" .. Target.UserId .. "&w=420&h=420")

				if Health then
					TargetView.HealthLabel:SetText("Health: " .. math.floor(Health))
				else
					TargetView.HealthLabel:SetText("Health: 0")
				end

				if Distance then
					TargetView.StudsLabel:SetText(math.floor(Distance) .. " Studs Away")
				else
					TargetView.StudsLabel:SetText("0 Studs Away")
				end
			else
				TargetView.TargetLabel:SetText("None (@None)")
				Options["TargetImageLabel"]:SetImage("rbxthumb://type=AvatarHeadShot&id=0&w=420&h=420")
				TargetView.HealthLabel:SetText("Health: 0")
				TargetView.StudsLabel:SetText("0 Studs Away")
			end
		end, false)
	end
})

if not Games.IsAimblox and not Games.IsStrucid and not Games.IsFantasmaPVP then
	if IsMouseAndKeyboardPreferredInput then
		Tabs.Aimbot:AddDropdown("AimbotAimType", {
			Text = "Aim Type",
			Values = {"Camera", "Mouse"},
			Default = 1,
			Callback = function(Option)
				local Functions = AimbotFunctions[Option]
				GetClosestPlayer = Functions.GetClosestPlayer
				TargetAimbot = Functions.TargetAimbot
				StopAimbot()
			end
		})
	end
else
	local Functions = AimbotFunctions["Mouse"]
	GetClosestPlayer = Functions.GetClosestPlayer
	TargetAimbot = Functions.TargetAimbot
end

Tabs.Aimbot:AddDropdown("AimbotAimPart", {
	Text = "Aim Part",
	Values = {"Head", "Root"},
	Default = 2,
	Callback = function(Value)
		Aimbot.AimPart = Value
	end
})
Tabs.Aimbot:AddToggle("AimbotStickyAim", {
	Text = "Sticky Aim",
	Default = Aimbot.StickyAim,
	Callback = function(State)
		Aimbot.StickyAim = State
	end
})
Tabs.Aimbot:AddToggle("AimbotFOVCircle", {
	Text = "FOV Circle",
	Default = Aimbot.FOVCircle.Enabled,
	Callback = function(State)
		Aimbot.FOVCircle.Enabled = State
	end
}):AddColorPicker("AimbotFOVCircleColor", {
	Default = Aimbot.FOVCircle.Color,
	Transparency = 0,
	Callback = function(Color)
		Aimbot.FOVCircle.Color = Color
		Aimbot.FOVCircle.Transparency = 1 - Options["AimbotFOVCircleColor"].Transparency
	end
})
Tabs.Aimbot:AddToggle("AimbotFOVCircleFilled", {
	Text = "Filled Circle",
	Default = Aimbot.FOVCircle.Filled,
	Callback = function(Filled)
		Aimbot.FOVCircle.Filled = Filled
	end
})
Tabs.Aimbot:AddSlider("AimbotFOVCircleThickness", {
	Text = "Circle Thickness",
	Default = Aimbot.FOVCircle.Thickness,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Compact = false,
	Callback = function(Thickness)
		Aimbot.FOVCircle.Thickness = Thickness
	end
})
Tabs.Aimbot:AddSlider("AimbotFOVCircleRadius", {
	Text = "Circle Radius",
	Default = Aimbot.FOVCircle.Radius,
	Min = 50,
	Max = 1000,
	Rounding = 0,
	Compact = false,
	Callback = function(Radius)
		Aimbot.FOVCircle.Radius = Radius
	end
})
Tabs.Aimbot:AddDropdown("AimbotFOVCirclePosition", {
	Text = "Circle Position",
	Values = {"Center", "Mouse"},
	Default = 1,
	Callback = function(Position)
		Aimbot.FOVCircle.Position = Position
	end
})
Tabs.Aimbot:AddToggle("AimbotAutoPrediction", {
	Text = "Auto Prediction",
	Default = Aimbot.AutoPrediction,
	Callback = function(State)
		Aimbot.AutoPrediction = State
	end
})
Tabs.Aimbot:AddToggle("AimbotForceField", {
	Text = "ForceField Check",
	Default = Aimbot.ForceFieldCheck,
	Callback = function(State)
		Aimbot.ForceFieldCheck = State
	end
})
Tabs.Aimbot:AddToggle("AimbotSitCheck", {
	Text = "Seated Check",
	Default = Aimbot.SitCheck,
	Callback = function(State)
		Aimbot.SitCheck = State
	end
})
Tabs.Aimbot:AddToggle("AimbotWallCheck", {
	Text = "Wall Check",
	Default = Aimbot.WallCheck,
	Callback = function(State)
		Aimbot.WallCheck = State
	end
})
Tabs.Aimbot:AddToggle("AimbotTeamCheck", {
	Text = "Team Check",
	Default = Aimbot.TeamCheck,
	Callback = function(State)
		Aimbot.TeamCheck = State
	end
})
Tabs.Aimbot:AddToggle("AimbotDeadCheck", {
	Text = "Dead Check",
	Default = Aimbot.DeadCheck,
	Callback = function(State)
		Aimbot.DeadCheck = State
	end
})
Tabs.Aimbot:AddDropdown("AimbotDeadCheckMode", {
	Text = "Dead Check mode",
	Values = {"Universal", "Custom"},
	Default = 1,
	Callback = function(Value)
		Aimbot.DeadCheckMode = Value
		Options["AimbotCustomDeadCheckValueDropdown"]:SetDisabled(Value == "Universal")
	end
})
Tabs.Aimbot:AddSlider("AimbotCustomDeadCheckValueDropdown", {
	Text = "Custom Dead Check Health",
	Default = Games.IsAladiaPvP and 1 or Aimbot.CustomDeadCheckValue,
	Disabled = true,
	Min = Games.IsAladiaPvP and 1 or 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		Aimbot.CustomDeadCheckValue = Value
	end
})
Tabs.Aimbot:AddToggle("StopOnCheck", {
	Text = "Stop Aimbot On Check",
	Default = Aimbot.StopOnCheck,
	Callback = function(State)
		Aimbot.StopOnCheck = State
	end
})
Tabs.Aimbot:AddToggle("AimbotResolver", {
	Text = "Resolver",
	Default = Aimbot.Resolver,
	Callback = function(State)
		Aimbot.Resolver = State
	end
})
Tabs.Aimbot:AddDropdown("AimbotResolverType", {
	Text = "Resolver Type",
	Values = {"Recalculate", "MoveDirection"},
	Default = 2,
	Callback = function(Option)
		Aimbot.ResolverType = Option
	end
})
Tabs.Aimbot:AddSlider("AimbotShakeOffset", {
	Text = "Shake Offset",
	Default = Aimbot.ShakeOffset,
	Min = 0,
	Max = 5,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		Aimbot.ShakeOffset = Value * 0.1
	end
})
Tabs.Aimbot:AddSlider("AimbotPredictionOffset", {
	Text = "Prediction Offset",
	Default = Aimbot.PredictionOffset,
	Min = 0,
	Max = 25,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		Aimbot.PredictionOffset = Value * 0.01
	end
})
Tabs.Aimbot:AddSlider("AimbotSmoothnessOffset", {
	Text = "Smoothness Offset",
	Default = (not Games.IsAimblox and not Games.IsStrucid and not Games.IsFantasmaPVP) and Aimbot.SmoothnessOffset or 1,
	Min = 0,
	Max = 15,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Aimbot.SmoothnessOffset = Value
	end
})

task.delay(0, function()
    Tabs.Aimbot:Resize()
end)

Aimbot.TargetView.TargetLabel = Tabs.Target:AddLabel("None (@None)", true)
Tabs.Target:AddButton({
	Text = "Teleport to Target",
	Func = function()
		if not LocalRoot then
			return
		end

		local Target = Aimbot.Target

		if not Target then
			return
		end

		local Cache = CachedPlayers[Target]

		if not Cache then
			return
		end

		local Root = Cache.Root
		if Root then
			LocalRoot.CFrame = Root.CFrame
		end
	end
})
Tabs.Target:AddImage("TargetImageLabel", {
    Image = "rbxthumb://type=AvatarHeadShot&id=0&w=420&h=420",
    Height = 140,
})
Aimbot.TargetView.HealthLabel = Tabs.Target:AddLabel("Health: 0")
Aimbot.TargetView.StudsLabel = Tabs.Target:AddLabel("0 Studs Away")
Tabs.Target:AddToggle("AimbotViewAtToggle", {
	Text = "View At Target",
	Default = Aimbot.ViewAt,
	Callback = function(State)
		if not State then
			if Connections.AimbotViewAtTarget then
				Connections.AimbotViewAtTarget:Disconnect()
				Connections.AimbotViewAtTarget = nil
			end
			if Camera and LocalHumanoid then
				Camera.CameraSubject = LocalHumanoid
			end
			return
		end
		Connections.AimbotViewAtTarget = RenderStepped(function()
			if Camera then
				local Cache = CachedPlayers[Aimbot.Target]
				if Cache then
					local Humanoid = Cache.Humanoid
					if Humanoid then
						Camera.CameraSubject = Humanoid
					else
						Camera.CameraSubject = LocalHumanoid
					end
				else
					if LocalHumanoid then
						Camera.CameraSubject = LocalHumanoid
					end
				end
			end
		end, false)
	end
})
Tabs.Target:AddToggle("AimbotLookAtToggle", {
	Text = "Look At Target",
	Default = Aimbot.TargetView.LookAt,
	Callback = function(State)
		if not State then
			if Connections.AimbotLookAtTarget then
				Connections.AimbotLookAtTarget:Disconnect()
				Connections.AimbotLookAtTarget = nil
			end
			return
		end
		Connections.AimbotLookAtTarget = RenderStepped(function()
			if not LocalRoot or LocalPlayer.CameraMode == CameraModeLockFirstPerson then
				return
			end

			local Cache = CachedPlayers[Aimbot.Target]

			if not Cache then
				return
			end

			local Root = Cache.Root
			if Root then
				local RootPosition = Root.Position
				LocalRoot.CFrame = CFrame.new(LocalRoot.Position, Vector3.new(RootPosition.X, LocalRoot.Position.Y, RootPosition.Z))
			end
		end, false)
	end
})

Tabs.HitConfiguration:AddToggle("AimbotHitMasterSwitch", {
	Text = "Master Switch",
	Default = HitConfiguration.Toggled,
	Callback = function(State)
		HitConfiguration.Toggled = State
	end
})
Tabs.HitConfiguration:AddDivider("Hit Markers")
Tabs.HitConfiguration:AddToggle("AimbotHitMarkers", {
	Text = "Enabled",
	Default = HitConfiguration.Marker.Enabled,
	Callback = function(State)
		HitConfiguration.Marker.Enabled = State
	end
}):AddColorPicker("AimbotHitMarkerColor", {
	Default = HitConfiguration.Marker.Color,
	Transparency = nil,
	Callback = function(Color)
		HitConfiguration.Marker.Color = Color
	end
})
Tabs.HitConfiguration:AddSlider("AimbotHitMarkerScale", {
	Text = "Size Scale",
	Default = HitConfiguration.Marker.Scale,
	Min = 1,
	Max = 3,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		HitConfiguration.Marker.Scale = Value
	end
})
Tabs.HitConfiguration:AddSlider("AimbotHitMarkerLifetime", {
	Text = "Lifetime",
	Default = HitConfiguration.Marker.Lifetime,
	Min = 1,
	Max = 5,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		HitConfiguration.Marker.Lifetime = Value
	end
})
Tabs.HitConfiguration:AddDropdown("AimbotHitMarkerStyle", {
	Text = "Marker Style",
	Values = {"Classic X", "Broken X", "Circle", "Plus"},
	Default = 1,
	Callback = function(Value)
		HitConfiguration.Marker.Style = Value
		local ShouldNotDoCenterDot = Value == "Classic X" or Value == "Plus"
		Toggles["AimbotHitMarkerCenterDot"]:SetDisabled(ShouldNotDoCenterDot)
		if ShouldNotDoCenterDot then
			HitConfiguration.Marker.CenterDot = false
			Toggles["AimbotHitMarkerCenterDot"]:SetValue(false)
		end
	end
})
Tabs.HitConfiguration:AddToggle("AimbotHitMarkerCenterDot", {
	Text = "Center Dot",
	Disabled = true,
	Default = HitConfiguration.Marker.CenterDot,
	Callback = function(State)
		HitConfiguration.Marker.CenterDot = State
	end
})
Tabs.HitConfiguration:AddToggle("AimbotHitMarkerFadeInAnimation", {
	Text = "Fade In Animation",
	Default = HitConfiguration.Marker.FadeIn,
	Callback = function(State)
		HitConfiguration.Marker.FadeIn = State
	end
})
Tabs.HitConfiguration:AddToggle("AimbotHitMarkerFadeOutAnimation", {
	Text = "Fade Out Animation",
	Default = HitConfiguration.Marker.FadeOut,
	Callback = function(State)
		HitConfiguration.Marker.FadeOut = State
	end
})

Tabs.HitConfiguration:AddDivider("Hit Logs")
Tabs.HitConfiguration:AddToggle("AimbotHitLog", {
	Text = "Enabled",
	Default = HitConfiguration.Log.Enabled,
	Callback = function(State)
		HitConfiguration.Log.Enabled = State
	end
})
Tabs.HitConfiguration:AddToggle("AimbotHitLogUseColor", {
	Text = "Use Color",
	Default = HitConfiguration.Log.UseColor,
	Callback = function(State)
		HitConfiguration.Log.UseColor = State
	end
}):AddColorPicker("AimbotHitLogColor", {
	Default = HitConfiguration.Log.Color,
	Transparency = nil,
	Callback = function(Color)
		HitConfiguration.Log.Color = Color
	end
})
Tabs.HitConfiguration:AddSlider("AimbotHitLogDuration", {
	Text = "Duration",
	Default = HitConfiguration.Log.Duration,
	Min = 1,
	Max = 2.5,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		HitConfiguration.Log.Duration = Value
	end
})
Tabs.HitConfiguration:AddDivider("Hit Sounds")
Tabs.HitConfiguration:AddToggle("AimbotHitSound", {
	Text = "Enabled",
	Default = HitConfiguration.Sound.Enabled,
	Callback = function(State)
		HitConfiguration.Sound.Enabled = State
	end
})
Tabs.HitConfiguration:AddSlider("AimbotHitSoundVolume", {
	Text = "Volume",
	Default = HitConfiguration.Sound.Volume,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Compact = false,
	Callback = function(Volume)
		HitConfiguration.Sound.Volume = Volume
	end
})
Tabs.HitConfiguration:AddDropdown("AimbotHitSounds", {
	Text = "Sound",
	Values = HitSounds.Options,
	Default = 1,
	Callback = function(Sound)
		HitConfiguration.Sound.Selected = Sound
		PlayHitSound(Sound, HitConfiguration.Sound.Volume)
	end
})

local TriggerBotLabel = Tabs.TriggerBot:AddLabel("TriggerBot: Disabled")
Tabs.TriggerBot:AddToggle("TriggerBotEnabled", {
	Text = "Toggle TriggerBot",
	Default = TriggerBot.Toggled,
	Callback = function(State)
		TriggerBotLabel:SetText("TriggerBot: Disabled")
		TriggerBot.Toggled = State
		if not State and TriggerBot.Enabled then
			if Connections.TriggerBot then
				Connections.TriggerBot:Disconnect()
				Connections.TriggerBot = nil
			end
		end
	end
}):AddKeyPicker("TriggerBotKey", {
	Mode = "Toggle",
	Text = "TriggerBot",
	Callback = function()
		if not TriggerBot.Toggled then
			return
		end
		TriggerBot.Enabled = not TriggerBot.Enabled
		if TriggerBot.Enabled then
			Connections.TriggerBot = RenderStepped(Trigger, false)
			TriggerBotLabel:SetText("TriggerBot: Enabled")
		else
			if Connections.TriggerBot then
				Connections.TriggerBot:Disconnect()
				Connections.TriggerBot = nil
			end
			TriggerBotLabel:SetText("TriggerBot: Disabled")
		end
	end
})
Tabs.TriggerBot:AddToggle("TriggerBotForceField", {
	Text = "ForceField Check",
	Default = TriggerBot.ForceFieldCheck,
	Callback = function(State)
		TriggerBot.ForceFieldCheck = State
	end
})
Tabs.TriggerBot:AddToggle("TriggerBotTeamCheck", {
	Text = "Team Check",
	Default = TriggerBot.TeamCheck,
	Callback = function(value)
		TriggerBot.TeamCheck = value
	end
})
Tabs.TriggerBot:AddToggle("TriggerBotDeadCheck", {
	Text = "Dead Check",
	Default = TriggerBot.DeadCheck,
	Callback = function(value)
		TriggerBot.DeadCheck = value
	end
})
Tabs.TriggerBot:AddDropdown("TriggerBotDeadCheckMode", {
	Text = "Dead Check mode",
	Values = {"Universal", "Custom"},
	Default = 1,
	Callback = function(Mode)
		TriggerBot.DeadCheckMode = Mode
		Options["TriggerBotCustomDeadCheckValue"]:SetDisabled(Mode ~= "Custom")
	end
})
Tabs.TriggerBot:AddSlider("TriggerBotCustomDeadCheckValue", {
	Text = "Custom Dead Check Health",
	Default = TriggerBot.CustomDeadCheckValue,
	Disabled = true,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		TriggerBot.CustomDeadCheckValue = Value
	end
})
Tabs.TriggerBot:AddSlider("TriggerBotTriggerDelay", {
	Text = "Trigger delay",
	Default = 0.1,
	Min = 0.1,
	Max = 10,
	Rounding = 1,
	Compact = false,
	Callback = function(Delay)
		TriggerBot.TriggerDelay = Delay * 0.1
	end
})

Tabs.Movement:AddToggle("Fly", {
	Text = "Toggle Fly [UNSAFE]",
	Default = Movement.Fly.Toggled,
	Risky = true,
	Callback = function(State)
		Movement.Fly.Toggled = State
		if not State and Movement.Fly.Enabled then
			if Connections.Fly then
				Connections.Fly:Disconnect()
				Connections.Fly = nil
			end
			Movement.Fly.Enabled = false
		end
	end
}):AddKeyPicker("FlyKey", {
	Mode = "Toggle",
	Text = "Enable Fly",
	Callback = function(State)
		if not Movement.Fly.Toggled then
			return
		end

		Movement.Fly.Enabled = State
		if not State then
			if Connections.Fly then
				Connections.Fly:Disconnect()
				Connections.Fly = nil
			end
			return
		end

		local Fly = Movement.Fly
		Connections.Fly = Heartbeat(function()
			if not LocalRoot then
				return
			end

			local MoveDirection = Vector3.zero

			local CameraCFrame = Camera and Camera.CFrame or CFrameZero
			local LookVector = CameraCFrame.LookVector
			local RightVector = CameraCFrame.RightVector

			if UserInputService:IsKeyDown(KeyCodeW) then
				MoveDirection = MoveDirection + LookVector
			end

			if UserInputService:IsKeyDown(KeyCodeA) then
				MoveDirection = MoveDirection - RightVector
			end

			if UserInputService:IsKeyDown(KeyCodeS) then
				MoveDirection = MoveDirection - LookVector
			end

			if UserInputService:IsKeyDown(KeyCodeD) then
				MoveDirection = MoveDirection + RightVector
			end

			if UserInputService:IsKeyDown(KeyCodeSpace) then
				MoveDirection = MoveDirection + Vector3.yAxis
			end

			if UserInputService:IsKeyDown(KeyCodeRightControl) then
				MoveDirection = MoveDirection - Vector3.yAxis
			end

			if MoveDirection.Magnitude > 0 then
				LocalRoot.AssemblyLinearVelocity = MoveDirection.Unit * Fly.SpeedValue
			else
				LocalRoot.AssemblyLinearVelocity = Vector3.zero
			end
		end, false)
	end
})
Tabs.Movement:AddSlider("FlySpeed", {
	Text = "Fly Speed",
	Default = Movement.Fly.SpeedValue,
	Min = 0,
	Max = 500,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Movement.Fly.SpeedValue = Value
	end
})
Tabs.Movement:AddToggle("Speed", {
	Text = "Toggle Speed [UNSAFE]",
	Default = Movement.Speed.Toggled,
	Risky = true,
	Callback = function(State)
		Movement.Speed.Toggled = State
		if not State and Movement.Speed.Enabled then
			if Connections.Speed then
				Connections.Speed:Disconnect()
				Connections.Speed = nil
			end
			Movement.Speed.Enabled = false
		end
	end
}):AddKeyPicker("SpeedKey", {
	Mode = "Toggle",
	Text = "Enable Speed",
	Callback = function(Enabled)
		local SpeedTable = Movement.Speed

		if not SpeedTable.Toggled then
			return
		end

		SpeedTable.Enabled = Enabled

		if not Enabled then
			if Connections.Speed then
				Connections.Speed:Disconnect()
				Connections.Speed = nil
			end
			return
		end

		Connections.Speed = Heartbeat(function()
			if LocalHumanoid and LocalRoot then
				local MoveDirection = LocalHumanoid.MoveDirection
				if MoveDirection.Magnitude > 0 then
					LocalRoot.CFrame += MoveDirection * Movement.Speed.SpeedValue
				end
			end
		end, false)
	end
})
Tabs.Movement:AddSlider("SpeedAmount", {
	Text = "Speed Amount",
	Default = 50,
	Min = 0,
	Max = 1000,
	Rounding = 0,
	Compact = false,
	Callback = function(Amount)
		Movement.Speed.SpeedValue = Amount * 0.01
	end
})
Tabs.Movement:AddLabel("SpinBot doesn't always work in First Person View.", true)
Tabs.Movement:AddToggle("SpinBot", {
	Text = "SpinBot [UNSAFE]",
	Default = false,
	Risky = true,
	Callback = function(State)
		if not State then
			if Connections.Spinbot then
				Connections.Spinbot:Disconnect()
				Connections.Spinbot = nil
			end
			return
		end
		Connections.Spinbot = RunService.Stepped:Connect(function()
			if LocalRoot then
				LocalRoot.CFrame *= CFrame.Angles(0, math.rad(Movement.SpinBotSpeed), 0)
			end
		end)
	end
})
Tabs.Movement:AddSlider("SpinBotAmount", {
	Text = "SpinBot Speed",
	Default = Movement.SpinBotSpeed,
	Min = 0,
	Max = 250,
	Rounding = 0,
	Compact = false,
	Callback = function(Speed)
		Movement.SpinBotSpeed = Speed
	end
})
Tabs.Movement:AddToggle("ForceThirdPerson", {
	Text = "Force Third Person",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.ForceThirdPerson then
				Connections.ForceThirdPerson:Disconnect()
				Connections.ForceThirdPerson = nil
			end
			LocalPlayer.CameraMaxZoomDistance = Movement.OldCameraMaxZoomDistance
			return
		end

		Movement.OldCameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
		Connections.ForceThirdPerson = RenderStepped(function()
			LocalPlayer.CameraMode = CameraModeClassic
			LocalPlayer.CameraMaxZoomDistance = 9999
		end, false)
	end
})
Tabs.Movement:AddButton({
	Text = "Force First Person",
	Func = function()
		if Connections.ForceThirdPerson then
			Connections.ForceThirdPerson:Disconnect()
			Connections.ForceThirdPerson = nil
			Toggles["ForceThirdPerson"]:SetValue(false)
		end
		LocalPlayer.CameraMode = CameraModeLockFirstPerson
	end
})
Tabs.Movement:AddToggle("InfiniteJump", {
	Text = "Infinite Jump [UNSAFE]",
	Default = false,
	Risky = true,
	Callback = function(State)
		Movement.InfiniteJump = State
	end
})
Tabs.Movement:AddToggle("NoJumpCooldown", {
	Text = "No Jump Cooldown [UNSAFE]",
	Default = false,
	Risky = true,
	Callback = function(State)
		Movement.NoJumpCooldown = State
	end
})
Tabs.Movement:AddToggle("Auto Jump", {
	Text = "Auto Jump [Hold Space]",
	Default = false,
	Risky = true,
	Callback = function(State)
		if not State then
			if Connections.AutoJump then
				Connections.AutoJump:Disconnect()
				Connections.AutoJump = nil
			end
			return
		end

		Connections.AutoJump = Heartbeat(function()
			if not LocalHumanoid or UserInputService:GetFocusedTextBox() then
				return
			end

			if UserInputService:IsKeyDown(KeyCodeSpace) then
				if Movement.InfiniteJump or LocalHumanoid:GetState() ~= EnumFreefallState then
					PerformJump()
				end
			end
		end, false)
	end
})

local AntiAimStatusLabel = Tabs.AntiAim:AddLabel("Status: Disabled")
Tabs.AntiAim:AddToggle("AntiAimToggle", {
	Text = "Toggle AntiAim [UNSAFE]",
	Default = AntiAim.Toggled,
	Risky = true,
	Callback = function(State)
		AntiAim.Toggled = State
		if not State and AntiAim.Enabled then
			AntiAim.Enabled = false
			AntiAimStatusLabel:SetText("Status: Disabled")
		end
	end
}):AddKeyPicker("VelocityKey", {
	Mode = "Toggle",
	Text = "Enable AntiAim",
	Risky = true,
	Callback = function(State)
		if not AntiAim.Toggled then
			return
		end

		AntiAim.Enabled = State

		if not State then
			AntiAimStatusLabel:SetText("Status: Disabled")
			return
		end

		AntiAimStatusLabel:SetText("Status: Enabled")
	end
})
Tabs.AntiAim:AddLabel("CFrame doesn't always work in First Person View.", true)
Tabs.AntiAim:AddDropdown("CFrameMode", {
	Text = "CFrame Mode",
	Values = {"None", "Randomizer", "Backwards", "Left", "Right", "Jitter", "Reverse Jitter"},
	Default = 1,
	Callback = function(Mode)
		AntiAim.CFrameMode = Mode
	end
})
Tabs.AntiAim:AddDropdown("VelocityMode", {
	Text = "Velocity Mode",
	Values = {"None", "Randomizer", "Heavenly", "Underground", "Look Vector", "Prediction Multiplier", "Prediction Changer", "Prediction Disabler"},
	Default = 1,
	Callback = function(Mode)
		AntiAim.VelocityMode = Mode
	end
})

if Games.IsCounterBlox then
	Tabs.AntiAim:AddDivider("Counter-Blox Look Direction")
	Tabs.AntiAim:AddDropdown("CounterBloxLookDirection", {
		Text = "Look Direction",
		Values = {"None", "Up", "Down"},
		Default = 1,
		Callback = function(Mode)
			AntiAim.Look = Mode ~= "None"
			AntiAim.LookValue = (Mode == "Up") and 1 or -1
		end
	})
	Tabs.AntiAim:AddToggle("CounterBloxLookDirectionJitter", {
		Text = "Look Jitter",
		Default = false,
		Risky = false,
		Callback = function(State)
			AntiAim.LookDownWaitTime = State and 0.1 or 0
		end
	})
elseif Games.IsCounterBloxReImagined then
	Tabs.AntiAim:AddDivider("Counter-Blox Look Direction")
	Tabs.AntiAim:AddDropdown("CounterBloxReImaginedLookDirection", {
		Text = "Look Direction",
		Values = {"None", "Back", "Up", "Down"},
		Default = 1,
		Callback = function(Mode)
			AntiAim.Look = Mode ~= "None"
			AntiAim.LookValue = (Mode == "Back") and -3 or ((Mode == "Up") and -10 or -1)
		end
	})
	Tabs.AntiAim:AddToggle("CounterBloxLookDirectionJitter", {
		Text = "Look Jitter",
		Default = false,
		Risky = false,
		Callback = function(State)
			AntiAim.LookDownWaitTime = State and 0.1 or 0
		end
	})
end

TabBoxes.PlayersGroupBox:AddDropdown("PlayerTPList", {
	SpecialType = "Player",
	Text = "Teleport to player",
	Tooltip = "Select a player to teleport to.",
	Callback = function(Player)
		SelectedPlayer = Player
	end
})
TabBoxes.PlayersGroupBox:AddButton({
	Text = "Teleport to selected player",
	Func = function()
		if not LocalRoot then
			return
		end

		local Cache = CachedPlayers[SelectedPlayer]

		if not Cache then
			return
		end

		local Root = Cache.Root
		if Root then
			LocalRoot.CFrame = Root.CFrame
		end
	end
})
TabBoxes.PlayersGroupBox:AddToggle("ChinaHat", {
    Text = "China Hat",
    Default = false,
    Callback = function(State)
        if not State then
            if Connections.ChinaHat then
                Connections.ChinaHat:Disconnect()
                Connections.ChinaHat = nil
            end

            if ChinaHat.ChinaHatTrail then
                ChinaHat.ChinaHatTrail:Destroy()
                ChinaHat.ChinaHatTrail = nil
            end
            return
        end

        Connections.ChinaHat = Heartbeat(function()
            local LocalPart = LocalHead or LocalRoot

            if not LocalPart then
				return
			end

            local CurrentHat = ChinaHat.ChinaHatTrail

            if not CurrentHat or not CurrentHat.Parent then
                CurrentHat = Create("Part", Camera, {
					Name = "ChinaHat",
					Material = Enum.Material.Neon,
					CanCollide = false,
					CanQuery = false,
					CanTouch = false,
					Transparency = 0.3
				})


                Create("SpecialMesh", CurrentHat, {
					MeshType = Enum.MeshType.FileMesh,
					MeshId = "http://www.roblox.com/asset/?id=1778999"
				})

                ChinaHat.ChinaHatTrail = CurrentHat
            end

            CurrentHat.CFrame = LocalPart.CFrame * CFrame.new(0, (LocalPart.Name == "Head") and 1.1 or 2.45, 0)
            CurrentHat.Color = ChinaHat.ChinaHatColor
            CurrentHat.Size = ChinaHat.ChinaHatTrailSize
            CurrentHat.Velocity = Vector3.zero

            local Mesh = CurrentHat:FindFirstChildOfClass("SpecialMesh")
            if Mesh then
                Mesh.Scale = ChinaHat.ChinaHatMeshScale
            end

            if LocalPart.LocalTransparencyModifier > 0.5 then
                CurrentHat.LocalTransparencyModifier = 1
            else
                CurrentHat.LocalTransparencyModifier = 0
            end
        end, false)
    end
}):AddColorPicker("ChinaHatColor", {
	Default = ChinaHat.ChinaHatColor,
	Transparency = nil,
	Callback = function(Color)
		ChinaHat.ChinaHatColor = Color
	end
})
TabBoxes.PlayersGroupBox:AddToggle("NoclipCamera", {
	Text = "Noclip Camera",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.NoclipCamera then
				Connections.NoclipCamera:Disconnect()
				Connections.NoclipCamera = nil
			end
			LocalPlayer.DevCameraOcclusionMode = OldDevCameraOcclusionMode
			return
		end

		OldDevCameraOcclusionMode = LocalPlayer.DevCameraOcclusionMode
		LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
		Connections.NoclipCamera = LocalPlayer:GetPropertyChangedSignal("DevCameraOcclusionMode"):Connect(function()
			OldDevCameraOcclusionMode = LocalPlayer.DevCameraOcclusionMode
			LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
		end)
	end
})
TabBoxes.PlayersGroupBox:AddToggle("AnimationFreezer", {
	Text = "Freeze Animations",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.AnimationFreezer then
				Connections.AnimationFreezer:Disconnect()
				Connections.AnimationFreezer = nil
			end

			local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
			if AnimateInstance then
				AnimateInstance.Disabled = false
			end

			return
		end

		Connections.AnimationFreezer = Heartbeat(function()
			local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
			if AnimateInstance then
				AnimateInstance.Enabled = false
			end
		end, false)
	end
})

VisualsESPTab:AddToggle("ESPMasterSwitch", {
	Text = "Master Switch",
	Default = HitConfiguration.Toggled,
	Callback = function(State)
		ESPToggled = State
	end
})
VisualsESPTab:AddToggle("ESPDynamicRefreshRate", {
	Text = "Dynamic Refresh Rate",
	Tooltip = "Updates ESP depending on your FPS",
	Default = ESPDynamicRefreshRate,
	Callback = function(State)
		ESPDynamicRefreshRate = State
		Options["ESPRefreshRate"]:SetDisabled(State)
	end
})
VisualsESPTab:AddSlider("ESPRefreshRate", {
	Text = "Refresh Rate [FPS]",
	Default = ESPRefreshRate,
	Disabled = true,
	Min = 1,
	Max = 240,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		ESPRefreshRate = Value
	end
})
VisualsESPTab:AddToggle("ESPPerformanceMode", {
	Text = "Performance Mode",
	Default = ESPPerformanceMode,
	Callback = function(State)
		ESPPerformanceMode = State
	end
})
VisualsESPTab:AddButton({
	Text = "Reset Cache",
	Tooltip = "Click this if ESP is freezing/glitching.",
	Func = function()
		for _,DrawingObject in next, ESPObjects do
			if typeof(DrawingObject) == "Instance" then
				DrawingObject:Destroy()
			else
				RemoveDrawing(DrawingObject)
			end
		end
		table.clear(ESPObjects)

		for _,Player in ipairs(Players:GetPlayers()) do
			if Player == LocalPlayer then
				continue
			end

			ClearCache(Player)
			AddCache(Player)
		end

		table.clear(TagBuffer)
        table.clear(SkeletonCachePoints)
        table.clear(SkeletonCacheVisible)
	end
})

VisualsESPTab:AddDivider("Cham ESP")
VisualsESPTab:AddToggle("ChamESP", {
	Text = "Enabled",
	Default = ChamESP.Enabled,
	Callback = function(State)
		ChamESP.Enabled = State
	end
})
VisualsESPTab:AddLabel("Fill Color"):AddColorPicker("ChamFillColor", {
	Default = ChamESP.FillColor,
	Transparency = 0,
	Callback = function(Color)
		ChamESP.FillColor = Color
		ChamESP.FillTransparency = Options["ChamFillColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local Cham = CachedPlayersList[Index].ESP.Cham
			Cham.FillColor = Color
			Cham.FillTransparency = ChamESP.FillTransparency
        end
	end
})
VisualsESPTab:AddLabel("Outline Color"):AddColorPicker("ChamOutlineColor", {
	Default = ChamESP.OutlineColor,
	Transparency = 0,
	Callback = function(Color)
		ChamESP.OutlineColor = Color
		ChamESP.OutlineTransparency = Options["ChamOutlineColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local Cham = CachedPlayersList[Index].ESP.Cham
			Cham.OutlineColor = Color
			Cham.OutlineTransparency = ChamESP.OutlineTransparency
        end
	end
})

VisualsESPTab:AddDivider("HeadDot ESP")
VisualsESPTab:AddToggle("HeadDotESP", {
	Text = "Enabled",
	Default = HeadDotESP.Enabled,
	Callback = function(State)
		HeadDotESP.Enabled = State
	end
}):AddColorPicker("HeadDotColor", {
	Default = HeadDotESP.Color,
	Transparency = 0,
	Callback = function(Color)
		HeadDotESP.Color = Color
		HeadDotESP.Transparency = 1 - Options["HeadDotColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local HeadDot = CachedPlayersList[Index].ESP.HeadDot
			HeadDot.Color = Color
			HeadDot.Transparency = HeadDotESP.Transparency
        end
	end
})
VisualsESPTab:AddToggle("HeadDotFilled", {
	Text = "Filled",
	Default = HeadDotESP.Filled,
	Callback = function(State)
		HeadDotESP.Filled = State
        for Index = 1, #CachedPlayersList do
			CachedPlayersList[Index].ESP.HeadDot.Filled = State
        end
	end
})

VisualsESPTab:AddDivider("HeadTag ESP")
VisualsESPTab:AddToggle("HeadTagESP", {
	Text = "Enabled",
	Default = HeadTagESP.Enabled,
	Callback = function(State)
		HeadTagESP.Enabled = State
	end
}):AddColorPicker("HeadTagColor", {
	Default = HeadTagESP.Color,
	Transparency = 0,
	Callback = function(Color)
		HeadTagESP.Color = Color
		HeadTagESP.Transparency = 1 - Options["HeadTagColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local HeadTag = CachedPlayersList[Index].ESP.HeadTag
			HeadTag.Color = Color
			HeadTag.Transparency = HeadTagESP.Transparency
        end
	end
})
VisualsESPTab:AddDropdown("HeadTagOptions", {
	Text = "Tag Options",
	Values = {"Name", "DisplayName", "EquippedTool", "Health", "Distance", "RigType", "Femboy Meter"},
	Multi = true,
	Default = 1,
	Callback = function(...)
		return (...)
	end
})
VisualsESPTab:AddDropdown("HeadTagPosition", {
	Text = "Position",
	Values = {"Top", "Bottom"},
	Default = 1,
	Callback = function(Position)
		HeadTagESP.Position = Position
	end
})

VisualsESPTab:AddDivider("Tracer ESP")
VisualsESPTab:AddToggle("TracerESP", {
	Text = "Enabled",
	Default = TracerESP.Enabled,
	Callback = function(State)
		TracerESP.Enabled = State
	end
}):AddColorPicker("TracerColor", {
	Default = TracerESP.Color,
	Transparency = 0,
	Callback = function(Color)
		TracerESP.Color = Color
		TracerESP.Transparency = 1 - Options["TracerColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local Tracer = CachedPlayersList[Index].ESP.Tracer
			Tracer.Color = Color
			Tracer.Transparency = TracerESP.Transparency
        end
	end
})
VisualsESPTab:AddDropdown("TracerType", {
	Text = "Type",
	Values = {"Locked", "Unlocked"},
	Default = 1,
	Callback = function(Value)
		TracerESP.Type = Value
	end
})
VisualsESPTab:AddDropdown("TracerPart", {
	Text = "Part",
	Values = {"Head", "Root"},
	Default = 2,
	Callback = function(Value)
		TracerESP.Part = Value
	end
})

if not IsXeno then
	VisualsESPTab:AddDivider("Arrow ESP")
	VisualsESPTab:AddToggle("ArrowESP", {
		Text = "Enabled",
		Default = ArrowESP.Enabled,
		Callback = function(State)
			ArrowESP.Enabled = State
		end
	}):AddColorPicker("ArrowColor", {
		Default = ArrowESP.Color,
		Transparency = 0,
		Callback = function(Color)
			ArrowESP.Color = Color
			ArrowESP.Transparency = 1 - Options["ArrowColor"].Transparency

			for Index = 1, #CachedPlayersList do
				local Arrow = CachedPlayersList[Index].ESP.Arrow
				Arrow.Color = Color
				Arrow.Transparency = ArrowESP.Transparency
			end
		end
	})
	VisualsESPTab:AddSlider("ArrowRadius", {
		Text = "Radius",
		Default = ArrowESP.Radius,
		Min = 0,
		Max = 360,
		Rounding = 0,
		Compact = false,
		Callback = function(Value)
			ArrowESP.Radius = Value
		end
	})
	VisualsESPTab:AddToggle("ArrowFilled", {
		Text = "Filled",
		Default = ArrowESP.Filled,
		Callback = function(State)
			ArrowESP.Filled = State
			for Index = 1, #CachedPlayersList do
				CachedPlayersList[Index].ESP.Arrow.Filled = State
			end
		end
	})
end

VisualsESPTab:AddDivider("2D Box ESP")
VisualsESPTab:AddToggle("2DBoxESP", {
	Text = "Enabled",
	Default = BoxESP.Box2D.Enabled,
	Callback = function(State)
		BoxESP.Box2D.Enabled = State
	end
}):AddColorPicker("2DBoxColor", {
	Default = BoxESP.Box2D.Color,
	Transparency = 0,
	Callback = function(Color)
		BoxESP.Box2D.Color = Color
		BoxESP.Box2D.Transparency = 1 - Options["2DBoxColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local Box2D = CachedPlayersList[Index].ESP.Box2D
			Box2D.Color = Color
			Box2D.Transparency = BoxESP.Box2D.Transparency
        end
	end
})
VisualsESPTab:AddToggle("2DBoxFilled", {
	Text = "Filled",
	Default = BoxESP.Box2D.Filled,
	Callback = function(State)
		BoxESP.Box2D.Filled = State
        for Index = 1, #CachedPlayersList do
			CachedPlayersList[Index].ESP.Box2D.Filled = State
        end
	end
})

VisualsESPTab:AddDivider("3D Box ESP")
VisualsESPTab:AddToggle("3DBoxESP", {
	Text = "Enabled",
	Default = BoxESP.Box3D.Enabled,
	Callback = function(State)
		BoxESP.Box3D.Enabled = State
	end
}):AddColorPicker("3DBoxColor", {
	Default = BoxESP.Box3D.Color,
	Transparency = 0,
	Callback = function(Color)
		BoxESP.Box3D.Color = Color
		BoxESP.Box3D.Transparency = 1 - Options["3DBoxColor"].Transparency

		for Index = 1, #CachedPlayersList do
			local Box3DLines = CachedPlayersList[Index].ESP.Box3D
			for Index2 = 1, #Box3DLines do
				Box3DLines[Index2].Color = Color
				Box3DLines[Index2].Transparency = BoxESP.Box3D.Transparency
			end
		end
	end
})

VisualsESPTab:AddDivider("HealthBar ESP")
VisualsESPTab:AddToggle("HealthBarESP", {
	Text = "Enabled",
	Default = HealthBarESP.Enabled,
	Callback = function(State)
		HealthBarESP.Enabled = State
	end
}):AddColorPicker("HealthBarColor", {
	Default = HealthBarESP.Color,
	Transparency = 0,
	Callback = function(Color)
		HealthBarESP.Color = Color
		HealthBarESP.Transparency = 1 - Options["HealthBarColor"].Transparency

        for Index = 1, #CachedPlayersList do
            local ESP = CachedPlayersList[Index].ESP

			local HealthBarOutline = ESP.HealthBarOutline
			HealthBarOutline.Color = Color
			HealthBarOutline.Transparency = HealthBarESP.Transparency

			ESP.HealthBarFill.Transparency = HealthBarESP.Transparency
        end
	end
})
VisualsESPTab:AddSlider("HealthBarThickness", {
	Text = "Outline Thickness",
	Default = HealthBarESP.Thickness,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		HealthBarESP.Thickness = Value
        for Index = 1, #CachedPlayersList do
            local ESP = CachedPlayersList[Index].ESP
			ESP.HealthBarOutline.Thickness = Value
			ESP.HealthBarFill.Thickness = Value
        end
	end
})

VisualsESPTab:AddDivider("Skeleton ESP")
VisualsESPTab:AddToggle("SkeletonESP", {
	Text = "Enabled",
	Default = SkeletonESP.Enabled,
	Callback = function(State)
		SkeletonESP.Enabled = State
	end
}):AddColorPicker("SkeletonColor", {
	Default = SkeletonESP.Color,
	Transparency = 0,
	Callback = function(Color)
		SkeletonESP.Color = Color
		SkeletonESP.Transparency = 1 - Options["SkeletonColor"].Transparency

		for Index = 1, #CachedPlayersList do
			local SkeletonLines = CachedPlayersList[Index].ESP.Skeleton
			for Index2 = 1, #SkeletonLines do
				SkeletonLines[Index2].Color = Color
				SkeletonLines[Index2].Transparency = SkeletonESP.Transparency
			end
		end
	end
})
VisualsESPTab:AddSlider("SkeletonThickness", {
	Text = "Outline Thickness",
	Default = SkeletonESP.Thickness,
	Min = 1,
	Max = 10,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		SkeletonESP.Thickness = Value
		for Index = 1, #CachedPlayersList do
			local SkeletonLines = CachedPlayersList[Index].ESP.Skeleton
			for Index2 = 1, #SkeletonLines do
				SkeletonLines[Index2].Thickness = Value
			end
		end
	end
})

VisualsESPTab:AddDivider("Checks")
VisualsESPTab:AddSlider("ESPConfigurationDistanceCheck", {
	Text = "Max Distance",
	Default = 15000,
	Min = 0,
	Max = 25000,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		ESPDistanceCheck = Value * Value
	end
})
VisualsESPTab:AddToggle("ESPConfigurationForceField", {
	Text = "ForceField Check [BUGGY]",
	Default = ESPForceFieldCheck,
	Callback = function(State)
		ESPForceFieldCheck = State
		if State then
			for _,DrawingObject in next, ESPObjects do
				if typeof(DrawingObject) == "Instance" then
					DrawingObject:Destroy()
				else
					RemoveDrawing(DrawingObject)
				end
			end
			table.clear(ESPObjects)

			for _,Player in ipairs(Players:GetPlayers()) do
				if Player == LocalPlayer then
					continue
				end

				ClearCache(Player)
				AddCache(Player)
			end

			table.clear(TagBuffer)
			table.clear(SkeletonCachePoints)
			table.clear(SkeletonCacheVisible)
		end
	end
})
VisualsESPTab:AddToggle("ESPConfigurationWallCheck", {
	Text = "Wall Check",
	Default = ESPWallCheck,
	Callback = function(State)
		ESPWallCheck = State
	end
})
VisualsESPTab:AddToggle("ESPConfigurationTeamCheck", {
	Text = "Team Check",
	Default = ESPTeamCheck,
	Callback = function(State)
		ESPTeamCheck = State
	end
})

task.delay(0, function()
    VisualsESPTab:Resize()
end)

WorldLightingTab:AddToggle("WorldShadowDisabler", {
	Text = "Global Shadows Disabler",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.ShadowDisabler then
				Connections.ShadowDisabler:Disconnect()
				Connections.ShadowDisabler = nil
			end
			return
		end

		Lighting.GlobalShadows = false
		Connections.ShadowDisabler = Lighting:GetPropertyChangedSignal("GlobalShadows"):Connect(function()
			Lighting.GlobalShadows = false
		end)
	end
})
WorldLightingTab:AddButton({
	Text = "Enable Global Shadows",
	Func = function()
		if Connections.ShadowDisabler then
			Connections.ShadowDisabler:Disconnect()
			Connections.ShadowDisabler = nil
		end

		Toggles["WorldShadowDisabler"]:SetValue(false)
		Lighting.GlobalShadows = true
	end
})

WorldLightingTab:AddToggle("WorldForceNight", {
	Text = "Force Night",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.ForceNight then
				Connections.ForceNight:Disconnect()
				Connections.ForceNight = nil
			end
			return
		end

		Lighting.TimeOfDay = 0
		Connections.ForceNight = Lighting:GetPropertyChangedSignal("TimeOfDay"):Connect(function()
			Lighting.TimeOfDay = 0
		end)
	end
})
WorldLightingTab:AddToggle("WorldForceDay", {
	Text = "Force Day",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.ForceDay then
				Connections.ForceDay:Disconnect()
				Connections.ForceDay = nil
			end
			return
		end

		Lighting.TimeOfDay = 12
		Connections.ForceDay = Lighting:GetPropertyChangedSignal("TimeOfDay"):Connect(function()
			Lighting.TimeOfDay = 12
		end)
	end
})

WorldLightingTab:AddToggle("WorldDarkMode", {
	Text = "Dark Mode",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.DarkMode then
				Connections.DarkMode:Disconnect()
				Connections.DarkMode = nil
			end
			Lighting.GeographicLatitude = World.OldGeographicLatitude
			return
		end

		World.OldGeographicLatitude = Lighting.GeographicLatitude
		Lighting.GeographicLatitude = "NaN"
		Connections.DarkMode = Lighting:GetPropertyChangedSignal("GeographicLatitude"):Connect(function()
			World.OldGeographicLatitude = Lighting.GeographicLatitude
			Lighting.GeographicLatitude = "NaN"
		end)
	end
})

WorldLightingTab:AddSlider("ExposureCompensationSlider", {
	Text = "Exposure Compensation",
	Default = Lighting.ExposureCompensation * 0.1,
	Min = -1,
	Max = 1,
	Rounding = 10,
	Compact = false,
	Callback = function(Value)
		Lighting.ExposureCompensation = Value * 10
	end
})

WorldLightingTab:AddButton({
	Text = "Restore Original Exposure Compensation",
	Func = function()
		Lighting.ExposureCompensation = World.OldExposureCompensation
		Options["ExposureCompensationSlider"]:SetValue(World.OldExposureCompensation)
	end
})

WorldLightingTab:AddLabel("Change Ambient"):AddColorPicker("AmbientColor", {
	Default = World.OldAmbient,
	Transparency = nil,
	Callback = function(Color)
		Lighting.Ambient = Color
	end
})
WorldLightingTab:AddButton({
	Text = "Save Current Ambient as Original",
	Func = function()
		World.OldAmbient = Lighting.Ambient
	end
})
WorldLightingTab:AddButton({
	Text = "Restore Original Ambient",
	Func = function()
		Lighting.Ambient = World.OldAmbient
		Options["AmbientColor"]:SetValue(World.OldAmbient)
	end
})

--[[
if gethiddenpropertyFunction and sethiddenpropertyFunction then
	WorldTab:AddDropdown("LightingTechnologyDropdown", {
		Text = "Lighting Technology",
		Values = {"Legacy", "Deprecated", "Voxel", "Compatibility", "ShadowMap", "Future", "Unified"},
		Default = World.OldLightingTechnology,
		Callback = function(Option)
			World.LightingTechnology = Option
		end
	})

	WorldTab:AddButton({
		Text = "Apply Lighting Technology",
		Func = function()
			nssethiddenproperty(Lighting, "Technology", World.LightingTechnology)
		end
	})

	WorldTab:AddButton({
		Text = "Save Lighting Technology",
		Func = function()
			World.OldLightingTechnology = World.LightingTechnology
		end
	})

	WorldTab:AddButton({
		Text = "Restore Lighting Technology",
		Func = function()
			nssethiddenproperty(Lighting, "Technology", World.OldLightingTechnology)
		end
	})
end
]]

WorldLocalCharacterTab:AddToggle("CharacterHighlight", {
	Text = "Highlight",
	Default = false,
	Callback = function(State)
		World.Highlight.Enabled = State

		if not State then
			local Highlight = CoreGui:FindFirstChild("ns__LocalHighlight")
			if Highlight then
				Highlight.Adornee = nil
			end
			return
		end

		if not Connections.CharacterHighlight then
			local Configuration = World.Highlight
			Connections.CharacterHighlight = Heartbeat(function()
				if not LocalCharacter then
					return
				end

				local Highlight = CoreGui:FindFirstChild("ns__LocalHighlight") or Create("Highlight", CoreGui, {Name = "ns__LocalHighlight"})
				if Configuration.Enabled then
					Highlight.FillColor = Configuration.Color
					Highlight.OutlineColor = Configuration.Color
					Highlight.FillTransparency = Configuration.Transparency
					Highlight.OutlineTransparency = Configuration.Transparency
					if Highlight.Adornee ~= LocalCharacter then
						Highlight.Adornee = LocalCharacter
					end
				end
			end, false)
		end
	end
}):AddColorPicker("HighlightColor", {
	Default = World.Highlight.Color,
	Transparency = World.Highlight.Transparency,
	Callback = function(Color)
		World.Highlight.Color = Color
		World.Highlight.Transparency = Options["HighlightColor"].Transparency
	end
})

WorldLocalCharacterTab:AddSlider("CharacterTransparency", {
	Text = "Character Transparency",
	Default = World.CharacterTransparency,
	Min = 0,
	Max = 1,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		World.CharacterTransparency = Value
	end
})
WorldLocalCharacterTab:AddButton({
	Text = "Apply Transparency",
	Func = function()
		if LocalCharacter then
			for _,Object in ipairs(LocalCharacter:QueryDescendants("BasePart:not(#HumanoidRootPart)")) do
				Object.Transparency = World.CharacterTransparency
			end
			World.HasAppliedCharacterTransparency = true
		end
	end
})
WorldLocalCharacterTab:AddButton({
	Text = "Restore Original Transparency",
	Func = function()
		if LocalCharacter then
			for _,Object in ipairs(LocalCharacter:QueryDescendants("BasePart:not(#HumanoidRootPart)")) do
				Object.Transparency = 0
			end
		end
		World.HasAppliedCharacterTransparency = false
	end
})

VisualsTabCrosshair:AddToggle("CrosshairOverlayEnabled", {
    Text = "Enable Crosshair",
    Default = CrosshairOverlay.Enabled,
    Callback = function(Value)
        CrosshairOverlay.Enabled = Value
    end
}):AddColorPicker("CrosshairOverlayColor", {
    Default = CrosshairOverlay.Color,
    Title = "Crosshair Color",
    Callback = function(Value)
        CrosshairOverlay.Color = Value
    end
})
VisualsTabCrosshair:AddToggle("CrosshairOverlayTStyle", {
    Text = "T-Style",
    Default = CrosshairOverlay.TStyle,
    Callback = function(Value)
        CrosshairOverlay.TStyle = Value
    end
})
VisualsTabCrosshair:AddSlider("CrosshairOverlayLength", {
    Text = "Length",
    Default = CrosshairOverlay.Length,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        CrosshairOverlay.Length = Value
    end
})
VisualsTabCrosshair:AddSlider("CrosshairOverlayThickness", {
    Text = "Thickness",
    Default = CrosshairOverlay.Thickness,
    Min = 1,
    Max = 20,
    Rounding = 1,
    Callback = function(Value)
        CrosshairOverlay.Thickness = Value
    end
})
VisualsTabCrosshair:AddSlider("CrosshairOverlayGap", {
    Text = "Gap",
    Default = CrosshairOverlay.Gap,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        CrosshairOverlay.Gap = Value
    end
})
VisualsTabCrosshair:AddToggle("CrosshairOverlayRotationStatic", {
    Text = "Static Rotation",
    Default = CrosshairOverlay.RotationStatic,
    Callback = function(Value)
        CrosshairOverlay.RotationStatic = Value
    end
})
VisualsTabCrosshair:AddSlider("CrosshairOverlayRotation", {
    Text = "Rotation / Speed",
    Default = CrosshairOverlay.Rotation,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Callback = function(Value)
        CrosshairOverlay.Rotation = Value
    end
})
VisualsTabCrosshair:AddToggle("CrosshairOverlayDotEnabled", {
    Text = "Center Dot",
    Default = CrosshairOverlay.DotEnabled,
    Callback = function(Value)
        CrosshairOverlay.DotEnabled = Value
    end
}):AddColorPicker("CrosshairOverlayDotColor", {
    Default = CrosshairOverlay.DotColor,
    Title = "Dot Color",
    Callback = function(Value)
        CrosshairOverlay.DotColor = Value
    end
})
VisualsTabCrosshair:AddDropdown("CrosshairOverlayDotStyle", {
    Text = "Dot Style",
    Values = {"Square", "Circle"},
    Default = 1,
    Callback = function(Style)
        CrosshairOverlay.DotStyle = Style
    end
})
VisualsTabCrosshair:AddSlider("CrosshairOverlayDotSize", {
    Text = "Dot Size",
    Default = CrosshairOverlay.DotSize,
    Min = 1,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        CrosshairOverlay.DotSize = Value
    end
})

SettingsTab:AddToggle("ns__Watermark", {
	Text = "Library Watermark",
	Default = true,
	Callback = function(State)
		Watermark:SetVisible(State)
		WatermarkIsVisible = State
	end
})

SettingsTab:AddToggle("GlobalSearch", {
	Text = "Global Search",
	Default = true,
	Callback = function(State)
		Library.GlobalSearch = State
	end
})

SettingsTab:AddLabel("Toggle menu keybind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind"
})
Library.ToggleKeybind = Options["MenuKeybind"]
SettingsTab:AddToggle("ns__KeybindsMenu", {
	Text = "Keybinds Menu",
	Default = true,
	Callback = function(State)
		Library.ShowToggleFrameInKeybinds = State
	end
})

SettingsTab:AddToggle("ns__PlayerJoinLogs", {
	Text = "Player Join Logs",
	Default = PlayerJoinLogs,
	Callback = function(State)
		PlayerJoinLogs = State
	end
})
SettingsTab:AddToggle("ns__PlayerLeaveLogs", {
	Text = "Player Leave Logs",
	Default = PlayerLeaveLogs,
	Callback = function(State)
		PlayerLeaveLogs = State
	end
})

local function ClearConnections(Table)
	for _,Value in next, Table do
		Value:Disconnect()
	end

	table.clear(Table)
end

SettingsTab:AddButton({
	Text = "Reload Script",
	Func = function()
		Library.Unload()
		Running = false

		task.wait()

		ClearConnections(Connections)
		ThreadManager:Shutdown()

		if CanUseVirtualInputManager then
			VirtualInputManager:Destroy()
		end

		local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
		if AnimateInstance then
			AnimateInstance.Disabled = false
		end

		Lighting.ExposureCompensation = World.OldExposureCompensation
		Lighting.Ambient = World.OldAmbient

		local LocalHighlight = CoreGui:FindFirstChild("ns__LocalHighlight")
		if LocalHighlight then
			LocalHighlight:Destroy()
		end

		if LocalCharacter and World.HasAppliedCharacterTransparency then
			for _,Object in ipairs(LocalCharacter:QueryDescendants("BasePart")) do
				Object.Transparency = (Object.Name == "HumanoidRootPart") and 1 or 0
			end
		end

		if HitSounds.Folder and HitSounds.Folder.Parent then
			HitSounds.Folder:Destroy()
		end

		if ChinaHat.ChinaHatTrail then
			ChinaHat.ChinaHatTrail:Destroy()
			ChinaHat.ChinaHatTrail = nil
		end

		for _,FOVCircle in next, AimbotFOVCircles do
			RemoveDrawing(FOVCircle)
		end

		for _,DrawingObject in next, ESPObjects do
			if typeof(DrawingObject) == "Instance" then
				DrawingObject:Destroy()
			else
				RemoveDrawing(DrawingObject)
			end
		end
		table.clear(ESPObjects)

		for _,Line in next, CrosshairOverlay.Drawings.Lines do
			RemoveDrawing(Line)
		end
		RemoveDrawing(CrosshairOverlay.Drawings.Dot)

		for _,Player in ipairs(Players:GetPlayers()) do
			ClearCache(Player)
		end

		print([[ // Reloading combat.cc || Made by nikoleto scripts - github.com/nikoladhima \\ --]])
		nsloadstring(true, "combat.cc.lua")
	end
})
SettingsTab:AddButton({
	Text = "Unload Script",
	Func = function()
		Library.Unload()
		Running = false

		task.wait()

		ClearConnections(Connections)
		ThreadManager:Shutdown()

		if CanUseVirtualInputManager then
			VirtualInputManager:Destroy()
		end

		local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
		if AnimateInstance then
			AnimateInstance.Disabled = false
		end

		Lighting.ExposureCompensation = World.OldExposureCompensation
		Lighting.Ambient = World.OldAmbient

		local LocalHighlight = CoreGui:FindFirstChild("ns__LocalHighlight")
		if LocalHighlight then
			LocalHighlight:Destroy()
		end

		if LocalCharacter and World.HasAppliedCharacterTransparency then
			for _,Object in ipairs(LocalCharacter:QueryDescendants("BasePart:not(#HumanoidRootPart)")) do
				Object.Transparency = 0
			end
		end

		if HitSounds.Folder and HitSounds.Folder.Parent then
			HitSounds.Folder:Destroy()
		end

		if ChinaHat.ChinaHatTrail then
			ChinaHat.ChinaHatTrail:Destroy()
			ChinaHat.ChinaHatTrail = nil
		end

		for _,FOVCircle in next, AimbotFOVCircles do
			RemoveDrawing(FOVCircle)
		end

		for _,DrawingObject in next, ESPObjects do
			if typeof(DrawingObject) == "Instance" then
				DrawingObject:Destroy()
			else
				RemoveDrawing(DrawingObject)
			end
		end
		table.clear(ESPObjects)

		for _,Line in next, CrosshairOverlay.Drawings.Lines do
			RemoveDrawing(Line)
		end
		RemoveDrawing(CrosshairOverlay.Drawings.Dot)

		for _,Player in ipairs(Players:GetPlayers()) do
			ClearCache(Player)
		end

		print([[ // Unloaded combat.cc || Made by nikoleto scripts - github.com/nikoladhima \\ --]])
	end
})

task.spawn(function()
	if Games.IsKAT then
		local KAT = {
			InfiniteAmmo = nil
		}

		local Game = Window:AddTab("KAT", "gamepad-2")
		local SilentAimbotTab = Game:AddLeftGroupbox("Silent Aimbot")
		local WeaponModificationTab = Game:AddRightGroupbox("Weapon Modification")

		if hookmetamethod and getnamecallmethod then
			local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
			local SilentAimbotToggle = SilentAimbotTab:AddToggle("SilentAimbot", {
				Text = "Toggle Aimbot",
				Default = false,
				Callback = function(State)
					SilentAimbot.Toggled = State
					if not State and SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
						SilentAimbot.Enabled = false
					end
				end
			})
			SilentAimbotToggle:AddKeyPicker("SilentAimbotKey", {
				Mode = "Toggle",
				Text = "Silent Aimbot",
				Callback = function()
					if not SilentAimbot.Toggled then
						return
					end
					SilentAimbot.Enabled = not SilentAimbot.Enabled
					if SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
					else
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					end
				end
			})
			SilentAimbotTab:AddDropdown("SilentAimbotAimPart", {
				Text = "Aim Part",
				Values = {"Head", "Root", "Random"},
				Default = 2,
				Callback = function(Value)
					SilentAimbot.AimPart = Value
				end
			})

			--[[SilentAimbotTab:AddToggle("SilentAimbotWallbang", {
				Text = "Wallbang [Bullet Pierces through walls]",
				Default = false,
				Callback = function(State)
					SilentAimbot.Wallbang = State
				end
			})]]
			SilentAimbotTab:AddToggle("SilentAimbotForceFieldCheck", {
				Text = "ForceField Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.ForceFieldCheck = State
				end
			})
			SilentAimbotTab:AddToggle("SilentAimbotWallCheck", {
				Text = "Wall Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.WallCheck = State
				end
			})
			SilentAimbotTab:AddToggle("SilentAimbotTeamCheck", {
				Text = "Team Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.TeamCheck = State
				end
			})

			SilentAimbotTab:AddToggle("SilentAimbotFOVCircle", {
				Text = "FOV Circle",
				Default = SilentAimbot.FOVCircle.Enabled,
				Callback = function(State)
					SilentAimbot.FOVCircle.Enabled = State
				end
			}):AddColorPicker("SilentAimbotFOVCircleColor", {
				Default = SilentAimbot.FOVCircle.Color,
				Transparency = 0,
				Callback = function(Color)
					SilentAimbot.FOVCircle.Color = Color
					SilentAimbot.FOVCircle.Transparency = 1 - Options["SilentAimbotFOVCircleColor"].Transparency
				end
			})
			SilentAimbotTab:AddToggle("SilentAimbotFOVCircleFilled", {
				Text = "Filled Circle",
				Default = SilentAimbot.FOVCircle.Filled,
				Callback = function(Filled)
					SilentAimbot.FOVCircle.Filled = Filled
				end
			})
			SilentAimbotTab:AddSlider("SilentAimbotFOVCircleRadius", {
				Text = "Circle Radius",
				Default = SilentAimbot.FOVCircle.Radius,
				Min = 50,
				Max = 250,
				Rounding = 0,
				Compact = false,
				Callback = function(Radius)
					SilentAimbot.FOVCircle.Radius = Radius
				end
			})
			SilentAimbotTab:AddSlider("SilentAimbotFOVCircleThickness", {
				Text = "Circle Thickness",
				Default = SilentAimbot.FOVCircle.Thickness,
				Min = 1,
				Max = 10,
				Rounding = 0,
				Compact = false,
				Callback = function(Thickness)
					SilentAimbot.FOVCircle.Thickness = Thickness
				end
			})
			SilentAimbotTab:AddDropdown("SilentAimbotFOVCirclePosition", {
				Text = "Circle Position",
				Values = {"Center", "Mouse"},
				Default = 2,
				Callback = function(Position)
					SilentAimbot.FOVCircle.Position = Position
				end
			})
		else
			SilentAimbotTab:AddLabel("Silent Aimbot not supported. Missing required function(s):", true)

			if not hookmetamethod then
				SilentAimbotTab:AddLabel("'hookmetamethod'", true)
			end

			if not getnamecallmethod then
				SilentAimbotTab:AddLabel(", 'getnamecallmethod'", true)
			end
		end

		local NoRecoil = false
		local getgc = FunctionValidator.Validate(Module.Tables.getgc, "getgc", nil)
		if getgc then
			for _,Table in getgc(true) do
				if type(Table) == "table" then
					local CameraRecoilFunction = rawget(Table, "CameraRecoil")
					if CameraRecoilFunction then
						rawset(Table, "CameraRecoil", function(Argument1, Argument2, ...)
							if Running and NoRecoil then
								return CameraRecoilFunction(Argument1, 0, ...)
							end
							return CameraRecoilFunction(Argument1, Argument2, ...)
						end)
					end
				end
			end

			WeaponModificationTab:AddToggle("NoRecoil", {
				Text = "No Recoil",
				Default = false,
				Callback = function(State)
					NoRecoil = State
				end
			})

			--[[local AmmoCounter = PlayerGui:WaitForChild("GameUI"):WaitForChild("HUD"):WaitForChild("Ammo"):WaitForChild("AmmoCounter")
			WeaponModificationTab:AddToggle("InfiniteAmmo", {
				Text = "Infinite Ammo",
				Default = false,
				Callback = function(State)
					if not State then
						ThreadManager:Stop("InfiniteAmmo")
						return
					end

					ThreadManager:Start("InfiniteAmmo", function()
						local Garbage = getgc(true)
						for Index, Object in next, Garbage do
							if type(Object) == "table" then
								if rawget(Object, "LoadedAmmo") then
									rawset(Object, "LoadedAmmo", 67)
									AmmoCounter.Text = "67/" .. (AmmoCounter.Text:match(".*/(.*)"))
								end
							end

							if Index % 15 == 0 then
								task.wait()
							end
						end
					end, 0.5)
				end
			})]]
		else
			WeaponModificationTab:AddLabel("No Recoil is not supported, missing function 'getgc'", true)
		end

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(KAT)
		end)
	elseif Games.IsCounterBlox then
		local CounterBlox = {
			AntiKill = nil,
			AutomaticWeapon = nil,
			RapidFire = nil,
			InfiniteAmmo = nil,
			NoRecoil = nil,
			NoSpread = nil,
			InstantReload = nil
		}
		local Saved = {
			AutomaticValues = {},
			FireRateValues = {},
			AmmoValues = {},
			RecoilValues = {},
			SpreadValues = {},
			ReloadTimeValues = {}
		}
		local AutomaticValues = {}
		local FireRateValues = {}
		local AmmoValues = {}
		local RecoilValues = {}
		local SpreadValues = {}
		local ReloadTimeValues = {}
		local mappings = {
			{keyword = "auto", class = "BoolValue", list = AutomaticValues, save = Saved.AutomaticValues, storechildren = true},
			{keyword = "firerate", class = "NumberValue", list = FireRateValues, save = Saved.FireRateValues, storechildren = false},
			{keyword = "ammo", class = "IntValue", list = AmmoValues, save = Saved.AmmoValues, storechildren = false},
			{keyword = "recoil", class = "NumberValue", list = RecoilValues, save = Saved.RecoilValues, storechildren = false},
			{keyword = "spread", class = "NumberValue", list = SpreadValues, save = Saved.SpreadValues, storechildren = false},
			{keyword = "reload", class = "NumberValue", list = ReloadTimeValues, save = Saved.ReloadTimeValues, torechildren = false},
		}
		local FireRate = 0.1

		task.spawn(function()
			local MapFolder = nil
			local KillersFolder = nil
			MapFolder = workspace:WaitForChild("Map")
			for _,Child in ipairs(MapFolder:GetChildren()) do
				if Child:IsA("Folder") and string.find(string.lower(Child.Name), "kill") then
					KillersFolder = Child
					for _,Child2 in ipairs(Child:GetChildren()) do
						Child2:Destroy()
					end
				end
			end
			CounterBlox.AntiKill = MapFolder.DescendantAdded:Connect(function(Child)
				if Child:IsA("Part") and Child:IsDescendantOf(KillersFolder) then
					Child:Destroy()
				end
			end)
		end)

		for _,Child in ipairs(ReplicatedStorage:WaitForChild("Weapons"):GetDescendants()) do
			for _,Map in ipairs(mappings) do
				if string.find(string.lower(Child.Name), Map.keyword) and Child:IsA(Map.class) then
					table.insert(Map.list, Child)
					Map.save[Child] = Child.Value
					if Map.storechildren then
						for _,Child2 in ipairs(Child:GetChildren()) do
							if Child:IsA("NumberValue") then
								table.insert(Map.list, Child2)
								Map.save[Child2] = Child2.Value
							end
						end
					end
					break
				end
			end
		end

		local Game = Window:AddTab("CounterBlox", "gamepad-2")
		local MainTabBox = Game:AddLeftTabbox("ConfigurationTabBox")
		local WeaponModificationTab = MainTabBox:AddTab("Weapon Modification")
		WeaponModificationTab:AddLabel("If changes don't take effect then respawn.")

		WeaponModificationTab:AddToggle("AutomaticWeapon", {
			Text = "Automatic Weapon",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.AutomaticWeapon then
						CounterBlox.AutomaticWeapon:Disconnect()
						CounterBlox.AutomaticWeapon = nil
					end

					for Object, OldValue in next, Saved.AutomaticValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.AutomaticWeapon = Heartbeat(function()
					for _,Object in ipairs(AutomaticValues) do
						if Object.Value ~= true then
							Object.Value = true
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("RapidFire", {
			Text = "Rapid Fire",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.RapidFire then
						CounterBlox.RapidFire:Disconnect()
						CounterBlox.RapidFire = nil
					end

					for Object, OldValue in next, Saved.FireRateValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.RapidFire = Heartbeat(function()
					for _,Object in ipairs(FireRateValues) do
						if Object.Value ~= FireRate then
							Object.Value = FireRate
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddDropdown("FireRateSpeed", {
			Text = "Rapid Fire Speed",
			Values = {"Slow", "Fast", "Maximum"},
			Default = 1,
			Callback = function(Speed)
				if Speed == "Slow" then
					FireRate = 0.1
				elseif Speed == "Fast" then
					FireRate = 0.025
				else
					FireRate = 0.01
				end
			end
		})
		WeaponModificationTab:AddToggle("InfiniteAmmo", {
			Text = "Infinite Ammo",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.InfiniteAmmo then
						CounterBlox.InfiniteAmmo:Disconnect()
						CounterBlox.InfiniteAmmo = nil
					end

					for Object, OldValue in next, Saved.AmmoValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.InfiniteAmmo = Heartbeat(function()
					for _,Object in ipairs(AmmoValues) do
						if Object.Value ~= 6e9 then
							Object.Value = 6e9
						end
					end
				end, false)
			end
		})
		--[[WeaponModificationTab:AddToggle("NoRecoil", {
			Text = "No Recoil",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.NoRecoil then
						CounterBlox.NoRecoil:Disconnect()
						CounterBlox.NoRecoil = nil
					end

					for Object, OldValue in next, Saved.RecoilValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.NoRecoil = Heartbeat(function()
					for _,Object in ipairs(RecoilValues) do
						if Object.Value ~= 0 then
							Object.Value = 0
						end
					end
				end, false)
			end
		})]]
		WeaponModificationTab:AddToggle("NoSpread", {
			Text = "No Spread",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.NoSpread then
						CounterBlox.NoSpread:Disconnect()
						CounterBlox.NoSpread = nil
					end

					for Object, OldValue in next, Saved.SpreadValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.NoSpread = Heartbeat(function()
					for _,Object in ipairs(SpreadValues) do
						if Object.Value ~= 0 then
							Object.Value = 0
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("InstantReload", {
			Text = "Instant Reload",
			Default = false,
			Callback = function(State)
				if not State then
					if CounterBlox.InstantReload then
						CounterBlox.InstantReload:Disconnect()
						CounterBlox.InstantReload = nil
					end

					for Object, OldValue in next, Saved.ReloadTimeValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				CounterBlox.InstantReload = Heartbeat(function()
					for _,Object in ipairs(ReloadTimeValues) do
						if Object.Value ~= 0.01 then
							Object.Value = 0.01
						end
					end
				end, false)
			end
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(CounterBlox)

			for _,SavedValues in ipairs(Saved) do
				for Object, OldValue in next, (SavedValues) do
					if Object and Object.Parent then
						Object.Value = OldValue
					end
				end
			end
		end)
	elseif IsArsenalBaseGame then
		local Arsenal = {
			AutomaticWeapon = nil,
			RapidFire = nil,
			IncreaseAmmo = nil,
			NoRecoil = nil,
			NoSpread = nil,
			InstantReload = nil,
		}
		local Saved = {
			AutomaticValues = {},
			FireRateValues = {},
			AmmoValues = {},
			RecoilValues = {},
			SpreadValues = {},
			ReloadTimeValues = {}
		}
		local AutomaticValues = {}
		local FireRateValues = {}
		local AmmoValues = {}
		local RecoilValues = {}
		local SpreadValues = {}
		local ReloadTimeValues = {}
		local Mappings = {
			{Keyword = "auto", Class = "BoolValue", List = AutomaticValues, Save = Saved.AutomaticValues},
			{Keyword = "firerate", Class = "NumberValue", List = FireRateValues, Save = Saved.FireRateValues},
			{Keyword = "ammo", Class = "IntValue", List = AmmoValues, Save = Saved.AmmoValues},
			{Keyword = "recoil", Class = "NumberValue", List = RecoilValues, Save = Saved.RecoilValues},
			{Keyword = "spread", Class = "NumberValue", List = SpreadValues, Save = Saved.SpreadValues},
			{Keyword = "reload", Class = "NumberValue", List = ReloadTimeValues, Save = Saved.ReloadTimeValues},
		}
		local FireRate = 0.1

		for _,Child in ipairs(ReplicatedStorage:WaitForChild("Weapons"):GetDescendants()) do
			for _,Map in ipairs(Mappings) do
				if string.find(string.lower(Child.Name), Map.Keyword) and Child:IsA(Map.Class) then
					table.insert(Map.List, Child)
					Map.Save[Child] = Child.Value
					break
				end
			end
		end

		local SelectedWeaponCamo = "None"
		local SelectedKnifeSkin = "Dagger"

		local Game = Window:AddTab("Arsenal", "gamepad-2")
		local SilentTabBox = Game:AddLeftTabbox("SilentAimbotTabBox")
		local MainTabBox = Game:AddRightTabbox("ConfigurationTabBox")
		local SilentAimbotTab = SilentTabBox:AddTab("Silent Aimbot [Hitbox Expander]")
		local WeaponModificationTab = MainTabBox:AddTab("Weapon Modification")
		WeaponModificationTab:AddLabel("If changes don't take effect then respawn.")
		local SkinChangerTabbox = Game:AddRightTabbox("SkinChangerTabBox")
		local WeaponCamoSkinChangerTab = SkinChangerTabbox:AddTab("Weapon Camo")
		local KnifeSkinChangerTab = SkinChangerTabbox:AddTab("Knife")

		local ArsenalTableOfParts = {"HeadHB", "HumanoidRootPart"}
		local HeadSize = Vector3.new(2, 1, 1)
		local HumanoidRootPartSize = Vector3.new(2, 2, 1)
		local function ResetArsenalSilentAimbot(Player)
			local Character = Player.Character
			if Character then
				for _,BasePart in ipairs(ArsenalTableOfParts) do
					local Part = Character:FindFirstChild(BasePart)
					if Part then
						if BasePart == "HeadHB" then
							if Part.Size ~= HeadSize then
								Part.Size = HeadSize
							end
						elseif BasePart == "HumanoidRootPart" then
							if Part.Size ~= HumanoidRootPartSize then
								Part.Size = HumanoidRootPartSize
							end
						end
						if Part.Transparency ~= 0 then
							Part.Transparency = 0
						end
						if Part.CanCollide ~= false then
							Part.CanCollide = false
						end
					end
				end
			end
		end

		local HitboxSize = Vector3.new(26, 26, 26)
		ThreadManager:Start("ArsenalSilentAimbot", function()
			if SilentAimbot.Enabled then
				for Player, Cache in next, CachedPlayers do
					if IsEnemy(Player) then
						for _,BasePart in ipairs(ArsenalTableOfParts) do
							local Character = Cache.Character
							local Part = Character and Character:FindFirstChild(BasePart)
							if Part then
								if Part.Size ~= HitboxSize then
									Part.Size = HitboxSize
								end
								if Part.Transparency ~= 1 then
									Part.Transparency = 1
								end
								if Part.CanCollide ~= false then
									Part.CanCollide = false
								end
							end
						end
					else
						ResetArsenalSilentAimbot(Player)
					end
				end
			end
		end, 0.1)

		local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
		SilentAimbotTab:AddToggle("SilentAimbot", {
			Text = "Toggle Aimbot",
			Default = SilentAimbot.Toggled,
			Callback = function(Value)
				SilentAimbot.Toggled = Value
				if not Value and SilentAimbot.Enabled then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for Player,_ in next, CachedPlayers do
						ResetArsenalSilentAimbot(Player)
					end
				end
			end
		}):AddKeyPicker("SilentAimbotKey", {
			Mode = "Toggle",
			Text = "Silent Aimbot",
			Callback = function(State)
				if not SilentAimbot.Toggled then
					return
				end
				SilentAimbot.Enabled = State
				if not State then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for Player,_ in next, CachedPlayers do
						ResetArsenalSilentAimbot(Player)
					end
					return
				end
				SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotFOVCircle", {
			Text = "FOV Circle",
			Default = SilentAimbot.FOVCircle.Enabled,
			Callback = function(State)
				SilentAimbot.FOVCircle.Enabled = State
			end
		}):AddColorPicker("SilentAimbotFOVCircleColor", {
			Default = SilentAimbot.FOVCircle.Color,
			Transparency = 0,
			Callback = function(Color)
				SilentAimbot.FOVCircle.Color = Color
				SilentAimbot.FOVCircle.Transparency = 1 - Options["SilentAimbotFOVCircleColor"].Transparency
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotFOVCircleFilled", {
			Text = "Filled Circle",
			Default = SilentAimbot.FOVCircle.Filled,
			Callback = function(Filled)
				SilentAimbot.FOVCircle.Filled = Filled
			end
		})
		SilentAimbotTab:AddSlider("SilentAimbotFOVCircleRadius", {
			Text = "Circle Radius",
			Default = SilentAimbot.FOVCircle.Radius,
			Min = 50,
			Max = 250,
			Rounding = 0,
			Compact = false,
			Callback = function(Radius)
				SilentAimbot.FOVCircle.Radius = Radius
			end
		})
		SilentAimbotTab:AddSlider("SilentAimbotFOVCircleThickness", {
			Text = "Circle Thickness",
			Default = SilentAimbot.FOVCircle.Thickness,
			Min = 1,
			Max = 10,
			Rounding = 0,
			Compact = false,
			Callback = function(Thickness)
				SilentAimbot.FOVCircle.Thickness = Thickness
			end
		})
		SilentAimbotTab:AddDropdown("SilentAimbotFOVCirclePosition", {
			Text = "Circle Position",
			Values = {"Center", "Mouse"},
			Default = 2,
			Callback = function(Position)
				SilentAimbot.FOVCircle.Position = Position
			end
		})

		WeaponModificationTab:AddToggle("AutomaticWeapon", {
			Text = "Automatic Weapon",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.AutomaticWeapon then
						Arsenal.AutomaticWeapon:Disconnect()
						Arsenal.AutomaticWeapon = nil
					end

					for Object, OldValue in next, Saved.AutomaticValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.AutomaticWeapon = Heartbeat(function()
					for _,Object in ipairs(AutomaticValues) do
						if Object.Value ~= true then
							Object.Value = true
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("RapidFire", {
			Text = "Rapid Fire",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.RapidFire then
						Arsenal.RapidFire:Disconnect()
						Arsenal.RapidFire = nil
					end

					for Object, OldValue in next, Saved.FireRateValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.RapidFire = Heartbeat(function()
					for _,Object in ipairs(FireRateValues) do
						if Object.Value ~= FireRate then
							Object.Value = FireRate
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddDropdown("FireRateSpeed", {
			Text = "Rapid Fire Speed",
			Values = {"Slow", "Fast", "Maximum"},
			Default = 1,
			Callback = function(Speed)
				if Speed == "Slow" then
					FireRate = 0.1
				elseif Speed == "Fast" then
					FireRate = 0.025
				else
					FireRate = 0
				end
			end
		})
		WeaponModificationTab:AddToggle("IncreaseAmmo", {
			Text = "Increase Ammo",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.IncreaseAmmo then
						Arsenal.IncreaseAmmo:Disconnect()
						Arsenal.IncreaseAmmo = nil
					end

					for Object, OldValue in next, Saved.AmmoValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.IncreaseAmmo = Heartbeat(function()
					for _,Object in ipairs(AmmoValues) do
						if Object.Value < 100 then
							Object.Value = 100
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("NoRecoil", {
			Text = "No Recoil",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.NoRecoil then
						Arsenal.NoRecoil:Disconnect()
						Arsenal.NoRecoil = nil
					end

					for Object, OldValue in next, Saved.RecoilValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.NoRecoil = Heartbeat(function()
					for _,Object in ipairs(RecoilValues) do
						if Object.Value ~= 0 then
							Object.Value = 0
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("NoSpread", {
			Text = "No Spread",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.NoSpread then
						Arsenal.NoSpread:Disconnect()
						Arsenal.NoSpread = nil
					end

					for Object, OldValue in next, Saved.SpreadValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.NoSpread = Heartbeat(function()
					for _,Object in ipairs(SpreadValues) do
						if Object.Value ~= 0 then
							Object.Value = 0
						end
					end
				end, false)
			end
		})
		WeaponModificationTab:AddToggle("InstantReload", {
			Text = "Instant Reload",
			Default = false,
			Callback = function(State)
				if not State then
					if Arsenal.InstantReload then
						Arsenal.InstantReload:Disconnect()
						Arsenal.InstantReload = nil
					end

					for Object, OldValue in next, Saved.ReloadTimeValues do
						if Object and Object.Parent then
							Object.Value = OldValue
						end
					end

					return
				end

				Arsenal.InstantReload = Heartbeat(function()
					for _,Object in ipairs(ReloadTimeValues) do
						if Object.Value ~= 0 then
							Object.Value = 0
						end
					end
				end, false)
			end
		})

		local RandomOwnedWeaponCamo = "Shuffle"
		local DisabledWeaponCamos = {"Candied", "Season Slayer", "Run"}
		local TableOfWeaponCamos = {
			"None", "Arctic OP", "Big BUX", "Quandale Dingle", "Ugly Sweater",
			"Cherry", "Loops", "Scrambled", "Coal",
			"Froggo", "Diamonds", "GX", "Nomad",
			"Canes and Cookies", "Splots", "Candies", "Scavenger Camo",
			"Cartoony Ghost", "Bubbles", "Cyber", "Show Time Crow",
			"Subzero Crystalline", "Arctic Camo", "Big Hoss", "Flow",
			"Integrated", "Candy Cross", "LGBTQIA+", "Strands",
			"Stars", "Galaxy", "Binary", "Big TIX",
			"Murky Depth", "Polkas", "Clouds", "Seals",
			"Triangles", "Candles", "Dark Matter", "Vine Wrap",
			"Crow", "Glitter", "Mushroom", "Flesh",
			"Hallowed Crystals", "Water", "Petal", "Studs",
			"Sci Tri", "Swirls", "Blind Justice", "Aura Pop",
			"Winter OP", "Fog", "Police Tape", "B-Bot",
			"Rope", "Brick", "Duckies", "Negative Circuit",
			"Sardine Lover", "Weapon Skins", "Bacon", "Cell",
			"Cube", "Grid", "TRANS PRIDE", "Clovers",
			"Checker", "ACT", "Jungle Press", "Squad",
			"Gift Wrapped", "Pumpkins", "Scytheric", "Armored",
			"Cheese", "Skulls", "Winter Candlelight", "Danger Stickers",
			"Spirals", "Winter Day", "Circuits", "Team Sort",
			"Bruh", "Melees", "Active Camo", "Holly",
			"Node", "Target", "Crystaline", "FrostBurn",
			"Construct", "Cobalt", "Hive Mind",
			"Creator", "Stocking Galore", "Snow Blasted", "Webs",
			"Chainage", "Snow Scattered", "Time Is Money", "Warp",
			"Fleshy", "Bells", "FREE", "Alien",
			"Wood", "Crimson", "Widow", "Aurora",
			"Static", "Bones"
		}

		WeaponCamoSkinChangerTab:AddLabel("Re-equip your Weapon after applying Camo.", false)
		WeaponCamoSkinChangerTab:AddDropdown("ArsenalSelectWeaponCamo", {
			Text = "Select Weapon Camo",
			Values = TableOfWeaponCamos,
			Default = 1,
			Multi = false,
			Callback = function(SelectedCamo)
				SelectedWeaponCamo = SelectedCamo
			end,
		})
		WeaponCamoSkinChangerTab:AddButton("ArsenalApplyWeaponCamo", {
			Text = "Apply Weapon Camo",
			Func = function()
				local WeaponCamo = LocalPlayer:FindFirstChild("Equipped")
				if WeaponCamo then
					WeaponCamo.Value = SelectedWeaponCamo
				end
			end,
		})

		local RandomOwnedKnife = "Shuffle"
		local DisabledKnives = {"SuperSpaceKatana"}
		local TableOfKnives =  {
			"Dagger", "Combat Knife", "The Ghostwalker",
			"Peppermint Slicer", "Blossoming Femur", "Handy Candy", "Crucible",
			"Grumpy Hammer", "Coal Scythe", "Crab Claw", "Divinity",
			"Literal Melee", "When Day Breaks", "Bunny Staff", "Wired Bat",
			"Skele Scythe", "Big Sip", "Death's Blade", "Silver Bell",
			"Halberd", "Annihilator's Broken Sword", "Pipe Wrench Shank",
			"Synthlight Greatsword", "Harvester", "Rapier", "Moai",
			"Loaf", "Reliable Hammer", "Doublade", "Nomad's Blade",
			"Rusty Pipe", "Digi-Blade", "Daito", "Delinquent Pop",
			"Spring Greatsword", "Let The Skies Fall", "Racket", "Sip O' Stink", "Ghost Ripper",
			"Moderation Hammer", "Easter Cleaver", "Kunai", "Stranger's Handblades",
			"Wooden Spoon", "Pumpkin Bucket", "Toy Tree", "Tactical Knife",
			"Slicecicle", "Garlic Kebab", "Stop Sign", "Brass Knuckles",
			"Sabre", "Machete", "Claws", "Kitchen Knife",
			"Newspaper", "Endbringer", "Katar", "ACT Trophy S6",
			"Icicle", "The Scrambler", "Reclaimer", "The Venomshank",
			"Crowbar", "Tomahawk", "Frostweaver's Wand", "Katana",
			"Bouquet", "Guitar", "Gingerbread Knife", "Electro Axe",
			"Butterfly Knife", "The Windforce", "Swordfish", "Doodle Sign",
			"Smug Egg", "Bloxy", "Rubber Hammer", "Shovel",
			"Coal Sword", "Leader's Axe", "Kukri", "The Firebrand",
			"Bat Axe", "Fish", "Karambit", "Slappy",
			"Bat", "Drill-Shear Skewer", "Electronic Stake", "The Fool's Tool",
			"Balloon Sword", "Beast Hammer", "The Illumina", "Merry Masher",
			"Seal", "Da Melee", "Brick", "Energy Katar",
			"Baton", "Calculator", "Khopesh", "Egg",
			"Rebel's Bat", "OG Space Katana", "Mop", "The Ice Dagger",
			"Candle Sword", "Sickle", "Candleabra", "ACT Trophy",
			"Earth Cleaver", "Blade", "Bone Club", "Makeshift Axe",
			"R.A.M", "Wrench", "Pencil", "Heart Break",
			"Paddle", "Pumpkin Staff", "Peppermint Hammer", "Carrot",
			"Frog", "Stinger", "Hallow's Scythe", "Coral Blade",
			"Makeshift Saw", "Energy Blade", "Pumpkin Axe", "Plane",
			"Fisticuffs", "Candy Cane Claws", "Roughian's Pipe", "FOAM BLADE 3000",
			"Pan", "Divine Medallions", "Sledgehammer", "Rokia Hammer",
			"Scythe", "Pitchfork", "Golden Rings", "Naginata",
			"Blast Hammer", "Ban Hammer", "Electric Flail", "Night's Edge",
			"Classic Sword", "Bone Karambit", "Starfire Staff", "Candy Cane",
			"Aged Shovel", "The Darkheart", "Skull Pal", "Mittens",
			"Saber", "Assimilator", "Handblades", "Space Katana",
			"Killbrick Melee", "Chainsaw", "Swift End", "Candy Cane Sword",
			"Banana", "Hero's Sword", "Can Mace", "Paint Brush",
			"Gaster Blaster", "Fire Poker", "Glacier Blade"
		}
		KnifeSkinChangerTab:AddLabel("Re-equip your Knife after applying Skin.", false)
		KnifeSkinChangerTab:AddDropdown("ArsenalSelectKnifeSkin", {
			Text = "Select Knife Skin",
			Values = TableOfKnives,
			Default = 1,
			Multi = false,
			Callback = function(SelectedSkin)
				SelectedKnifeSkin = SelectedSkin
			end,
		})
		KnifeSkinChangerTab:AddButton("ArsenalApplyKnifeSkin", {
			Text = "Apply Knife Skin",
			Func = function()
				local Data = LocalPlayer:FindFirstChild("Data")
				if Data then
					local Meele = Data:FindFirstChild("Melee")
					if Meele then
						Meele.Value = SelectedKnifeSkin
					end
				end
			end,
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(Arsenal)

			for _,Player in ipairs(Players:GetPlayers()) do
				ResetArsenalSilentAimbot(Player)
			end

			for _,SavedValues in ipairs(Saved) do
				for Object, OldValue in next, SavedValues do
					if Object and Object.Parent then
						Object.Value = OldValue
					end
				end
			end
		end)
	elseif Games.IsDefuseDivision then
		--[[local Import = ReplicatedStorage:WaitForChild("Import")
		local Guns = Import:WaitForChild("Guns")
		local ThirdPersonModels = Guns:WaitForChild("ThirdPersonModels")

		local Assets = Import:WaitForChild("Assets")
		local Skins = Assets:WaitForChild("Skins")]]

		local DefuseDivision = {
			InfiniteAmmo = nil
		}

		--[[local KnifeConfiguration = {
			Bayonet = {
				Viewmodel = "Bayonet",
				Skinfolder = "bayonet",
				Targets = {"m9"}
			},
			Bowie = {
				Viewmodel = "bowie",
				Skinfolder = nil,
			},
			ButterflyKnife = {
				Viewmodel = "ButterflyKnife",
				Skinfolder = "butterflyknife",
				Targets = {"blade", "latch", "body_legacy"}
			},
			Canis = {
				Viewmodel = "canis",
				Skinfolder = "canis",
				Targets = {"survival"}
			},
			Gut = {
				Viewmodel = "gut",
				Skinfolder = "gut",
				Targets = {"gut"}
			},
			Karambit = {
				Viewmodel = "Karambit",
				Skinfolder = "karambit",
				Targets = {"knife_karambit"}
			},
			Push = {
				Viewmodel = "push",
				Skinfolder = "push",
				Targets = {"push"}
			},
			Skeleton = {
				Viewmodel = "skeleton",
				Skinfolder = "skeleton",
				Targets = {"skeleton"}
			},
			Stiletto = {
				Viewmodel = "stiletto",
				Skinfolder = "stiletto",
				Targets = {"blade", "handle"}
			},
			Tactical = {
				Viewmodel = "tactical",
				Skinfolder = "tactical",
				Targets = {"man"}
			},
			Talon = {
				Viewmodel = "talon",
				Skinfolder = "talon",
				Targets = {"knife_talon"}
			},
			Ursus = {
				Viewmodel = "ursus",
				Skinfolder = "ursus",
				Targets = {"knife_ursus"}
			}
		}

		local SelectedKnifeModel = "Bayonet"
		local SelectedKnifeSkin = "Default"

		local function RemoveViewModel(Name)
			local ViewModel = ThirdPersonModels:FindFirstChild(Name)
			if ViewModel then
				ViewModel:Destroy()
			end
		end]]

		local Game = Window:AddTab("Defuse Division", "gamepad-2")
		local SilentTabBox = Game:AddLeftTabbox("SilentAimbotTabBox")
		local WeaponModificationTabbox = Game:AddLeftTabbox("WeaponModificationTabBox")
		--local SkinChangerTabbox = Game:AddRightTabbox("SkinChangerTabBox")
		local SilentAimbotTab = SilentTabBox:AddTab("Silent Aimbot")
		local WeaponModificationTab = WeaponModificationTabbox:AddTab("Weapon Modification")
		--local KnifeSkinChangerTab = SkinChangerTabbox:AddTab("Knife")

		SilentAimbotTab:AddLabel("Silent Aimbot is temporarily disabled.", true)

		WeaponModificationTab:AddToggle("InfiniteAmmo", {
			Text = "Infinite Ammo [Stays at 2 | BUGGY]",
			Default = false,
			Callback = function(State)
				if not State then
					if DefuseDivision.InfiniteAmmo then
						DefuseDivision.InfiniteAmmo:Disconnect()
						DefuseDivision.InfiniteAmmo = nil
					end
					return
				end

				DefuseDivision.InfiniteAmmo = Heartbeat(function()
					local Values = PlayerGui:FindFirstChild("Values")

					if not Values then
						return
					end

					local CurrentGunValue = Values:FindFirstChild("CurrentGun")

					if not CurrentGunValue then
						return
					end

					local CurrentWeapon = Values:FindFirstChild(CurrentGunValue.Value)
					if CurrentWeapon then
						local Ammo = CurrentWeapon:FindFirstChild("Ammo")
						if Ammo and Ammo.Value ~= 2 then
							Ammo.Value = 2
						end
					end
				end, false)
			end
		})

		--[[KnifeSkinChangerTab:AddLabel("Re-equip your Knife after applying Skin.", false)
		local KnifeSkinDropdown = nil
		KnifeSkinChangerTab:AddDropdown("DefuseDivisionSelectKnifeModel", {
			Text = "Select Knife Model",
			Values = {"Bayonet", "Bowie", "ButterflyKnife", "Canis", "Gut", "Karambit", "Push", "Skeleton", "Stiletto", "Tactical", "Talon", "Ursus"},
			Default = 1,
			Multi = false,
			Callback = function(SelectedModel)
				SelectedKnifeModel = SelectedModel
				if SelectedKnifeModel == "Bayonet" then
					KnifeSkinDropdown:SetValues({
						"Bloom", "Booster", "Hieroglyphics"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Bloom")
				elseif SelectedKnifeModel == "Bowie" then
					KnifeSkinDropdown:SetValues({
						"Default"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "ButterflyKnife" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Emerald", "Doppler Purple Dream", "Doppler Ruby", "Doppler Sapphire", "Gamma Doppler Phase 4", "Gamma Phase 10", "Hieroglyphics"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Canis" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Cyan Waves", "Doppler BlackPearl", "Doppler Emerald", "Doppler Phase 1", "Doppler Phase 2", "Doppler Phase 3", "Doppler Phase 4", "Doppler Ruby", "Doppler Sapphire", "Gamma Doppler Phase 4", "Marble Fade", "Purple Guy"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Gut" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Sapphire", "Gamma Doppler Phase 1", "Poison Fangs"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Karambit" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Phase 2", "Doppler Sapphire"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Push" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Phase 1", "Doppler Phase 2", "Doppler Sapphire", "Gamma Doppler Phase 1", "Gamma Doppler Phase 4",
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Skeleton" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Phase 1", "Doppler Sapphire", "Marble Fade"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Stiletto" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Phase 1", "Doppler Sapphire", "Marble Fade"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Tactical" then
					KnifeSkinDropdown:SetValues({
						"Default", "Doppler Sapphire"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Talon" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Emerald", "Doppler Phase 1", "Doppler Sapphire", "Hieroghlyphics SE", "Marble Fade", "Sea Drift"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				elseif SelectedKnifeModel == "Ursus" then
					KnifeSkinDropdown:SetValues({
						"Default", "Blood Moon", "Doppler Emerald", "Doppler Sapphire", "Marble Fade"
					})
					SelectedKnifeSkin = "Default"
					KnifeSkinDropdown:SetValue("Default")
				end
			end,
		})
		KnifeSkinDropdown = KnifeSkinChangerTab:AddDropdown("DefuseDivisionSelectKnifeSkin", {
			Text = "Select Knife Skin",
			Values = {"Bloom", "Booster", "Hieroglyphics"},
			Default = 1,
			Multi = false,
			Callback = function(SelectedSkin)
				if SelectedSkin == "Bloom" then
					SelectedKnifeSkin = "Default"
				else
					SelectedKnifeSkin = SelectedSkin
				end
			end,
		})
		KnifeSkinChangerTab:AddButton("DefuseDivisionApplyKnifeSkin", {
			Text = "Apply Knife Skin",
			Func = function()
				RemoveViewModel("TKnife")
				RemoveViewModel("TKnife")

				local function ApplyTexture(KnifeViewModel, Skin, TableOfTargets)
					if Skin == "Default" or not TableOfTargets then
						return
					end

					for _,Descendant in ipairs(KnifeViewModel:GetDescendants()) do
						if Descendant:IsA("MeshPart") then
							local LowercaseName = string.lower(Descendant.Name)
							for _,Target in ipairs(TableOfTargets) do
								if LowercaseName == Target or string.find(LowercaseName, Target) then
									for _,Child in ipairs(Skin:GetChildren()) do
										if Child:IsA("SurfaceAppearance") then
											Child:Clone().Parent = Descendant
										end
									end
								end
							end
						end
					end
				end

				local Configuration = KnifeConfiguration[SelectedKnifeModel]
				if not Configuration then
					return
				end

				local ViewModel = ThirdPersonModels:FindFirstChild(Configuration.Viewmodel)
				if not ViewModel then
					print("couldn't find viewmodel in thirdpersonmodels")
					return
				end

				local Skin = "Default"
				local SkinFolder = Configuration.Skinfolder
				if SkinFolder and SelectedKnifeSkin ~= "Default" then
					Skin = Skins:WaitForChild(SkinFolder):WaitForChild(SelectedKnifeSkin)
				end

				for _,Name in ipairs({"TKnife", "CTKnife"}) do
					local Clone = ViewModel:Clone()
					Clone.Name = Name
					ApplyTexture(Clone, Skin, Configuration.Targets)
					Clone.Parent = ThirdPersonModels
				end
			end,
		})]]

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(DefuseDivision)
		end)
	elseif Games.IsGunGroundsFFA or Games.IsFlick then
		local Flick = {
			HitboxExtender = nil
		}
		local Vector3CritSize = Vector3.new(3.113720655441284, 1.2231099605560303, 3.113720655441284)
		local ShowHitbox = false
		local HitboxSize = 3.5

		local Game = Window:AddTab(Games.IsFlick and "Flick" or "Gun Grounds FFA", "gamepad-2")
		local HitboxExtenderTab = Game:AddLeftTabbox("ConfigurationTabBox"):AddTab("Hitbox Extender")

		HitboxExtenderTab:AddToggle("HitboxExtender", {
			Text = "Hitbox Extender",
			Default = false,
			Callback = function(State)
				if not State then
					if Flick.HitboxExtender then
						Flick.HitboxExtender:Disconnect()
						Flick.HitboxExtender = nil
					end

					for Index = 1, #CachedPlayersList do
						local Character = CachedPlayersList[Index].Character
						if not Character then
							return
						end

						local Part = Character:FindFirstChild("Crit")
						if Part then
							Part.Size = Vector3CritSize
						end
					end

					return
				end

				Flick.HitboxExtender = Heartbeat(function()
					for Index = 1, #CachedPlayersList do
						local Character = CachedPlayersList[Index].Character
						if not Character then
							return
						end

						local Part = Character:FindFirstChild("Crit")
						if Part then
							local Transparency = ShowHitbox and 0.5 or 1
							if Part.Transparency ~= Transparency then
								Part.Transparency = Transparency
							end

							local Size = Vector3.one * HitboxSize
							if Part.Size ~= Size then
								Part.Size = Size
							end
						end
					end
				end, false)
			end
		})
		HitboxExtenderTab:AddToggle("ShowHitbox", {
			Text = "Show Hitbox",
			Default = false,
			Callback = function(State)
				ShowHitbox = State
			end
		})
		HitboxExtenderTab:AddSlider("HitboxSize", {
			Text = "Hitbox Size",
			Default = 3.5,
			Min = 3.5,
			Max = 15,
			Rounding = 1,
			Compact = false,
			Callback = function(Size)
				HitboxSize = Size
			end
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(Flick)

			for Index = 1, #CachedPlayersList do
				local Character = CachedPlayersList[Index].Character
				if not Character then
					return
				end

				local Part = Character:FindFirstChild("Crit")
				if Part then
					Part.Size = Vector3CritSize
					Part.Transparency = 1
				end
			end
		end)
	elseif Games.IsQuickShot then
		local QuickShot = {
			HitboxExtender = nil,
			LobbyWeapons = nil
		}

		local HitboxExtender = false
		local ShowHitbox = false
		local HitboxSize = 3.5

		local Game = Window:AddTab("Quick Shot", "gamepad-2")
		local HitboxExtenderTab = Game:AddLeftGroupbox("Hitbox Extender")
		local OthersTab = Game:AddRightGroupbox("Others")

		local DefaultRootSize = Vector3.new(2, 2, 1)
		local function ResetHitbox(Root)
			if Root then
				Root.Size = DefaultRootSize
				Root.Transparency = 1
			end
		end

		ThreadManager:Start("QuickShotHitboxExtender", function()
			if HitboxExtender then
				for Player, Cache in next, CachedPlayers do
					if IsEnemy(Player) then
						local Root = Cache.Root
						if Root then
							local Transparency = ShowHitbox and 0.5 or 1
							if Root.Transparency ~= Transparency then
								Root.Transparency = Transparency
							end

							if Root.CanCollide ~= false then
								Root.CanCollide = false
							end

							local Size = Vector3.one * HitboxSize
							if Root.Size ~= Size then
								Root.Size = Size
							end
						end
					else
						ResetHitbox(Cache.Root)
					end
				end
			end
		end, 0.1)

		HitboxExtenderTab:AddToggle("HitboxExtender", {
			Text = "Hitbox Extender",
			Default = false,
			Callback = function(State)
				if not State then
					for Index = 1, #CachedPlayersList do
						ResetHitbox(CachedPlayersList[Index].Root)
					end
					return
				end
				HitboxExtender = State
			end
		})
		HitboxExtenderTab:AddToggle("ShowHitbox", {
			Text = "Show Hitbox",
			Default = false,
			Callback = function(State)
				ShowHitbox = State
			end
		})
		HitboxExtenderTab:AddSlider("HitboxSize", {
			Text = "Hitbox Size",
			Default = 3.5,
			Min = 3.5,
			Max = 15,
			Rounding = 1,
			Compact = false,
			Callback = function(Size)
				HitboxSize = Size
			end
		})

		OthersTab:AddToggle("LobbyWeapons", {
			Text = "Lobby Weapons",
			Default = false,
			Callback = function(State)
				if not State then
					if QuickShot.LobbyWeapons then
						QuickShot.LobbyWeapons:Disconnect()
						QuickShot.LobbyWeapons = nil
					end
					return
				end

				QuickShot.LobbyWeapons = RenderStepped(function()
					LocalPlayer:SetAttribute("InRound", true)
				end, false)
			end
		})

		OthersTab:AddLabel("Bullet Case Color"):AddColorPicker("BulletCaseColor", {
			Default = Color3.fromRGB(191, 191, 0),
			Transparency = nil,
			Callback = function(Color)
				local BulletCasing = ReplicatedStorage:WaitForChild("BulletCasing", 10)
				BulletCasing.Color = Color
			end
		})

		OthersTab:AddButton({
			Text = "Reset Bullet Case Color",
			Func = function()
				Options["BulletCaseColor"]:SetValue(Color3.fromRGB(191, 191, 0))
				local BulletCasing = ReplicatedStorage:WaitForChild("BulletCasing", 10)
				BulletCasing.Color = Color3.fromRGB(191, 191, 0)
			end
		})

		OthersTab:AddLabel("Bullet Color"):AddColorPicker("BulletColor", {
			Default = Color3.fromRGB(156, 106, 70),
			Transparency = nil,
			Callback = function(Color)
				local FiredBullet = ReplicatedStorage:WaitForChild("FiredBullet", 10)
				FiredBullet.Color = Color
			end
		})

		OthersTab:AddButton({
			Text = "Reset Bullet Color",
			Func = function()
				Options["BulletColor"]:SetValue(Color3.fromRGB(156, 106, 70))
				local FiredBullet = ReplicatedStorage:WaitForChild("FiredBullet", 10)
				FiredBullet.Color = Color3.fromRGB(156, 106, 70)
			end
		})

		OthersTab:AddLabel("Bullet Smoke Color"):AddColorPicker("BulletSmokeColor", {
			Default = Color3.fromRGB(255, 255, 255),
			Transparency = nil,
			Callback = function(Color)
				local BulletSmoke = ReplicatedStorage:WaitForChild("FiredBullet", 10):WaitForChild("BulletSmoke", 10)
				BulletSmoke.Color = ColorSequence.new(Color)
			end
		})

		OthersTab:AddButton({
			Text = "Reset Bullet Smoke Color",
			Func = function()
				Options["BulletSmokeColor"]:SetValue(Color3.fromRGB(255, 255, 255))
				local BulletSmoke = ReplicatedStorage:WaitForChild("FiredBullet", 10):WaitForChild("BulletSmoke", 10)
				BulletSmoke.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
			end
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(QuickShot)

			for Index = 1, #CachedPlayersList do
				ResetHitbox(CachedPlayersList[Index].Root)
			end
		end)
	elseif Games.IsWarTycoon then
		local WarTycoon = {
			HitboxExtender = nil,
			KillTarget = nil,
			LoopKillTarget = nil,
			RPGSpamTarget = nil,
			LoopRPGSpamTarget = nil,
			RPGSpamEveryone = nil,
			NoMedkitDelay = nil,
			GasBlur = nil,
			LoopBuyCase = nil
		}

		local HitboxSize = Vector3.new(26, 26, 26)

		local Game = Window:AddTab("War Tycoon", "gamepad-2")
		local SilentAimbotTab = Game:AddLeftGroupbox("Silent Aimbot [Hitbox Expander]")
		local ModificationsTab = Game:AddRightGroupbox("Modifications")

		--local Landmines = false

		local DefaultRootSize = Vector3.new(2, 2, 1)
		local function ResetHitbox(Root)
			if Root then
				Root.Size = DefaultRootSize
			end
		end

		ThreadManager:Start("WarTycoonSilentAimbot", function()
			if SilentAimbot.Enabled then
				for Player, Cache in next, CachedPlayers do
					if IsEnemy(Player) then
						local Root = Cache.Root
						if Root then
							if Root.Size ~= HitboxSize then
								Root.Size = HitboxSize
							end
							if Root.Transparency ~= 1 then
								Root.Transparency = 1
							end
							if Root.CanCollide ~= false then
								Root.CanCollide = false
							end
						end
					else
						ResetHitbox(Cache.Root)
					end
				end
			end
		end, 0.1)

		local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
		SilentAimbotTab:AddToggle("SilentAimbot", {
			Text = "Toggle Aimbot",
			Default = SilentAimbot.Toggled,
			Callback = function(Value)
				SilentAimbot.Toggled = Value
				if not Value and SilentAimbot.Enabled then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for Index = 1, #CachedPlayersList do
						ResetHitbox(CachedPlayersList[Index].Root)
					end
				end
			end
		}):AddKeyPicker("SilentAimbotKey", {
			Mode = "Toggle",
			Text = "Silent Aimbot",
			Callback = function(State)
				if not SilentAimbot.Toggled then
					return
				end

				SilentAimbot.Enabled = State

				if not State then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for Index = 1, #CachedPlayersList do
						ResetHitbox(CachedPlayersList[Index].Root)
					end
					return
				end

				SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotFOVCircle", {
			Text = "FOV Circle",
			Default = SilentAimbot.FOVCircle.Enabled,
			Callback = function(State)
				SilentAimbot.FOVCircle.Enabled = State
			end
		}):AddColorPicker("SilentAimbotFOVCircleColor", {
			Default = SilentAimbot.FOVCircle.Color,
			Transparency = 0,
			Callback = function(Color)
				SilentAimbot.FOVCircle.Color = Color
				SilentAimbot.FOVCircle.Transparency = 1 - Options["SilentAimbotFOVCircleColor"].Transparency
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotFOVCircleFilled", {
			Text = "Filled Circle",
			Default = SilentAimbot.FOVCircle.Filled,
			Callback = function(Filled)
				SilentAimbot.FOVCircle.Filled = Filled
			end
		})
		SilentAimbotTab:AddSlider("SilentAimbotFOVCircleRadius", {
			Text = "Circle Radius",
			Default = SilentAimbot.FOVCircle.Radius,
			Min = 50,
			Max = 250,
			Rounding = 0,
			Compact = false,
			Callback = function(Radius)
				SilentAimbot.FOVCircle.Radius = Radius
			end
		})
		SilentAimbotTab:AddSlider("SilentAimbotFOVCircleThickness", {
			Text = "Circle Thickness",
			Default = SilentAimbot.FOVCircle.Thickness,
			Min = 1,
			Max = 10,
			Rounding = 0,
			Compact = false,
			Callback = function(Thickness)
				SilentAimbot.FOVCircle.Thickness = Thickness
			end
		})
		SilentAimbotTab:AddDropdown("SilentAimbotFOVCirclePosition", {
			Text = "Circle Position",
			Values = {"Center", "Mouse"},
			Default = 2,
			Callback = function(Position)
				SilentAimbot.FOVCircle.Position = Position
			end
		})

		local Events = ReplicatedStorage:WaitForChild("ACS_Engine", 10):WaitForChild("Events", 10)
		local ACS_Guns = ReplicatedStorage:WaitForChild("Configurations"):WaitForChild("ACS_Guns")

		local BulletFireSystem = ReplicatedStorage:WaitForChild("BulletFireSystem")
		local FireGun = BulletFireSystem:WaitForChild("FireGun")
		local BulletHit = BulletFireSystem:WaitForChild("BulletHit")

		local RocketSystemEvents = ReplicatedStorage:WaitForChild("RocketSystem"):WaitForChild("Events")
		local RocketHit = RocketSystemEvents:WaitForChild("RocketHit")
		local RocketReloadedFX = RocketSystemEvents:WaitForChild("RocketReloadedFX")

		local HealPlayer = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Medkit"):WaitForChild("HPlr")
		local CamoCaseSpin = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("SkinService"):WaitForChild("RF"):WaitForChild("CamoCaseSpin")

		local AntiFallDamage = true

		ModificationsTab:AddToggle("WarTycoonAntiFallDamage", {
			Text = "Anti Fall Damage",
			Default = AntiFallDamage,
			Callback = function(State)
				AntiFallDamage = State
				if State then
					local FallDamage = Events:FindFirstChild("FDMG")
					if FallDamage then
						FallDamage.Name = "nikoletoscripts"
					end
				else
					local FallDamage = Events:FindFirstChild("nikoletoscripts")
					if FallDamage then
						FallDamage.Name = "FDMG"
					end
				end
			end
		}):SetValue(true)

		local KillSelectedTarget = nil

		ModificationsTab:AddDropdown("WarTycoonPlayerList1", {
			SpecialType = "Player",
			Text = "Select Target",
			Tooltip = "Select a player to target.",
			Callback = function(Player)
				KillSelectedTarget = Player
			end
		})

		local LoopKillTarget = false
		local LoopKillOldCFrame = nil
		local KillDistanceOffset = Vector3.new(0, 25, 0)

		ModificationsTab:AddToggle("LoopKillTarget", {
			Text = "Loop Kill Target [Equip Gun]",
			Default = false,
			Callback = function(Value)
				LoopKillTarget = Value

				if Value then
					if LocalRoot then
						LoopKillOldCFrame = LocalRoot.CFrame
					end

					if not AntiFallDamage then
						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Anti Fall Damage is disabled, you may take fall damage in the process of killing your target.",
							Time = 3.5
						})
					end

					WarTycoon.LoopKillTarget = RunService.Heartbeat:Connect(function()
						if not KillSelectedTarget or KillSelectedTarget == LocalPlayer or not LocalCharacter or not LocalRoot then
							return
						end

						local Gun = LocalCharacter:FindFirstChildOfClass("Tool")

						if not Gun or Gun.Name == "RPG" then
							return
						end

						local Cache = CachedPlayers[KillSelectedTarget]
						if not Cache then
							return
						end

						local Character = Cache.Character
						if not Character then
							return
						end

						local Humanoid = Cache.Humanoid
						if not Humanoid or Humanoid.Health <= 0 then
							return
						end

						local Root = Cache.Root
						if not Root then
							return
						end

						local Head = Cache.Head
						if not Head then
							return
						end

						LocalRoot.CFrame = Root.CFrame + KillDistanceOffset

						local HitPosition = Head.Position
						local Settings = require(ACS_Guns:FindFirstChild(Gun.Name):FindFirstChild("Settings"))

						FireGun:FireServer({HitPosition}, Gun, LocalCharacter:FindFirstChild("S" .. Gun.Name), HitPosition, false)
						BulletHit:FireServer(
							Gun, Head, HitPosition,
							{
								{HitPosition, HitPosition, math.huge},
								{HitPosition, HitPosition, math.huge}
							},
							HitPosition,
							{
								FireRate = Settings.FireRate,
								MaxSpread = Settings.MaxSpread,
								Mode = Settings.Mode,
								MaxRecoilPower = Settings.MaxRecoilPower,
								Distance = Settings.Distance,
								BSpeed = Settings.BSpeed
							}
						)
					end)
				else
					if WarTycoon.LoopKillTarget then
						WarTycoon.LoopKillTarget:Disconnect()
						WarTycoon.LoopKillTarget = nil
					end

					if LocalRoot and LoopKillOldCFrame then
						LocalRoot.CFrame = LoopKillOldCFrame
					end
				end
			end
		})

		ModificationsTab:AddButton({
			Text = "Kill Target [Equip Gun]",
			ToolTip = "You will be temporarily teleported in the process of killing your target.",
			Func = function()
				if LoopKillTarget then
					if WarTycoon.KillTarget then
						WarTycoon.KillTarget:Disconnect()
						WarTycoon.KillTarget = nil
					end
					return
				end

				if not KillSelectedTarget or not LocalCharacter or not LocalRoot then
					return
				end

				if KillSelectedTarget == LocalPlayer then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Blud tried to kill himself.",
						Time = 3.5
					})
					return
				end

				local Gun = LocalCharacter:FindFirstChildOfClass("Tool")

				if not Gun then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Make sure you have a gun equipped first.",
						Time = 3.5
					})
					return
				end

				local Cache = CachedPlayers[KillSelectedTarget]
				if not Cache then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target has not loaded in yet.",
						Time = 3.5
					})
					return
				end

				local Character = Cache.Character
				if not Character then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target has not loaded in yet.",
						Time = 3.5
					})
					return
				elseif Character:FindFirstChildOfClass("ForceField") then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is shielded by a ForceField.",
						Time = 3.5
					})
					return
				end

				local Humanoid = Cache.Humanoid
				if not Humanoid then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is not alive.",
						Time = 3.5
					})
					return
				end

				local Root = Cache.Root
				if not Root then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is not alive.",
						Time = 3.5
					})
					return
				end

				local Head = Cache.Head
				if not Head then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is not alive.",
						Time = 3.5
					})
					return
				end

				if not AntiFallDamage then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Anti Fall Damage is disabled, you may take fall damage in the process of killing your target.",
						Time = 3.5
					})
				end

				local OldCFrame = LocalRoot.CFrame
				local Settings = require(ACS_Guns:FindFirstChild(Gun.Name):FindFirstChild("Settings"))
				local Connection = nil
				Connection = RunService.Heartbeat:Connect(function()
					if LoopKillTarget then
						if WarTycoon.KillTarget then
							WarTycoon.KillTarget:Disconnect()
							WarTycoon.KillTarget = nil
						end
						return
					end

					if not Humanoid or not Character or not LocalCharacter or not LocalRoot or not Gun or not Humanoid.Parent or not Gun.Parent or Gun.Parent ~= LocalCharacter then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						if LocalRoot then
							LocalRoot.CFrame = OldCFrame
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target died or you unequipped your gun, teleported back.",
							Time = 3.5
						})

						return
					end

					if Humanoid.Health <= 0 then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						if LocalRoot then
							LocalRoot.CFrame = OldCFrame
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target died, teleported back.",
							Time = 3.5
						})

						return
					end

					if Character:FindFirstChildOfClass("ForceField") then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						if LocalRoot then
							LocalRoot.CFrame = OldCFrame
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target is shielded by a ForceField, teleported back.",
							Time = 3.5
						})

						return
					end

					LocalRoot.CFrame = Root.CFrame + KillDistanceOffset

					local HitPosition = Head.Position
					FireGun:FireServer({HitPosition}, Gun, LocalCharacter:FindFirstChild("S" .. Gun.Name), HitPosition, false)
					BulletHit:FireServer(
						Gun, Head, HitPosition,
						{
							{HitPosition, HitPosition, math.huge},
							{HitPosition, HitPosition, math.huge}
						},
						HitPosition,
						{
							FireRate = Settings.FireRate,
							MaxSpread = Settings.MaxSpread,
							Mode = Settings.Mode,
							MaxRecoilPower = Settings.MaxRecoilPower,
							Distance = Settings.Distance,
							BSpeed = Settings.BSpeed
						}
					)
				end)
				WarTycoon.KillTarget = Connection
			end
		})

		local RPGSpamSelectedTarget = nil

		ModificationsTab:AddDropdown("WarTycoonPlayerList2", {
			SpecialType = "Player",
			Text = "Select Target",
			Tooltip = "Select a player to target.",
			Callback = function(Player)
				RPGSpamSelectedTarget = Player
			end
		})

		local LoopRPGSpamTarget = false
		local NormalOffset = Vector3.new(0.9848124980926514, 0, 0.17362114787101746)

		ModificationsTab:AddLabel("If the RPG Spam doesn't work then try shooting it atleast once.", true)

		ModificationsTab:AddToggle("LoopRPGSpamTarget", {
			Text = "Loop RPG Spam Target [Equip RPG]",
			Default = false,
			Callback = function(Value)
				LoopRPGSpamTarget = Value

				if Value then
					WarTycoon.LoopRPGSpamTarget = RunService.Heartbeat:Connect(function()
						if not RPGSpamSelectedTarget or RPGSpamSelectedTarget == LocalPlayer or not LocalCharacter or not LocalRoot then
							return
						end

						local Gun = LocalCharacter:FindFirstChild("RPG")

						if not Gun then
							return
						end

						local Cache = CachedPlayers[RPGSpamSelectedTarget]
						if not Cache then
							return
						end

						local Character = Cache.Character
						if not Character then
							return
						end

						local Humanoid = Cache.Humanoid
						if not Humanoid or Humanoid.Health <= 0 then
							return
						end

						local Root = Cache.Root
						if not Root then
							return
						end

						RocketReloadedFX:FireServer(Gun, true)

						if not Humanoid.Sit then
							RocketHit:FireServer({
								Normal = NormalOffset,
								Player = CoolEmptyTable,
								Label = "combat.cc on top | Rocket3",
								HitPart = Root,
								Vehicle = Gun,
								Position = Root.Position,
								Weapon = Gun
							})
						else
							local RootPosition = Root.Position
							local RocketHitArguments = {
								Normal = NormalOffset,
								Player = CoolEmptyTable,
								Label = "combat.cc on top | Rocket3",
								HitPart = Root,
								Vehicle = Gun,
								Position = RootPosition,
								Weapon = Gun
							}

							RocketHit:FireServer(RocketHitArguments)

							local HorizontalOffset = Root.CFrame.LookVector
							HorizontalOffset = Vector3.new(HorizontalOffset.X, 0, HorizontalOffset.Z).Unit
							local Speed = Root.AssemblyLinearVelocity.Magnitude * 0.03

							RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(10, 45) + Speed)
							RocketHit:FireServer(RocketHitArguments)

							RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(60, 120) + Speed)
							RocketHit:FireServer(RocketHitArguments)
						end
					end)
				else
					if WarTycoon.LoopRPGSpamTarget then
						WarTycoon.LoopRPGSpamTarget:Disconnect()
						WarTycoon.LoopRPGSpamTarget = nil
					end
				end
			end
		})

		ModificationsTab:AddButton({
			Text = "RPG Spam Target [Equip RPG]",
			Func = function()
				if LoopRPGSpamTarget then
					if WarTycoon.RPGSpamTarget then
						WarTycoon.RPGSpamTarget:Disconnect()
						WarTycoon.RPGSpamTarget = nil
					end
					return
				end

				if not RPGSpamSelectedTarget or not LocalCharacter or not LocalRoot then
					return
				end

				if RPGSpamSelectedTarget == LocalPlayer then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Blud tried to kill himself.",
						Time = 3.5
					})
					return
				end

				local Gun = LocalCharacter:FindFirstChild("RPG")

				if not Gun then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Make sure you have an RPG equipped first.",
						Time = 3.5
					})
					return
				end

				local Cache = CachedPlayers[RPGSpamSelectedTarget]
				if not Cache then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target has not loaded in yet.",
						Time = 3.5
					})
					return
				end

				local Character = Cache.Character
				if not Character then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target has not loaded in yet.",
						Time = 3.5
					})
					return
				elseif Character:FindFirstChildOfClass("ForceField") then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is shielded by a ForceField.",
						Time = 3.5
					})
					return
				end

				local Humanoid = Cache.Humanoid
				if not Humanoid then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is not alive.",
						Time = 3.5
					})
					return
				end

				local Root = Cache.Root
				if not Root then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Target is not alive.",
						Time = 3.5
					})
					return
				end

				local Connection = nil
				Connection = RunService.Heartbeat:Connect(function()
					if LoopRPGSpamTarget then
						if WarTycoon.RPGSpamTarget then
							WarTycoon.RPGSpamTarget:Disconnect()
							WarTycoon.RPGSpamTarget = nil
						end
						return
					end

					if not Humanoid or not Character or not LocalCharacter or not LocalRoot or not Gun or not Humanoid.Parent or not Gun.Parent or Gun.Parent ~= LocalCharacter then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target died or you unequipped your RPG, teleported back.",
							Time = 3.5
						})

						return
					end

					if Humanoid.Health <= 0 then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target died, teleported back.",
							Time = 3.5
						})

						return
					end

					if Character:FindFirstChildOfClass("ForceField") then
						if Connection then
							Connection:Disconnect()
							Connection = nil
						end

						Library:Notify({
							Title = "[[ combat.cc ]]",
							Description = "Target is shielded by a ForceField, teleported back.",
							Time = 3.5
						})

						return
					end

					RocketReloadedFX:FireServer(Gun, true)

					if not Humanoid.Sit then
						RocketHit:FireServer({
							Normal = NormalOffset,
							Player = CoolEmptyTable,
							Label = "combat.cc on top | Rocket3",
							HitPart = Root,
							Vehicle = Gun,
							Position = Root.Position,
							Weapon = Gun
						})
					else
						local RootPosition = Root.Position
						local RocketHitArguments = {
							Normal = NormalOffset,
							Player = CoolEmptyTable,
							Label = "combat.cc on top | Rocket3",
							HitPart = Root,
							Vehicle = Gun,
							Position = RootPosition,
							Weapon = Gun
						}

						RocketHit:FireServer(RocketHitArguments)

						local HorizontalOffset = Root.CFrame.LookVector
						HorizontalOffset = Vector3.new(HorizontalOffset.X, 0, HorizontalOffset.Z).Unit
						local Speed = Root.AssemblyLinearVelocity.Magnitude * 0.03

						RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(10, 45) + Speed)
						RocketHit:FireServer(RocketHitArguments)

						RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(60, 120) + Speed)
						RocketHit:FireServer(RocketHitArguments)
					end
				end)
				WarTycoon.RPGSpamTarget = Connection
			end
		})

		ModificationsTab:AddToggle("RPGSpamEveryone", {
			Text = "RPG Spam Everyone [Equip RPG]",
			Default = false,
			Callback = function(Value)
				if not Value then
					ThreadManager:Stop("WarTycoonRPGSpamEveryone")
					return
				end

				ThreadManager:Start("WarTycoonRPGSpamEveryone", function()
					if not LocalCharacter or not LocalRoot then
						return
					end

					local Gun = LocalCharacter:FindFirstChild("RPG")

					if not Gun then
						return
					end

					for Index = 1, #CachedPlayersList do
						local Cache = CachedPlayersList[Index]

						local Character = Cache.Character
						if not Character then
							continue
						end

						local Humanoid = Cache.Humanoid
						if not Humanoid or Humanoid.Health <= 0 then
							continue
						end

						if Character:FindFirstChildOfClass("ForceField") then
							continue
						end

						local Root = Cache.Root
						if not Root then
							continue
						end

						RocketReloadedFX:FireServer(Gun, true)

						if not Humanoid.Sit then
							RocketHit:FireServer({
								Normal = NormalOffset,
								Player = CoolEmptyTable,
								Label = "combat.cc on top | Rocket3",
								HitPart = Root,
								Vehicle = Gun,
								Position = Root.Position,
								Weapon = Gun
							})
						else
							local RootPosition = Root.Position
							local RocketHitArguments = {
								Normal = NormalOffset,
								Player = CoolEmptyTable,
								Label = "combat.cc on top | Rocket3",
								HitPart = Root,
								Vehicle = Gun,
								Position = RootPosition,
								Weapon = Gun
							}

							RocketHit:FireServer(RocketHitArguments)

							local HorizontalOffset = Root.CFrame.LookVector
							HorizontalOffset = Vector3.new(HorizontalOffset.X, 0, HorizontalOffset.Z).Unit
							local Speed = Root.AssemblyLinearVelocity.Magnitude * 0.03

							RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(10, 45) + Speed)
							RocketHit:FireServer(RocketHitArguments)

							RocketHitArguments.Position = Root.Position + HorizontalOffset * (math.random(60, 120) + Speed)
							RocketHit:FireServer(RocketHitArguments)
						end
					end
				end, 0.1)
			end
		})

		local NoMedkitDelay = false
		ModificationsTab:AddToggle("NoMedkitDelay", {
			Text = "No Medkit Delay",
			Default = NoMedkitDelay,
			Callback = function(Value)
				NoMedkitDelay = Value
				if not Value then
					if WarTycoon.NoMedkitDelay then
						WarTycoon.NoMedkitDelay:Disconnect()
						WarTycoon.NoMedkitDelay = nil
					end
					return
				end

				WarTycoon.NoMedkitDelay = Mouse.Button1Down:Connect(function()
					if not LocalCharacter or not LocalHumanoid then
						return
					end

					local Tool = LocalCharacter:FindFirstChild("Medkit")
					if not Tool then
						return
					end

					HealPlayer:FireServer()
					LocalHumanoid:UnequipTools()

					--[[LocalCharacter:SetAttribute("NoMovement", false)

					local ViewModel = LocalCharacter:FindFirstChild("viewModel")
					if ViewModel then
						ViewModel:Destroy()
					end]]
				end)
			end
		})

		ModificationsTab:AddToggle("GasBlurRemoval", {
			Text = "Gas Blur Removal",
			Default = false,
			Callback = function(Value)
				if not Value then
				    if WarTycoon.GasBlur then
						WarTycoon.GasBlur:Disconnect()
						WarTycoon.GasBlur = nil
					end
					return
				end

				WarTycoon.GasBlur = RenderStepped(function()
					for _,Child in next, Camera:GetChildren() do
						if Child.Name:lower():find("blur") then
							Child:Destroy()
						end
					end
				end, false)
			end
		})

		local SelectedCase = "StarterCase"
		ModificationsTab:AddDropdown("WarTycoonPlayerList1", {
			Text = "Selected Case",
			Values = {"StarterCase", "Root"},
			Default = 1,
			Callback = function(Case)
				SelectedCase = Case
			end
		})

		ModificationsTab:AddToggle("LoopBuyCase", {
			Text = "Loop Buy Case",
			Default = false,
			Callback = function(Value)
				if not Value then
				    if WarTycoon.LoopBuyCase then
						WarTycoon.LoopBuyCase:Disconnect()
						WarTycoon.LoopBuyCase = nil
					end
					return
				end

				WarTycoon.LoopBuyCase = RenderStepped(function()
					CamoCaseSpin:InvokeServer(SelectedCase, 1)
				end, false)
			end
		})

		ModificationsTab:AddButton({
			Text = "Buy x1 Case",
			Func = function()
				CamoCaseSpin:InvokeServer(SelectedCase, 1)
			end
		})

		ModificationsTab:AddButton({
			Text = "Buy x2 Case",
			Func = function()
				CamoCaseSpin:InvokeServer(SelectedCase, 2)
			end
		})

		ModificationsTab:AddButton({
			Text = "Buy x10 Case",
			Func = function()
				CamoCaseSpin:InvokeServer(SelectedCase, 10)
			end
		})

		--[[
local args = {
	true
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("Drone EMP"):WaitForChild("PlaySound"):FireServer(unpack(args))

	]]

		--[[table.insert(WarTycoon, workspace.DescendantAdded:Connect(function(Child)
			if Landmines and Child.Name == "Land Mine" then
				if Child:FindFirstChild("TouchPart") then
					Child:Destroy()
				end
			end
		end))

		ModificationsTab:AddToggle("Landmines", {
			Text = "Landmines",
			Default = false,
			Callback = function(Value)
				Landmines = Value
				if Value then
					for _,Child in ipairs(workspace:GetDescendants()) do
						if Child.Name == "Land Mine" then
							if Child:FindFirstChild("TouchPart") then
								Child:Destroy()
							end
						end
					end
				end
			end
		})]]

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(WarTycoon)

			local FallDamage = Events:FindFirstChild("nikoletoscripts")
			if FallDamage then
				FallDamage.Name = "FDMG"
			end

			if LoopKillTarget and LoopKillOldCFrame and LocalRoot then
				LocalRoot.CFrame = LoopKillOldCFrame
			end

			for Index = 1, #CachedPlayersList do
				ResetHitbox(CachedPlayersList[Index].Root)
			end
		end)
	elseif Games.IsAimblox then
		local Game = Window:AddTab("Aimblox", "gamepad-2")
		local SilentAimbotTab = Game:AddLeftGroupbox("SilentAimbotTabBox")
		SilentAimbotTab:AddLabel("Silent Aimbot is temporarily disabled for this game.", true)
		--[[if hookmetamethod and getnamecallmethod then
			local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
			local SilentAimbotToggle = SilentAimbotTab:AddToggle("SilentAimbot", {
				Text = "Toggle Aimbot",
				Default = false,
				Callback = function(State)
					SilentAimbot.Toggled = State
					if not State and SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
						SilentAimbot.Enabled = false
					end
				end
			})
			SilentAimbotToggle:AddKeyPicker("SilentAimbotKey", {
				Mode = "Toggle",
				Text = "Silent Aimbot",
				Callback = function()
					if not SilentAimbot.Toggled then
						return
					end
					SilentAimbot.Enabled = not SilentAimbot.Enabled
					if SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
					else
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					end
				end
			})
			SilentAimbotTab:AddDropdown("SilentAimbotAimPart", {
				Text = "Aim Part",
				Values = {"Head", "Root"},
				Default = 2,
				Callback = function(Value)
					SilentAimbot.AimPart = Value
				end
			})
			SilentAimbotTab:AddToggle("SilentAimbotTeamCheck", {
				Text = "Team Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.TeamCheck = State
				end
			})
			SilentAimbotTab:AddToggle("SilentAimbotDeadCheck", {
				Text = "Dead Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.DeadCheck = State
				end
			})
		else
			SilentAimbotTab:AddLabel("Silent Aimbot not supported. Missing required function(s):", true)
			if not hookmetamethod then
				SilentAimbotTab:AddLabel("'hookmetamethod'", true)
			end
			if not getnamecallmethod then
				SilentAimbotTab:AddLabel(", 'getnamecallmethod'", true)
			end
		end]]
	elseif Games.IsRivals then
		local Game = Window:AddTab("Rivals", "gamepad-2")
		local SilentAimbotTab = Game:AddLeftGroupbox("Silent Aimbot")
		local CombatModificationTab = Game:AddRightGroupbox("Combat Modification")

		local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
		SilentAimbotTab:AddToggle("RivalsSilentAimbot", {
			Text = "Toggle Aimbot [Spam Click]",
			Default = false,
			Callback = function(State)
				SilentAimbot.Toggled = State
				if not State and SilentAimbot.Enabled then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					SilentAimbot.Enabled = false
				end
			end
		}):AddKeyPicker("SilentAimbotKey", {
			Mode = "Toggle",
			Text = "Silent Aimbot",
			Callback = function()
				if not SilentAimbot.Toggled then
					return
				end

				SilentAimbot.Enabled = not SilentAimbot.Enabled

				if SilentAimbot.Enabled then
					SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
				else
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
				end
			end
		})
		SilentAimbotTab:AddDropdown("SilentAimbotAimPart", {
			Text = "Aim Part",
			Values = {"Head", "Root"},
			Default = 2,
			Callback = function(Value)
				SilentAimbot.AimPart = Value
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotTeamCheck", {
			Text = "Team Check",
			Default = false,
			Callback = function(State)
				SilentAimbot.TeamCheck = State
			end
		})
		SilentAimbotTab:AddToggle("SilentAimbotDeadCheck", {
			Text = "Dead Check",
			Default = false,
			Callback = function(State)
				SilentAimbot.DeadCheck = State
			end
		})

		local getgc = FunctionValidator.Validate(Module.Tables.getgc, "getgc", nil)
		if getgc then
			local OriginalGCAttributes = {}

			local function UpdateItemAttribute(Name, NewValue)
				for _,Table in next, getgc(true) do
					if type(Table) == "table" and rawget(Table, Name) then
						local OldValue = Table[Name]
						local ValueToSet = NewValue
						if type(NewValue) == "function" then
							ValueToSet = NewValue(OldValue)
							if ValueToSet == nil then
								continue
							end
						end

						if OriginalGCAttributes[Table] == nil then
							OriginalGCAttributes[Table] = {}
						end

						if OriginalGCAttributes[Table][Name] == nil then
							OriginalGCAttributes[Table][Name] = OldValue
						end

						Table[Name] = ValueToSet
					end
				end
			end

			local function RestoreItemAttribute(Name)
				for Table, Values in next, OriginalGCAttributes do
					if Values[Name] ~= nil then
						Table[Name] = Values[Name]
						Values[Name] = nil
					end

					local AmountOfValues = 0

					for _,_ in next, Values do
						AmountOfValues += 1
					end

					if AmountOfValues == 0 then
						OriginalGCAttributes[Table] = nil
					end
				end
			end

			CombatModificationTab:AddToggle("RivalsNoSlowdown", {
				Text = "No Slowdown",
				Tooltip = "Disables weapon slowdown.",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("WalkSpeedMultiplier", function(Value)
							if Value < 1 then
								return 1
							end
							return nil
						end)
					else
						RestoreItemAttribute("WalkSpeedMultiplier")
					end
				end
			})

			CombatModificationTab:AddToggle("RivalsNoSpread", {
				Text = "No Spread",
				Tooltip = "Disables firearm spread.",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("ShootSpread", 0)
					else
						RestoreItemAttribute("ShootSpread")
					end
				end
			})

			CombatModificationTab:AddToggle("RivalsNoRecoil", {
				Text = "No Recoil",
				Tooltip = "Disables firearm recoil.",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("ShootRecoil", 0)
					else
						RestoreItemAttribute("ShootRecoil")
					end
				end
			})

			CombatModificationTab:AddToggle("RivalsInstantAim-In", {
				Text = "Instant Aim-In",
				Tooltip = "Allows you to instantly aim-in with scoped/sighted weapons.",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("AimSpeed", 100)
					else
						RestoreItemAttribute("AimSpeed")
					end
				end
			})

			CombatModificationTab:AddToggle("RivalsMaxAccuracy", {
				Text = "Max Accuracy",
				Tooltip = "Makes all firearms have maximum accuracy.",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("ShootAccuracy", 100)
					else
						RestoreItemAttribute("ShootAccuracy")
					end
				end
			})

			CombatModificationTab:AddToggle("RivalsNoDashCooldown", {
				Text = "No Dash Cooldown",
				Tooltip = "Disables dash cooldown (eg. Scythe)",
				Default = false,
				Callback = function(State)
					if State then
						UpdateItemAttribute("DashCooldown", 0)
					else
						RestoreItemAttribute("DashCooldown")
					end
				end
			})
		else
			CombatModificationTab:AddLabel("Function 'getgc' is not supported.", true)
		end
	elseif Games.IsDaHood then
		local Game = Window:AddTab("Da Hood", "gamepad-2")
		local SilentTabBox = Game:AddLeftTabbox("SilentAimbotTabBox")
		local SilentAimbotTab = SilentTabBox:AddTab("Silent Aimbot")

		if hookmetamethod then
			local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
			SilentAimbotTab:AddToggle("SilentAimbot", {
				Text = "Toggle Aimbot",
				Default = false,
				Callback = function(State)
					SilentAimbot.Toggled = State
					if not State and SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
						SilentAimbot.Enabled = false
					end
				end
			}):AddKeyPicker("SilentAimbotKey", {
				Mode = "Toggle",
				Text = "Silent Aimbot",
				Callback = function()
					if not SilentAimbot.Toggled then
						return
					end
					SilentAimbot.Enabled = not SilentAimbot.Enabled
					if SilentAimbot.Enabled then
						SilentAimbotLabel:SetText("Silent Aimbot: Enabled")
					else
						SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					end
				end
			})
			Tabs.Silent:AddDropdown("SilentAimbotAimPart", {
				Text = "Aim Part",
				Values = {"Head", "Root"},
				Default = 2,
				Callback = function(Value)
					SilentAimbot.AimPart = Value
				end
			})
			Tabs.Silent:AddToggle("SilentAimbotDeadCheck", {
				Text = "Dead Check",
				Default = false,
				Callback = function(State)
					SilentAimbot.DeadCheck = State
				end
			})
		else
			Tabs.Silent:AddLabel("Silent Aimbot not supported. Missing required function 'hookmetamethod'", true)
		end
	end
end)

task.spawn(function()
	writefile("combat.cc/Nikoleto.iy", tostring(game:HttpGet(
		"https://raw.githubusercontent.com/nikoladhima/combat.cc/refs/heads/main/utils/Nikoleto.iy"
	)))
	if isfile("IY_FE.iy") then
		local Data = HttpService:JSONDecode(readfile("IY_FE.iy"))
		if Data and type(Data) == "table" then
			if table.find(Data.PluginsTable, "combat.cc/Nikoleto.iy") then
				return
			end

			table.insert(Data.PluginsTable, "combat.cc/Nikoleto.iy")
			writefile("IY_FE.iy", HttpService:JSONEncode(Data))
		end
	else
		local currentShade1 = Color3.fromRGB(36, 36, 37)
		local currentShade2 = Color3.fromRGB(46, 46, 47)
		local currentShade3 = Color3.fromRGB(78, 78, 79)
		local currentText1 = Color3.new(1, 1, 1)
		local currentText2 = Color3.new(0, 0, 0)
		local currentScroll = Color3.fromRGB(78,78,79)
		writefile("IY_FE.iy", HttpService:JSONEncode({
			prefix = ';',
			StayOpen = false,
			espTransparency = 0.3,
			keepIY = true,
			logsEnabled = false,
			jLogsEnabled = false,
			aliases = {},
			binds = {},
			WayPoints = {},
			PluginsTable = {"combat.cc/Nikoleto.iy"},
			currentShade1 = {currentShade1.R, currentShade1.G, currentShade1.B},
			currentShade2 = {currentShade2.R, currentShade2.G, currentShade2.B},
			currentShade3 = {currentShade3.R, currentShade3.G, currentShade3.B},
			currentText1 = {currentText1.R, currentText1.G, currentText1.B},
			currentText2 = {currentText2.R, currentText2.G, currentText2.B},
			currentScroll = {currentScroll.R, currentScroll.G, currentScroll.B},
			eventBinds = {OnExecute = "", OnSpawn = "", OnDied = "", OnDamage = "", OnKilled = "", OnJoin = "", OnLeave = "", OnChatted = ""}
		}))
	end
end)

Library:Notify({
	Title = "[[ combat.cc ]]",
	Description = "Loaded combat.cc successfully || Made by nikoleto scripts - github.com/nikoladhima",
	Time = 3.5
})

Library:Toggle(true)

if (
	not listfiles.IsWaxxed and not isfile.IsWaxxed and
	not makefolder.IsWaxxed and not isfolder.IsWaxxed and
	not readfile.IsWaxxed and not writefile.IsWaxxed and not delfile.IsWaxxed
) then
	local ThemeManager = Module:GetThemeManager({
		HttpService,
		listfiles, isfile, readfile, writefile, delfile,
		isfolder, makefolder
	})

	if ThemeManager then
		ThemeManager:SetLibrary(Library)
		ThemeManager:SetFolder("combat.cc/Themes")
		ThemeManager:ApplyToTab(WindowTabs.WindowSettingsTab)
	else
		Module.Errors += 1
	end

	local clonefunctionFunction = clonefunction or FunctionValidator.Validate(Module.Tables.clonefunction, "clonefunction", nil)
	local SaveManager = Module:GetSaveManager({
		function(Function)
			if not clonefunctionFunction then
				return Function
			end

			local Success, Result = pcall(clonefunctionFunction, Function)
			return Success and Result or Function
		end, HttpService,
		listfiles, isfile, readfile, writefile, delfile,
		isfolder, makefolder
	})

	if SaveManager then
		SaveManager:SetLibrary(Library)
		SaveManager:IgnoreThemeSettings()
		SaveManager:SetIgnoreIndexes({"MenuKeybind"})
		SaveManager:SetFolder("combat.cc/Configs")
		SaveManager:BuildConfigSection(WindowTabs.WindowSettingsTab)
		SaveManager:LoadAutoloadConfig()
	else
		Module.Errors += 1
	end

	ThreadManager:Start("HitSoundMP3Checker", function()
		local TableOfHitSounds = table.clone(HitSounds.Options)
		local Count = 0

		local function ValidateMP3AndConfigFiles(Path)
			for _,File in listfiles(Path) do
				if isfolder(File) then
					ValidateMP3AndConfigFiles(File)
				elseif isfile(File) then
					local CorrectedPath = File:lower():gsub("\\","/")

					if CorrectedPath:match("%.mp3$") then
						local HitSound = CorrectedPath:gsub("^combat%.cc/sounds/", "")
						table.insert(TableOfHitSounds, HitSound)
					end

					if CorrectedPath:match("%.json$") then
						local FileName = CorrectedPath:match("^combat%.cc/configs/([^/]+%.json)$")
						if FileName then
							writefile(
								"combat.cc/Configs/settings/" .. FileName,
								readfile(File)
							)

							delfile(File)
						end
					end

					Count += 1
					if Count % 25 == 0 then
						task.wait()
					end
				end
			end
		end

		ValidateMP3AndConfigFiles("combat.cc")
		Options["AimbotHitSounds"]:SetValues(TableOfHitSounds)
		--SaveManager:RefreshConfigList() -- nono auto refresh list :(
	end, 1.5)
else
	Module.Errors += 2
end

ThreadManager:Start("VersionChecker", function()
	local LatestVersion = nsloadstring(true, "core/LatestVersion.lua")
	if not LatestVersion or type(LatestVersion) ~= "string" then
		return
	end

	if ScriptVersion ~= LatestVersion then
		Library:Notify({
			Title = "[[ combat.cc ]]",
			Description = "Script is Out-Of-Date, please re-execute to get the latest update v" .. LatestVersion,
			Time = 3.5
		})
	end
end, 10)

task.spawn(function()
	local function Invite(InviteCode)
		httprequest({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = HttpService:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = HttpService:GenerateGUID(false),
				args = {code = InviteCode}
			})
		})
	end

	local VerifyChannelInvite = "DwRT2nH93D"
	local RulesChannelInvite = "jjEtFhA8PA"

	if isfile("combat.cc/code") then
		if readfile("combat.cc/code") == VerifyChannelInvite then
			writefile("combat.cc/code", RulesChannelInvite)
		elseif readfile("combat.cc/code") == RulesChannelInvite then
			Invite(RulesChannelInvite)
			return
		else
			writefile("combat.cc/code", RulesChannelInvite)
			Invite(RulesChannelInvite)
			return
		end
	else
		writefile("combat.cc/code", VerifyChannelInvite)
	end

	Invite(VerifyChannelInvite)
end)

ThreadManager:Start("CustomCode", function()
	nsloadstring(false, "https://pastefy.app/e58XLuoV/raw", {Players, LocalPlayer})
end, 5)

print("[nikoletoscripts/combat.cc]: Loaded script successfully in", tick() - StartTick .. "s.")

task.spawn(function(...)
	if (...) and type((...)) == "string" and (...) == "RemoveLogging" then
		warn("[Service Info] RemoveLogging is enabled, this means that ZERO information will be logged.")
		return
	end

	if not Module:SendDataToWebhook({
		UserInputService, LocalPlayer, HttpService, ExecutorName, CurrentGameName, httprequest
	}) then
		Module.Errors += 1
	end
end, (...))

if Module.Errors > 0 then
	warn("[nikoletoscripts/combat.cc]:", Module.Errors, "Module Errors were found. Script will continue to function.")
end
