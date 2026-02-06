if workspace.DistributedGameTime < 3 then
	task.wait(3 - workspace.DistributedGameTime)
end

local Running = true
local StartTick = tick()
local ScriptVersion = "2.5.3early"
local IsDeveloperBuild = false

print("[nikoletoscripts/combat.cc]: Loading script..")

local UtilsRepo = "https://raw.githubusercontent.com/nikoladhima/combat.cc/main/utils/"

local function nsloadstring(Url, ...)
	if type(Url) ~= "string" then
		warn("nsloadstring expected a string, got " .. typeof(Url))
	end

	local VariableArguments = (...)

	local Success, Result = pcall(function()
		return loadstring(game:HttpGet(Url))(VariableArguments)
	end)

	return Success and Result or {Value = "Unknown"}
end

local FileFunctions = {
    listfiles = listfiles or list_files or function(...)
        return {}
    end,
    makefolder = makefolder or make_folder or createfolder or create_folder or function(...)
        return true
    end,
    isfolder = isfolder or is_folder or function(...)
        return false
    end,
    isfile = isfile or is_file or function(...)
        return false
    end,
    readfile = readfile or read_file or readfileasync or read_file_async or function(...)
        return "{}"
    end,
    writefile = writefile or write_file or writefileasync or write_file_async or function(...)
        return true
    end,
    delfile = delfile or del_file or deletefile or delete_file or function(...)
        return true
    end
}

if not FileFunctions.isfolder("combat.cc") then
	FileFunctions.makefolder("combat.cc")
end

if not FileFunctions.isfolder("combat.cc/Sounds") then
	FileFunctions.makefolder("combat.cc/Sounds")
end

local Library = nsloadstring("https://raw.githubusercontent.com/nikoladhima/Obsidian/main/Library.lua")
local Options = Library.Options
local Toggles = Library.Toggles
local Watermark = Library:AddDraggableLabel("[nikoletoscripts/combat.cc] | Unknown | 0 | 0")
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/nikoladhima/Obsidian/main/addons/SaveManager.lua"))()

local identifyexecutor = identifyexecutor or identify_executor or getexecutorname or get_executor_name or function()
	return "Unknown"
end

local isrbxactive = isrbxactive or is_rbx_active or function()
	return true
end

local mouse1press = mouse1press or mouse1_press or mouse_1_press
local mouse1release = mouse1release or mouse1_release or mouse_1_release
local mousemoverel = mousemoverel or mouse_moverel or mousemove_rel or mouse_move_rel or MouseMoveRel or setmousepos or set_mouse_pos

local newcclosure = newcclosure or new_cclosure or newc_closure or new_c_closure or function(...)
	return (...)
end

if identifyexecutor():lower():find("solara") then
	hookmetamethod = nil -- fuck you solara for faking a global function
end

local hookmetamethod = hookmetamethod or hook_metamethod or hook_metamethod or hook_meta_method
local getnamecallmethod = getnamecallmethod or getnamecall_method or get_namecallmethod or get_namecall_method

local setfflagFunction = setfflag or set_fflag
local function nssetfflag(...)
	if not setfflagFunction then
		return false, "function missing"
	end
	return pcall(setfflagFunction, ...)
end

local clonefunctionFunction = clonefunction or clone_function or copyfunction or copy_function
local nsclonefunction = function(Function)
	if not clonefunctionFunction then
		return Function
	end

	local Success, Result = pcall(clonefunctionFunction, Function)
	return Success and Result or Function
end

local clonerefFunction = cloneref or clone_ref or clonereference or clone_reference
local nscloneref = function(Object)
	if not clonerefFunction then
		return Object
	end

	local Success, Result = pcall(clonerefFunction, Object)
	return Success and Result or Object
end

local getcustomassetFunction = getcustomasset or get_customasset or get_custom_asset
local function nsgetcustomasset(File)
	if not getcustomassetFunction then
		return "rbxassetid://0"
	end
	local Success, Result = pcall(getcustomassetFunction, File)
	return Success and Result or "rbxassetid://0"
end

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

local CreateInstance = nsclonefunction(Instance.new)
local GetServiceFunction = nsclonefunction(game.GetService)
local function GetService(ServiceName)
	return nscloneref(GetServiceFunction(game, ServiceName))
end

local function Create(Type, Properties)
	if Properties then
		local Object = nscloneref(CreateInstance(Type))

		for Property, Value in next, Properties do
			local PropertySuccess, Error = pcall(function()
				Object[Property] = Value
			end)
			if not PropertySuccess then
				print("[DEBUG] Error setting", Property, "on", Type .. ":", Error)
			end
		end

		return Object
	else
		return nscloneref(CreateInstance(Type))
	end
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
	InfiniteJump = nil,
	NoJumpDelay = nil,
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

local CachedPlayers = {}
local Camera = nil
local ViewportSize = Vector2.zero
local ScreenCenter = Vector2.zero
local ViewportSizeX = 0
local ViewportSizeY = 0
local LocalPlayer = Players.LocalPlayer
local PlayerGui = nscloneref(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
local Mouse = nscloneref(LocalPlayer:GetMouse())
local MouseLocation = Vector2.zero
local LocalCharacter = nil
local LocalHumanoid = nil
local LocalHead = nil
local LocalRoot = nil

local CachedRobloxGui = nil
local CachedClippingShield = nil
local CachedSettingsShield = nil

local CameraModeClassic = Enum.CameraMode.Classic
local CameraModeLockFirstPerson = Enum.CameraMode.LockFirstPerson
local CameraTypeCustom = Enum.CameraType.Custom
local RigTypeR15 = Enum.HumanoidRigType.R15
local KeyCodeW = Enum.KeyCode.W
local KeyCodeA = Enum.KeyCode.A
local KeyCodeS = Enum.KeyCode.S
local KeyCodeD = Enum.KeyCode.D
local KeyCodeSpace = Enum.KeyCode.Space
local KeyCodeRightControl = Enum.KeyCode.RightControl

local Vector3PlusHoundredY = Vector3.new(0, 100, 0)
local Vector3MinusHoundredY = Vector3.new(0, -100, 0)
local ESPHeadOffset = Vector3.new(0, 1.5, 0)
local R6Neck = Vector3.new(0, 0.4, 0)
local R6Waist = Vector3.new(0, -0.5, 0)
local R6Top = Vector3.new(0, 0.5, 0)
local R6Bottom = Vector3.new(0, -0.5, 0)
local CFrameZero = CFrame.new(0, 0, 0)
local FixedBottomCenter = Vector2.zero

task.spawn(function()
	local httprequest = httprequest or http_request or request or HttpPost or (http and http.request) or (syn and syn.request) or function(...)
		return (...)
	end

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

	if FileFunctions.isfile("combat.cc/code") then
		if FileFunctions.readfile("combat.cc/code") == VerifyChannelInvite then
			FileFunctions.writefile("combat.cc/code", RulesChannelInvite)
		elseif FileFunctions.readfile("combat.cc/code") == RulesChannelInvite then
			Invite(RulesChannelInvite)
			return
		else
			FileFunctions.writefile("combat.cc/code", RulesChannelInvite)
			Invite(RulesChannelInvite)
			return
		end
	else
		FileFunctions.writefile("combat.cc/code", VerifyChannelInvite)
	end
	Invite(VerifyChannelInvite)
end)

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

	TeamCheck = false,
	DeadCheck = false,
}

local TriggerBot = {
	Toggled = false,
	Enabled = false,

	Target = nil,

	TeamCheck = false,
	DeadCheck = false,
	DeadCheckMode = "Universal",
	CustomDeadCheckValue = 0,

	TriggerDelay = 0.1,
}

local AimbotFOVCircles = {
	FOVCircle = nil,
	S_FOVCircle = nil
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
	Folder = Create("Folder", {Parent = CoreGui})
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
	AutoJump = false
}
local OldCameraMaxZoomDistance = 0

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
}

local ChinaHat = {
    ChinaHatTrail = nil,
    ChinaHatColor = Color3.fromRGB(255, 0, 0),
    ChinaHatTrailSize = Vector3.new(3, 0.7, 3),
    ChinaHatMeshScale = Vector3.new(3, 0.6, 3),
}
local OldDevCameraOcclusionMode = LocalPlayer.DevCameraOcclusionMode
local SelectedPlayer = nil

local ESPUtils = nsloadstring(UtilsRepo .. "ESPUtils.lua")
local ESPObjects = {}

local ESPToggled = false
local ESPWallCheck = false
local ESPTeamCheck = false

local ChamESP = {
	Enabled = false,
	FillColor = Color3.fromRGB(255, 255, 255),
	OutlineColor = Color3.fromRGB(255, 255, 255),
	FillTransparency = 0.5,
	OutlineTransparency = 0
}

local ProfileESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Transparency = 1,
	ShowBackground = false,
	BackgroundColor = Color3.fromRGB(255, 255, 255),
	BackgroundTransparency = 1
}

local HeadDotESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Filled = false,
	Transparency = 1
}

local HeadTagESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Dropdown = "Name",
	Transparency = 1
}
local TagBuffer = {}

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

local BoxESP = {
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
}

local BoxPointScreen = table.create(8)
local BoxPointOnScreen = table.create(8)

local Box3DOffsets = {
	Vector3.new(-2, 3, -1.5), Vector3.new(2, 3, -1.5),
    Vector3.new(-2, -3, -1.5), Vector3.new(2, -3, -1.5),
    Vector3.new(-2, 3, 1.5), Vector3.new(2, 3, 1.5),
	Vector3.new(-2, -3, 1.5), Vector3.new(2, -3, 1.5)
}

local Box3DEdges = {
	{1,2}, {2,4}, {4,3}, {3,1},
	{5,6}, {6,8}, {8,7}, {7,5},
	{1,5}, {2,6}, {3,7}, {4,8}
}

local HealthBarESP = {
	Enabled = false,
	Color = Color3.new(255, 255, 255),
	Thickness = 2,
	Transparency = 1
}

local SkeletonESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255),
	Thickness = 1,
	Transparency = 1
}
local SkeletonCachePoints = {}
local SkeletonCacheVisible = {}

local R15SkeletonLines = {
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
	LightingTechnology = Lighting.Technology,
	OldLightingTechnology = tostring(Lighting.Technology):gsub("Enum.Technology.", ""),
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

local Games = {}
for Variable, GameId in next, {
    IsArsenal = 111958650,
	IsArsenal2020Revival = 7823128924,
	IsArsenalRefreshed = 8607106986,
    IsKatBeta = 1102720506,
    IsFlick = 8795154789,
	IsKatX = 8250618750,
	IsOneTap = 9294074907,
	IsQuickShot = 9323860275,
	IsStrucid = 833423526,
	IsDaHood = 1008451066,
    MurderersVSSheriffsDUELS = 4348829796,
    IsGunGroundsFFA = 4281211770,
	IsCounterBloxReImagined = 9606714812,
    IsCounterBlox = 115797356,
    IsAimblox = 2585430167,
    IsRivals = 6035872082,
    IsDefuseDivision = 7072674902,
	IsSniperArena = 9534705677,
	IsCombatArena = 5421899973,
    IsPrisonLife = 73885730,
	IsBloxStrike = 7633926880,
	IsWarTycoon = 1526814825
} do
    Games[Variable] = (tostring(game.GameId) == tostring(GameId))
end

local PlayerJoinLogs = false
local PlayerLeaveLogs = false

workspace.FallenPartsDestroyHeight = -math.huge

local function InsertToConnections(Connection)
	table.insert(Connections, Connection)
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

local CreateDrawing = function(...)
	return nil
end

if Drawing then
    local DrawingNew = Drawing.new or Drawing.draw
    if DrawingNew then
        CreateDrawing = function(Type, Properties)
            local Success, DrawingObject = pcall(function()
                return DrawingNew(Type)
            end)

            if not Success then
                print("[DEBUG] Error creating", Type .. ":", DrawingObject)
                return nil
            end

            if Properties then
                for Property, Value in next, Properties do
                    local PropertySuccess, Error = pcall(function()
						if DrawingObject[Property] then
                        	DrawingObject[Property] = Value
						end
                    end)
                    if not PropertySuccess then
                        print("[DEBUG] Error setting", Property, "on", Type .. ":", Error)
                    end
                end
            end

            return DrawingObject
        end
    end
end

MouseLocation = UserInputService:GetMouseLocation()
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

AimbotFOVCircles.FOVCircle = ESPUtils.new(CreateDrawing("Circle", {
	Color = Aimbot.FOVCircle.Color,
	Filled = Aimbot.FOVCircle.Filled,
	Thickness = Aimbot.FOVCircle.Thickness,
	Radius = Aimbot.FOVCircle.Radius,
	Visible = false
}))

AimbotFOVCircles.S_FOVCircle = ESPUtils.new(CreateDrawing("Circle", {
	Color = SilentAimbot.FOVCircle.Color,
	Filled = SilentAimbot.FOVCircle.Filled,
	Thickness = SilentAimbot.FOVCircle.Thickness,
	Radius = SilentAimbot.FOVCircle.Radius,
	Visible = false
}))

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
elseif Games.IsKatX then
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

		if EnemyOutline.FillColor == Color3.fromRGB(255, 0, 0) then
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

local function GetArsenalHealthInstance(Player)
	local Cache = CachedPlayers[Player]

	if not Cache then
		return
	end

	local NRPBS = Cache.NRPBS
	return Cache and (NRPBS and NRPBS:FindFirstChild("Health") or nil) or nil
end

local IsDead = nil
if Games.IsArsenal or Games.IsArsenal2020Revival or Games.IsArsenalRefreshed then
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true
		end

		local Player = Players:GetPlayerFromCharacter(Character)
		if not Player then
			return true
		end

		local Cache = CachedPlayers[Player]
		if not Cache then
			return true
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true
		end

		local HealthInstance = GetArsenalHealthInstance(Player)
		if (HealthInstance and HealthInstance.Value or 0) <= ((Mode == "Custom") and CustomValue or 0) then
			return true
		end

		return false
	end
elseif Games.IsAimblox or Games.IsSniperArena then
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true
		end

		local Player = Players:GetPlayerFromCharacter(Character)

		if (Player:GetAttribute("Health") or 0) <= ((Mode == "Custom") and CustomValue or 0) then
			return true
		end

		local Cache = CachedPlayers[Player]
		if not Cache then
			return true
		end

		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true
		end

		return false
	end
elseif Games.IsDefuseDivision then
	IsDead = function(Character, ...)
		if not Character then
			return true
		end

		local Cache = CachedPlayers[Players:GetPlayerFromCharacter(Character)]
		if not Cache then
			return true
		end

		local Humanoid = Cache.Humanoid

		if not Humanoid then
			return true
		end

		if Humanoid.Health <= 0 then
			return true
		end

		return false
	end
else
	IsDead = function(Character, Mode, CustomValue)
		if not Character then
			return true
		end

		local Cache = CachedPlayers[Players:GetPlayerFromCharacter(Character)]
		if not Cache then
			return true
		end
  
		local Humanoid = Cache.Humanoid
		if not Humanoid then
			return true
		end

		if Humanoid.Health <= ((Mode == "Custom") and CustomValue or 0) then
			return true
		end

		return false
	end
end

local function IsBehindWall(Origin, TargetPosition, Character)
	if not Character then
		return false
	end

	CachedRaycastParams.FilterDescendantsInstances = {LocalCharacter, Camera}
    local Result = workspace:Raycast(Origin, TargetPosition - Origin, CachedRaycastParams)

	if not Result then
        return false
    end

    return not Result.Instance:IsDescendantOf(Character)
end

local function CreateESP()
	local ESP = {}

	ESP.HeadDot = ESPUtils.new(CreateDrawing("Circle", {
		Color = HeadDotESP.Color,
		Radius = 4,
		Filled = true,
		Visible = false
	}))

	ESP.HeadTag = ESPUtils.new(CreateDrawing("Text", {
		Text = "",
		Color = HeadTagESP.Color,
		Size = 16,
		Center = true,
		Outline = true,
		Visible = false
	}))

	ESP.Tracer = ESPUtils.new(CreateDrawing("Line", {
		Color = TracerESP.Color,
		Thickness = 2,
		Visible = false
	}))

	ESP.Arrow = ESPUtils.new(CreateDrawing("Triangle", {
		Color = ArrowESP.Color,
        Thickness = 2,
		Visible = false
	}))

	ESP.Box2D = ESPUtils.new(CreateDrawing("Square", {
		Thickness = 2,
		Size = Vector2.one * 50,
		Color = BoxESP.Box2D.Color,
		Visible = false
	}))

	ESP.Box3D = {}
	for i = 1, 12 do
		ESP.Box3D[i] = ESPUtils.new(CreateDrawing("Line", {
			Color = BoxESP.Box3D.Color,
			Thickness = 2,
			Visible = false
		}))
	end

    ESP.HealthBarOutline = ESPUtils.new(CreateDrawing("Square", {
        Filled = true,
        Color = HealthBarESP.Color,
        Transparency = 1,
        Visible = false
    }))

    ESP.HealthBarFill = ESPUtils.new(CreateDrawing("Line", {
        Color = Color3.new(0, 1, 0),
        Transparency = 1,
        Visible = false
    }))

    ESP.Skeleton = {}
    for i = 1, 16 do
        ESP.Skeleton[i] = ESPUtils.new(CreateDrawing("Line", {
            Thickness = 1,
            Color = SkeletonESP.Color,
            Transparency = 1,
            Visible = false
        }))
    end

	return ESP
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
			if Index == "Cham" or Index == "Profile" then
				Object:Destroy()
				continue
			end

			if Index == "Box3D" or Index == "Skeleton" then
				for _,DrawingObject in next, Object do
					DrawingObject:Nil()
				end
				continue
			end

			Object:Nil()
		end
	end

	CachedPlayers[Player] = nil
end

local function CachePlayer(Player)
	if Player == LocalPlayer or not Player then
		return
	end

	local Character = Player.Character

	if not Character then
		ClearCache(Player)
		return
	end

	local Cache = CachedPlayers[Player] or {}

	local Name = Player.Name
	Cache.Name = Name
	Cache.DisplayName = Player.DisplayName

	Cache.NRPBS = Player:FindFirstChild("NRPBS")

	Cache.Character = Character
	Cache.Humanoid = Character:FindFirstChildOfClass("Humanoid")

	local Head = Character:FindFirstChild("Head")
	Cache.Head = Head
	Cache.Torso = Character:FindFirstChild("Torso")
	Cache.Root = Character:FindFirstChild("HumanoidRootPart")

	Cache["Left Arm"] = Character:FindFirstChild("Left Arm")
	Cache["Right Arm"] = Character:FindFirstChild("Right Arm")

	Cache["Left Leg"] = Character:FindFirstChild("Left Leg")
	Cache["Right Leg"] = Character:FindFirstChild("Right Leg")

	Cache.LeftUpperArm = Character:FindFirstChild("LeftUpperArm")
	Cache.LeftLowerArm = Character:FindFirstChild("LeftLowerArm")
	Cache.RightUpperArm = Character:FindFirstChild("RightUpperArm")
	Cache.RightLowerArm = Character:FindFirstChild("RightLowerArm")

	Cache.LeftHand = Character:FindFirstChild("LeftHand")
	Cache.RightHand = Character:FindFirstChild("RightHand")

	Cache.UpperTorso = Character:FindFirstChild("UpperTorso")
	Cache.LowerTorso = Character:FindFirstChild("LowerTorso")

	Cache.LeftUpperLeg = Character:FindFirstChild("LeftUpperLeg")
	Cache.RightUpperLeg = Character:FindFirstChild("RightUpperLeg")
	Cache.LeftLowerLeg = Character:FindFirstChild("LeftLowerLeg")
	Cache.RightLowerLeg = Character:FindFirstChild("RightLowerLeg")

	Cache.LeftFoot = Character:FindFirstChild("LeftFoot")
	Cache.RightFoot = Character:FindFirstChild("RightFoot")

	local ESP = Cache.ESP or CreateESP()
	Cache.ESP = ESP

	local Cham = ESP.Cham
	if not Cham then
		ESP.Cham = Create("Highlight", {
			Enabled = false,
			Name = "Cham_" .. Name,
			Adornee = Character,
			Parent = CoreGui
		})
	end

	local Profile = ESP.Profile
	if not Profile then
		local BillboardGui = Create("BillboardGui", {
			Enabled = false,
			Name = "Profile_" .. Name,
			Size = UDim2.fromScale(1, 1),
			StudsOffsetWorldSpace = Vector3.new(0, 1.75, 0),
			AlwaysOnTop = true,
			ResetOnSpawn = false,
			Adornee = Head,
			Parent = CoreGui
		})
		ESP.Profile = BillboardGui
		Create("ImageLabel", {
			Name = "Thumbnail",
			Size = UDim2.fromScale(1, 1),
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. Player.UserId .. "&w=420&h=420",
			Parent = BillboardGui
		})
	end

	for Index, Object in next, ESP do
		if Index == "Box3D" or Index == "Skeleton" then
			for _,DrawingObject in next, Object do
				table.insert(ESPObjects, DrawingObject)
			end
			continue
		end

		table.insert(ESPObjects, Object)
	end

	CachedPlayers[Player] = Cache
end

local function AddCache(Player)
	CachePlayer(Player)
	InsertToConnections(Player.CharacterAdded:Connect(function()
		CachePlayer(Player)
	end))
	InsertToConnections(Player.CharacterRemoving:Connect(function()
		ClearCache(Player)
	end))
end

task.spawn(function()
	while true do
		if not Running then
			break
		end

		for _,Player in ipairs(Players:GetPlayers()) do
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

		task.wait(1.5)
	end
end)

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
		Create("Sound", {
			SoundId = "rbxassetid://" .. AssetId,
			Volume = Volume,
			PlayOnRemove = true,
			Parent = HitSounds.Folder
		}):Destroy()
		return
	end

	if Option:sub(-4):lower() ~= ".mp3" then
		warn("[combat.cc] Could not find sound:", Option)
		return
	end

	local Path = ("combat.cc/Sounds/" .. Option):gsub("\\", "/")

	if not FileFunctions.isfile(Path) then
		warn("[combat.cc] Sound file missing:", Path)
		return
	end

	Create("Sound", {
		SoundId = nsgetcustomasset(Path),
		Volume = Volume,
		PlayOnRemove = true,
		Parent = HitSounds.Folder
	}):Destroy()
end

local CurrentGameName = "Unknown"
task.spawn(function()
	local GameSuccess,_ = pcall(function()
		local Name = MarketplaceService:GetProductInfo(game.PlaceId).Name
		CurrentGameName = Name
	end)
	if not GameSuccess then
		CurrentGameName = "Unknown"
		task.wait(10)
		CurrentGameName = MarketplaceService:GetProductInfo(game.PlaceId).Name
	end
end)

local CurrentFPS = nsloadstring(UtilsRepo .. "FPS.lua", RunService)
local CurrentPing = 0
local RawCurrentPing = 0

task.spawn(function()
	local DataPing = GetService("Stats").Network.ServerStatsItem["Data Ping"]
	local SavedCurrentFPS = CurrentFPS.Value
	local Ping = DataPing:GetValue()
	CurrentPing = math.floor(Ping)
	RawCurrentPing = Ping

	while true do
		if not Running then
			break
		end

		local CurrentFPSValue = CurrentFPS.Value
		if SavedCurrentFPS ~= CurrentFPSValue then
			SavedCurrentFPS = CurrentFPSValue
			local Ping = DataPing:GetValue()
			CurrentPing = math.floor(Ping)
			RawCurrentPing = Ping
		end

		task.wait()
	end
end)

InsertToConnections(RunService.RenderStepped:Connect(function()
	Watermark:SetText("[nikoletoscripts/combat.cc] | " .. CurrentGameName .. " | FPS: " .. CurrentFPS.Value .. " | Ping: " .. CurrentPing)
end))

local function SetEnabled(Object, State)
	if Object.Enabled ~= State then
		Object.Enabled = State
	end
end

local function SetSize(DrawingObject, Size)
	if DrawingObject.Size ~= Size then
		DrawingObject.Size = Size
	end
end

local function SetTransparency(DrawingObject, Transparency)
	if DrawingObject.Transparency ~= Transparency then
		DrawingObject.Transparency = Transparency
	end
end

local function UpdateFOVCircle(FOVCircle, FOVCircleTable, AimbotTable)
	if not FOVCircle then
		return
	end

	if not FOVCircleTable.Enabled then
		FOVCircle:Visible(false)
	end

	FOVCircle:Color(FOVCircleTable.Color):Filled(FOVCircleTable.Filled):Thickness(
		FOVCircleTable.Thickness
	):Radius(FOVCircleTable.Radius):Transparency(
		FOVCircleTable.Transparency
	):Position(
		FOVCircleTable.Position == "Center" and ScreenCenter or MouseLocation
	):Visible(AimbotTable.Toggled and FOVCircleTable.Enabled)
end

local function CanRenderVisually(Player, Character, Humanoid, Head, Root, RootPosition, IsArsenal, IsArsenal2020Revival, IsArsenalRefreshed, IsAimblox)
	if not Player or not Character or not Humanoid or not Root or not Head then
		return false
	end

	if not Character.Parent or not Root.Parent or not Head.Parent or not Humanoid.Parent then
		return false
	end

	if Humanoid.Health <= 0 then
		return false
	end

	if ESPTeamCheck and not IsEnemy(Player) then
		return false
	end

	if IsArsenal or IsArsenal2020Revival or IsArsenalRefreshed then
		local HealthInstance = GetArsenalHealthInstance(Player)
		if HealthInstance and HealthInstance.Value <= 0 then
			return false
		end
	elseif IsAimblox then
		if (Player:GetAttribute("Health") or 0) <= 0 then
			return false
		end
	end

	if LocalRoot then
		if ESPWallCheck and IsBehindWall(LocalRoot.Position, RootPosition, Character) then
			return false
		end
	end

	return true
end

local HideAll = ESPUtils.HideAll
local function HideESP(ESP)
    if not ESP then
		return
	end

    HideAll(ESP)

    if ESP.Box3D then
        for _, Line in next, ESP.Box3D do
            Line:Visible(false)
        end
    end

    if ESP.Skeleton then
        for _, Line in next, ESP.Skeleton do
            Line:Visible(false)
        end
    end
end

local GetDistanceSquared = ESPUtils.GetDistanceSquared

InsertToConnections(RunService.RenderStepped:Connect(function()
	UpdateFOVCircle(AimbotFOVCircles.FOVCircle, Aimbot.FOVCircle, Aimbot)
	UpdateFOVCircle(AimbotFOVCircles.S_FOVCircle, SilentAimbot.FOVCircle, SilentAimbot)

	if not ESPToggled or not Camera then
		for _,Cache in next, CachedPlayers do
			HideESP(Cache.ESP)
		end
		return
	end

    local ChamEnabled = ChamESP.Enabled
    local ChamFillColor = ChamESP.FillColor
    local ChamOutlineColor = ChamESP.OutlineColor
    local ChamFillTransparency = ChamESP.FillTransparency
    local ChamOutlineTransparency = ChamESP.OutlineTransparency

    local ProfileEnabled = ProfileESP.Enabled
    local ProfileColor = ProfileESP.Color
    local ProfileTransparency = ProfileESP.Transparency
    local ProfileShowBackground = ProfileESP.ShowBackground
    local ProfileBackgroundColor = ProfileESP.BackgroundColor
    local ProfileBackgroundTransparency = ProfileESP.BackgroundTransparency

	local HeadDotEnabled = HeadDotESP.Enabled
	local HeadDotColor = HeadDotESP.Color
	local HeadDotTransparency = HeadDotESP.Transparency

	local HeadTagEnabled = HeadTagESP.Enabled
	local HeadTagColor = HeadTagESP.Color
	local HeadTagTransparency = HeadTagESP.Transparency
	local HeadTagDropdown = HeadTagESP.Dropdown

	local TracerEnabled = TracerESP.Enabled
	local TracerColor = TracerESP.Color
	local TracerTransparency = TracerESP.Transparency
	local TracerTypeIsLocked = TracerESP.Type == "Locked"
	local TracerPartIsHead = TracerESP.Part == "Head"

	local ArrowEnabled = ArrowESP.Enabled
	local ArrowColor = ArrowESP.Color
	local ArrowFilled = ArrowESP.Filled
	local ArrowRadius = ArrowESP.Radius
	local ArrowTransparency = ArrowESP.Transparency

	local Box2D = BoxESP.Box2D
	local Box2DEnabled = Box2D.Enabled
	local Box2DColor = Box2D.Color
	local Box2DTransparency = Box2D.Transparency

	local Box3D = BoxESP.Box3D
	local Box3DEnabled = Box3D.Enabled
	local Box3DColor = Box3D.Color
	local Box3DTransparency = Box3D.Transparency

	local HealthBarEnabled = HealthBarESP.Enabled
	local HealthBarColor = HealthBarESP.Color
	local HealthBarThickness = HealthBarESP.Thickness
	local HealthBarTransparency = HealthBarESP.Transparency

	local SkeletonEnabled = SkeletonESP.Enabled
	local SkeletonColor = SkeletonESP.Color
	local SkeletonThickness = SkeletonESP.Thickness
	local SkeletonTransparency = SkeletonESP.Transparency

	local IsArsenal = Games.IsArsenal
	local IsArsenal2020Revival = Games.IsArsenal2020Revival
	local IsArsenalRefreshed = Games.IsArsenalRefreshed
	local IsDefuseDivision = Games.IsDefuseDivision
	local IsAimblox = Games.IsAimblox

	for Player, Cache in next, CachedPlayers do
		local ESP = Cache.ESP
		if not ESP then
			continue
		end

		local Character = Cache.Character
		local Humanoid = Cache.Humanoid
		local Head = Cache.Head
		local Root = Cache.Root
		local RootPosition = Root and Root.Position

		if not CanRenderVisually(Player, Character, Humanoid, Head, Root, RootPosition, IsArsenal, IsArsenal2020Revival, IsArsenalRefreshed, IsAimblox) then
			HideESP(ESP)
			continue
		end

		local HeadPosition = Head.Position
		local HeadScreen, HeadOnScreen = WorldToViewportPoint(HeadPosition)
		local RootScreen, RootOnScreen = WorldToViewportPoint(RootPosition)

		if not HeadOnScreen and not RootOnScreen then
			HideESP(ESP)
			continue
		end

		local TopScreen, TopOnScreen = nil, false
		local TopScreenX, TopScreenY = 0, 0

		if HeadTagEnabled or Box2DEnabled or HealthBarEnabled then
			TopScreen, TopOnScreen = WorldToViewportPoint(HeadPosition + ESPHeadOffset)
			TopScreenX, TopScreenY = TopScreen.X, TopScreen.Y
		end

		local ChamObject = ESP.Cham
		local ProfileObject = ESP.Profile
		local HeadDotObject = ESP.HeadDot
		local HeadTagObject = ESP.HeadTag
		local TracerObject = ESP.Tracer
		local ArrowObject = ESP.Arrow
		local Box2DObject = ESP.Box2D
		local Box3DLines = ESP.Box3D
		local HBOutline = ESP.HealthBarOutline
		local HBFill = ESP.HealthBarFill
		local SkeletonLines = ESP.Skeleton

		if ChamEnabled and ChamObject then
			ChamObject.FillColor = ChamFillColor
			ChamObject.OutlineColor = ChamOutlineColor
			ChamObject.FillTransparency = ChamFillTransparency
			ChamObject.OutlineTransparency = ChamOutlineTransparency
			SetEnabled(ChamObject, true)

			for _,Object in ipairs(Character:GetChildren()) do
				if Object:IsA("Highlight") then
					if Object.Name ~= "Cham_" .. Cache.Name then
						SetEnabled(Object, false)
					end
				end
			end
		elseif ChamObject then
			SetEnabled(ChamObject, false)
		end

        if ProfileEnabled and ProfileObject then
			local Thumbnail = ProfileObject["Thumbnail"]
			Thumbnail.ImageColor3 = ProfileColor
			Thumbnail.ImageTransparency = ProfileTransparency
			if ProfileShowBackground then
				Thumbnail.BackgroundColor3 = ProfileBackgroundColor
				Thumbnail.BackgroundTransparency = ProfileBackgroundTransparency
			else
				Thumbnail.BackgroundTransparency = 1
			end
			SetEnabled(ProfileObject, true)
		elseif ProfileObject then
			SetEnabled(ProfileObject, false)
		end

		if HeadDotEnabled and HeadDotObject and HeadOnScreen then
			HeadDotObject:Color(HeadDotColor):Transparency(HeadDotTransparency):Position(HeadScreen):Visible(true)
		elseif HeadDotObject then
			HeadDotObject:Visible(false)
		end

		local RigTypeIsR15
		if HeadTagEnabled or SkeletonEnabled then
			RigTypeIsR15 = Humanoid.RigType == RigTypeR15
		end

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
								elseif IsArsenal or IsArsenal2020Revival or IsArsenalRefreshed then
									local NRPBS = Cache.NRPBS
									if NRPBS then
										local Tool = NRPBS:FindFirstChild("EquippedTool")
										if Tool then
											ToolName = Tool.Value
										end
									end
								else
									local Tool = Character:FindFirstChildOfClass("Tool")
									if Tool then
										ToolName = Tool.Name
									end
								end
								OptionText = ToolName
							elseif Option == "Health" then
								if IsArsenal or IsArsenal2020Revival or IsArsenalRefreshed then
									local HealthInstance = GetArsenalHealthInstance(Player)
									OptionText = tostring(HealthInstance and HealthInstance.Value or 0)
								elseif IsAimblox then
									OptionText = (Player:GetAttribute("Health") or 0) .. " Health"
								else
									OptionText = math.floor(Humanoid.Health) .. " Health"
								end
							elseif Option == "Distance" then
								OptionText =  math.floor(LocalRoot and (LocalRoot.Position - RootPosition).Magnitude or 0) .. " Studs Away"
							elseif Option == "RigType" then
								OptionText = RigTypeIsR15 and "R15" or "R6"
							end

							table.insert(TagBuffer, OptionText)
						end
					end

					HeadTagString = table.concat(TagBuffer, " | ")
				end
			end

			HeadTagObject:Color(HeadTagColor):Transparency(HeadTagTransparency):Position(TopScreen):Text(HeadTagString):Center(true):Visible(true)
		elseif HeadTagObject then
			HeadTagObject:Visible(false)
		end

		local FootScreen, FootOnScreen = nil, false
		local FootScreenY = 0

		if Box2DEnabled or HealthBarEnabled then
			FootScreen, FootOnScreen = WorldToViewportPoint(RootPosition - Vector3.new(0, Humanoid.HipHeight + 2, 0))
			FootScreenY = FootScreen.Y
		end

		if TracerEnabled and TracerObject and RootOnScreen then
			TracerObject:Color(TracerColor):Transparency(TracerTransparency):From(
				TracerTypeIsLocked and FixedBottomCenter or MouseLocation
			):To(TracerPartIsHead and HeadScreen or RootScreen):Visible(true)
		elseif TracerObject then
			TracerObject:Visible(false)
		end

		if ArrowEnabled and ArrowObject and RootOnScreen then
			local Direction = (RootScreen - ScreenCenter).Unit

			if Direction ~= Direction then
				Direction = Vector2.zero
			end

			local ArrowCenter = ScreenCenter + Direction * ArrowRadius
			local Offset = Vector2.new(-Direction.Y, Direction.X) * 7.5

			ArrowObject:Color(ArrowColor):Filled(ArrowFilled):Transparency(
				ArrowTransparency
			):PointA(ArrowCenter + Direction * 15):PointB(
				ArrowCenter - Offset
			):PointC(ArrowCenter + Offset):Visible(true)
		elseif ArrowObject then
			ArrowObject:Visible(false)
		end

		local TopAndFootOnScreen = (TopOnScreen and FootOnScreen)
		local ShouldBox2D = (Box2DEnabled and Box2DObject)
		local ShouldHealthBar = (HealthBarEnabled and HBOutline and HBFill)
		local BoxHealthBarHeight = 0
		local BoxHealthBarWidth = 0
		local TopScreenXBoxHealthBarWidthOffset = 0

		if TopAndFootOnScreen and (ShouldBox2D or ShouldHealthBar) then
			BoxHealthBarHeight = math.abs(FootScreenY - TopScreenY)
			BoxHealthBarWidth = BoxHealthBarHeight * 0.5
			TopScreenXBoxHealthBarWidthOffset = TopScreenX - BoxHealthBarWidth * 0.5
		end

		if ShouldBox2D and TopAndFootOnScreen then
			Box2DObject:Color(Box2DColor):Transparency(Box2DTransparency):Size(
				Vector2.new(BoxHealthBarWidth, BoxHealthBarHeight)
			):Position(Vector2.new(TopScreenXBoxHealthBarWidthOffset, TopScreenY)):Visible(true)
		elseif Box2DObject then
			Box2DObject:Visible(false)
		end

        if Box3DEnabled and RootOnScreen then
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
                    Line:Color(Box3DColor):Transparency(Box3DTransparency):From(BoxPointScreen[P1]):To(BoxPointScreen[P2]):Visible(true)
                else
                    Line:Visible(false)
                end
            end
        else
            for Index = 1, 12 do
                Box3DLines[Index]:Visible(false)
            end
        end

		if ShouldHealthBar and TopAndFootOnScreen then
			local HealthPercentage = 0
			local BarX = TopScreenXBoxHealthBarWidthOffset - 4 - HealthBarThickness
			local LineCenterX = BarX + (HealthBarThickness * 0.5)

			if IsArsenal or IsArsenal2020Revival or IsArsenalRefreshed then
				local HealthInstance = GetArsenalHealthInstance(Player)
				if HealthInstance then
					HealthPercentage = math.clamp(HealthInstance.Value / Humanoid.MaxHealth, 0, 1)
				end
			else
				HealthPercentage = math.clamp(Humanoid.Health / Humanoid.MaxHealth, 0, 1)
			end

			HBOutline:Color(HealthBarColor):Transparency(HealthBarTransparency):Size(
				Vector2.new(HealthBarThickness + 2, BoxHealthBarHeight + 2)
			):Position(Vector2.new(BarX - 1, TopScreenY - 1)):Visible(true)

			HBFill:Color(Color3.fromHSV(HealthPercentage * 0.3, 1, 1)):Transparency(
				HealthBarTransparency
			):Thickness(
				HealthBarThickness
			):From(Vector2.new(LineCenterX, FootScreenY)):To(
				Vector2.new(LineCenterX, FootScreenY - BoxHealthBarHeight * HealthPercentage)
			):Visible(true)
		elseif HBOutline and HBFill then
			HBOutline:Visible(false)
			HBFill:Visible(false)
		end

		if SkeletonEnabled and RootOnScreen then
			if RigTypeIsR15 then
				for Index = 1, #R15SkeletonLines do
					local Line = SkeletonLines[Index]
					local BonePair = R15SkeletonLines[Index]
					
					local Part1 = Cache[BonePair[1]]
					local Part2 = Cache[BonePair[2]]

					if Part1 and Part2 then
						local PositionOne, OnScreenOne = WorldToViewportPoint(Part1.Position)
						local PositionTwo, OnScreenTwo = WorldToViewportPoint(Part2.Position)

						if OnScreenOne and OnScreenTwo then
							Line:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(PositionOne):To(PositionTwo):Visible(true)
						else
							Line:Visible(false)
						end
					else
						Line:Visible(false)
					end
				end

				for Index = #R15SkeletonLines + 1, #SkeletonLines do
					SkeletonLines[Index]:Visible(false)
				end
			else
				local Torso = Cache.Torso

				if Torso then
					local TorsoCFrame = Torso.CFrame
					local TorsoSize = Torso.Size

					local NeckWorldPosition = TorsoCFrame:PointToWorldSpace(TorsoSize * R6Neck)
					local WaistWorldPosition = TorsoCFrame:PointToWorldSpace(TorsoSize * R6Waist)

					local NeckScreenPosition, NeckOnScreen = WorldToViewportPoint(NeckWorldPosition)
					local WaistScreen, WaistOnScreen = WorldToViewportPoint(WaistWorldPosition)

					local SpineLine = SkeletonLines[1]
					if NeckOnScreen and WaistOnScreen then
						SpineLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
							SkeletonTransparency
						):From(NeckScreenPosition):To(WaistScreen):Visible(true)
					else
						SpineLine:Visible(false)
					end

					local NeckLine = SkeletonLines[2]
					if NeckOnScreen and HeadOnScreen then
						NeckLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
							SkeletonTransparency
						):From(NeckScreenPosition):To(HeadScreen):Visible(true)
					else
						NeckLine:Visible(false)
					end

					local LeftArm = Cache["Left Arm"]
					local LeftShoulderLine, LeftArmLine = SkeletonLines[3], SkeletonLines[4]

					if LeftArm then
						local LeftArmCFrame = LeftArm.CFrame
						local LeftArmSize = LeftArm.Size

						local ShoulderScreen, ShoulderOnScreen = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Top))
						local HandScreen, HandOnScreen = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Bot))

						if NeckOnScreen and ShoulderOnScreen then
							LeftShoulderLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(NeckScreenPosition):To(ShoulderScreen):Visible(true)
						else
							LeftShoulderLine:Visible(false)
						end

						if ShoulderOnScreen and HandOnScreen then
							LeftArmLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(ShoulderScreen):To(HandScreen):Visible(true)
						else
							LeftArmLine:Visible(false)
						end
					else
						LeftShoulderLine:Visible(false)
						LeftArmLine:Visible(false)
					end

					local RightArm = Cache["Right Arm"]
					local RightShoulderLine, RightArmLine = SkeletonLines[5], SkeletonLines[6]

					if RightArm then
						local RightArmCFrame = RightArm.CFrame
						local RightArmSize = RightArm.Size
						
						local ShoulderScreen, ShoulderOnScreen = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Top))
						local HandScreen, HandOnScreen = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Bottom))

						if NeckOnScreen and ShoulderOnScreen then
							RightShoulderLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(NeckScreenPosition):To(ShoulderScreen):Visible(true)
						else
							RightShoulderLine:Visible(false)
						end

						if ShoulderOnScreen and HandOnScreen then
							RightArmLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(ShoulderScreen):To(HandScreen):Visible(true)
						else
							RightArmLine:Visible(false)
						end
					else
						RightShoulderLine:Visible(false)
						RightArmLine:Visible(false)
					end

					local LeftLeg = Cache["Left Leg"]
					local LeftHipLine, LeftLegLine = SkeletonLines[7], SkeletonLines[8]

					if LeftLeg then
						local LeftLegCFrame = LeftLeg.CFrame
						local LeftLegSize = LeftLeg.Size

						local HipScreen, HipOnScreen = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Top))
						local LeftLegScreen, LeftLegOnScreen = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Bottom))

						if WaistOnScreen and HipOnScreen then
							LeftHipLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(WaistScreen):To(HipScreen):Visible(true)
						else
							LeftHipLine:Visible(false)
						end

						if HipOnScreen and LeftLegOnScreen then
							LeftLegLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(HipScreen):To(LeftLegScreen):Visible(true)
						else
							LeftLegLine:Visible(false)
						end
					else
						LeftHipLine:Visible(false)
						LeftLegLine:Visible(false)
					end

					local RightLeg = Cache["Right Leg"]
					local RightHipLine, RightLegLine = SkeletonLines[9], SkeletonLines[10]

					if RightLeg then
						local RightLegCFrame = RightLeg.CFrame
						local RightLegSize = RightLeg.Size

						local HipScreen, HipOnScreen = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Top))
						local RightLegScreen, RightLegOnScreen = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Bottom))

						if WaistOnScreen and HipOnScreen then
							RightHipLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(WaistScreen):To(HipScreen):Visible(true)
						else
							RightHipLine:Visible(false)
						end

						if HipOnScreen and RightLegOnScreen then
							RightLegLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(HipScreen):To(RightLegScreen):Visible(true)
						else
							RightLegLine:Visible(false)
						end
					else
						RightHipLine:Visible(false)
						RightLegLine:Visible(false)
					end
				else
					for Index = 1, 10 do
						SkeletonLines[Index]:Visible(false)
					end
				end

				for Index = 11, #SkeletonLines do
					SkeletonLines[Index]:Visible(false)
				end
			end
		else
			for Index = 1, #SkeletonLines do
				SkeletonLines[Index]:Visible(false)
			end
		end

        table.clear(SkeletonCachePoints)
        table.clear(SkeletonCacheVisible)
	end
end))

local function RotatePoint(Center, Point, Angle)
    local Rad = math.rad(Angle)
    local Cos = math.cos(Rad)
    local Sin = math.sin(Rad)

	local CenterX = Center.X
	local CenterY = Center.Y

    local DX = Point.X - CenterX
    local DY = Point.Y - CenterY

    return Vector2.new(CenterX + (DX * Cos - DY * Sin), CenterY + (DX * Sin + DY * Cos))
end

InsertToConnections(RunService.RenderStepped:Connect(function(DeltaTime)
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
            table.insert(DrawingLines, ESPUtils.new(CreateDrawing("Line", {
                Visible = false,
                Thickness = 1,
                Color = CrosshairOverlay.Color,
                Transparency = CrosshairOverlay.Transparency
            })))
        end

		local Dot = Drawings.Dot
        if Dot then
			Dot:Nil()
        end
    end

    local DotStyle = CrosshairOverlay.DotStyle
	local Dot = Drawings.Dot
    if not Dot or CrosshairOverlay.DotLastStyle ~= DotStyle then
        CrosshairOverlay.DotLastStyle = DotStyle
        Drawings.Dot = ESPUtils.new(CreateDrawing(DotStyle, {
            Visible = false,
            Filled = true,
            Color = CrosshairOverlay.DotColor,
            Transparency = CrosshairOverlay.Transparency
        }))
    end

    local DotObject = Drawings.Dot
    local CrosshairOverlayEnabled = CrosshairOverlay.Enabled

    if CrosshairOverlayEnabled and CrosshairOverlay.DotEnabled then
        if CrosshairOverlay.DotStyle == "Circle" then
            DotObject:Radius(CrosshairOverlay.DotSize):Position(MouseLocation)
        else
            local DotSize = Vector2.one * CrosshairOverlay.DotSize
            DotObject:Size(DotSize):Position(MouseLocation - (DotSize * 0.5))
        end
        DotObject:Color(CrosshairOverlay.DotColor):Transparency(CrosshairOverlay.Transparency):Visible(true)
    else
        DotObject:Visible(false)
    end

    if CrosshairOverlayEnabled then
        local CrosshairOverlayGap = CrosshairOverlay.Gap
        local CrosshairOverlayLength = CrosshairOverlay.Length

        for Index = 1, 4 do
            local MainLine = DrawingLines[Index]

            if CrosshairOverlay.TStyle and Index == 1 then
                MainLine:Visible(false)
                continue
            end

            if CrosshairOverlayLength <= 0 then
                MainLine:Visible(false)
                continue
            end

            local Direction = CrosshairOverlay.BaseOffsets[Index]

            MainLine:Color(CrosshairOverlay.Color):Thickness(CrosshairOverlay.Thickness):Transparency(
				CrosshairOverlay.Transparency
			):From(
				RotatePoint(MouseLocation, MouseLocation + (Direction * CrosshairOverlayGap), CurrentRotation
			)):To(
				RotatePoint(MouseLocation, MouseLocation + (Direction * (CrosshairOverlayGap + CrosshairOverlayLength)), CurrentRotation)
			):Visible(true)
        end
    else
        for _,Line in next, DrawingLines do
            Line:Visible(false)
        end
    end
end))

local function GetPredictedPosition(AimbotType, Position, AssemblyLinearVelocity)
	local PredictionConfiguration = PredictionSettings[AimbotType]
	local AimbotConfiguration = PredictionConfiguration.AimbotConfiguration

	if AimbotConfiguration.AutoPrediction then
		return Position + AssemblyLinearVelocity * (RawCurrentPing * PredictionConfiguration.AutoPredictionMultiplier)
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

local function TriggerHitFunctions(PreviousHealth, Health, Cache)
	if not HitConfiguration.Toggled then
		return
	end

	local Log = HitConfiguration.Log
	if Log.Enabled then
		local HealthHit = math.floor(PreviousHealth - Health)
		if HealthHit ~= 0 then
			Library:Notify({
				Title = "Hit Logs (Camera Aimbot)",
				Description = Log.UseColor and Log.Color and
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
	if Marker.Enabled then
		local WorldPosition = Cache["Last" .. Aimbot.AimPart .. "Position"]
		if WorldPosition then
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
				Dot = ESPUtils.new(CreateDrawing("Circle", {
					NumSides = 24,
					Filled = true,
					Thickness = 2,
					Color = Color,
					Transparency = 1,
					Visible = false
				})):Radius(2 * Scale)
			end

			if IsClassicX or IsBrokenX or IsPlus then
				for _ = 1, 4 do
					Lines[#Lines + 1] = ESPUtils.new(CreateDrawing("Line", {
						Thickness = 2,
						Color = Color,
						Transparency = 1,
						Visible = false
					}))
				end
			elseif IsCircle then
				Circle = ESPUtils.new(CreateDrawing("Circle", {
					NumSides = 24,
					Filled = false,
					Thickness = 2,
					Color = Color,
					Transparency = 1,
					Visible = false
				})):Radius(Size)
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
			Connection = RunService.RenderStepped:Connect(function()
				if not Running then
					for _,Line in ipairs(Lines) do
						Line:Nil()
					end

					if Circle then
						Circle:Nil()
					end

					if Dot then
						Dot:Nil()
					end

					Connection:Disconnect()
					Connection = nil
				end
				local ElapsedTime = tick() - StartTime
				if ElapsedTime >= Lifetime then
					for _,Line in ipairs(Lines) do
						Line:Nil()
					end

					if Circle then
						Circle:Nil()
					end

					if Dot then
						Dot:Nil()
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

				for _,Line in ipairs(Lines) do
					Line:Transparency(Alpha):Visible(false)
				end

				if Circle then
					Circle:Transparency(Alpha):Visible(false)
				end

				if Dot then
					Dot:Transparency(Alpha):Visible(false)
				end

				if not OnScreen then
					for _,Line in ipairs(Lines) do
						Line:Visible(false)
					end

					if Circle then
						Circle:Visible(false)
					end

					if Dot then
						Dot:Visible(false)
					end

					return
				end

				if IsClassicX then
					for Index = 1, 4 do
						local Direction = HitMarkerDirections[Index]
						Lines[Index]:From(Screen + Direction):To(Screen + Direction * Size):Visible(true)
					end
				elseif IsBrokenX then
					local Gap = Size * 0.35
					for Index = 1, 4 do
						local Direction = HitMarkerDirections[Index]
						Lines[Index]:From(Screen + Direction * Gap):To(Screen + Direction * Size):Visible(true)
					end
				elseif IsPlus then
					for Index = 1, 4 do
						Lines[Index]:From(Screen):To(Screen + Offsets[Index]):Visible(true)
					end
				elseif IsCircle and Circle then
					Circle:Position(Screen):Visible(true)
				end

				if Dot then
					Dot:Position(Screen):Visible(true)
				end
			end)
		end
	end

	local Sound = HitConfiguration.Sound
	if Sound.Enabled then
		PlayHitSound(Sound.Selected, Sound.Volume)
	end
end

local function StopAimbot()
	local Connection = Connections.Aimbot
	if Connection then
		Connection:Disconnect()
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
			local AimbotAimPartIsHead = AimbotAimPart == "Head"
			local FOVCircle = Aimbot.FOVCircle
			local ClosestDistance = FOVCircle.Enabled and FOVCircle.Radius or math.huge
			local IsRivals = Games.IsRivals
			local DeadCheck = Aimbot.DeadCheck
			local ForceFieldCheck = Aimbot.ForceFieldCheck
			local SitCheck = Aimbot.SitCheck
			local WallCheck = Aimbot.WallCheck

			for Player, Cache in next, CachedPlayers do
				if Aimbot.TeamCheck then
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

				if SitCheck and not IsRivals then
					if Cache.Humanoid.Sit then
						continue
					end
				end

				if ForceFieldCheck then
					if Character:FindFirstChildOfClass("ForceField") then
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
						if WallCheck then
							local LocalAimPart = AimbotAimPartIsHead and LocalHead or LocalRoot

							if not LocalAimPart then
								ClosestDistance = Distance
								Aimbot.Target = Player
								return
							end

							if IsBehindWall(LocalAimPart.Position, AimPartPosition, Character) then
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

		TargetAimbot = function(Target)
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

			local AimPart = nil
			local LocalAimPartPosition = Vector3.zero

			if Aimbot.AimPart == "Head" then
				AimPart = Cache.Head
				if LocalHead then
					LocalAimPartPosition = LocalHead.Position
				end
			else
				AimPart = Cache.Root
				if LocalRoot then
					LocalAimPartPosition = LocalRoot.Position
				end
			end

			local Humanoid = Cache.Humanoid

			local HealthToBeReturned = 0
			if Games.IsArsenal or Games.IsArsenal2020Revival or Games.IsArsenalRefreshed then
				local HealthInstance = GetArsenalHealthInstance(Target)
				if HealthInstance then
					local PreviousHealth = HitConfiguration.PreviousHealth
					local ArsenalHealth = HealthInstance.Value

					if PreviousHealth == nil then
						PreviousHealth = ArsenalHealth
					end

					if ArsenalHealth < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, ArsenalHealth, Cache)
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
					TriggerHitFunctions(PreviousHealth, AimbloxHealth, Cache)
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
						TriggerHitFunctions(PreviousHealth, Health, Cache)
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
				if not LocalRoot or IsBehindWall(LocalAimPartPosition, AimPartPosition, Character) then
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

			return HealthToBeReturned, (LocalAimPartPosition - AimPartPosition).Magnitude
		end
	},
	Mouse = {
		GetClosestPlayer = function()
			Aimbot.Target = nil
			HitConfiguration.PreviousHealth = nil

			local AimbotAimPart = Aimbot.AimPart
			local AimbotAimPartIsHead = AimbotAimPart == "Head"
			local FOVCircle = Aimbot.FOVCircle
			local ClosestDistance = FOVCircle.Enabled and FOVCircle.Radius or math.huge
			local IsRivals = Games.IsRivals
			local DeadCheck = Aimbot.DeadCheck
			local ForceFieldCheck = Aimbot.ForceFieldCheck
			local SitCheck = Aimbot.SitCheck
			local WallCheck = Aimbot.WallCheck

			for Player, Cache in next, CachedPlayers do
				if Aimbot.TeamCheck then
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

				if SitCheck and not IsRivals then
					if Cache.Humanoid.Sit then
						continue
					end
				end

				if ForceFieldCheck then
					if Character:FindFirstChildOfClass("ForceField") then
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
					if WallCheck then
						local LocalAimPart = AimbotAimPartIsHead and LocalHead or LocalRoot

						if not LocalAimPart then
							ClosestDistance = Distance
							Aimbot.Target = Player
							return
						end

						if LocalAimPart and IsBehindWall(LocalAimPart.Position, AimPartPosition, Character) then
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

		TargetAimbot = function(Target)
			if not isrbxactive() then
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

			local HealthToBeReturned = 0
			if Games.IsArsenal or Games.IsArsenal2020Revival or Games.IsArsenalRefreshed then
				local HealthInstance = GetArsenalHealthInstance(Target)
				if HealthInstance then
					local PreviousHealth = HitConfiguration.PreviousHealth
					local ArsenalHealth = HealthInstance.Value

					if PreviousHealth == nil then
						PreviousHealth = ArsenalHealth
					end

					if ArsenalHealth < PreviousHealth then
						TriggerHitFunctions(PreviousHealth, ArsenalHealth, Cache)
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
					TriggerHitFunctions(PreviousHealth, AimbloxHealth, Cache)
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
						TriggerHitFunctions(PreviousHealth, Health, Cache)
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

			local AimbotAimPart = Aimbot.AimPart
			local AimPart = nil
			local LocalAimPartPosition = Vector3.zero
			if AimbotAimPart == "Head" then
				AimPart = Cache.Head
				if LocalHead then
					LocalAimPartPosition = LocalHead.Position
				end
			else
				AimPart = Cache.Root
				if LocalRoot then
					LocalAimPartPosition = LocalRoot.Position
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
				if not LocalRoot or IsBehindWall(LocalAimPartPosition, AimPartPosition, Character) then
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
					AimPart.AssemblyLinearVelocity = (AimPart.CFrame.Position - AimPartPosition) / (tick() - Start)
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

			local dx, dy = Screen.X - Mouse.X, Screen.Y - Mouse.Y

			if math.abs(dx) < 0.5 then
				dx = 0
			end

			if math.abs(dy) < 0.5 then
				dy = 0
			end

			local Smoothness = Aimbot.SmoothnessOffset

			if Smoothness <= 1 then
				Smoothness = 1.25
			end

			dx = dx / Smoothness
			dy = dy / Smoothness

			local SettingsShield = GetSettingsShield()
			if not SettingsShield or not SettingsShield.Visible then
				mousemoverel(dx, dy)
			end

			return HealthToBeReturned, (LocalAimPartPosition - AimPartPosition).Magnitude
		end
	}
}

if not Games.Aimblox and not Games.IsStrucid then
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

			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end
		end

		if isrbxactive() then
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
			if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
				return
			end

			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end
		else
			local Humanoid = ModelInstance:FindFirstChildOfClass("Humanoid")
			if not Humanoid or Humanoid:FindFirstChildOfClass("Status") then
				return
			end
		end

		if isrbxactive() then
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
			if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
				return
			end

			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end
		else
			if not ModelInstance:FindFirstChild("NPCAnimate") then
				return
			end
		end

		if isrbxactive() then
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

		if TriggerBot.DeadCheck and IsDead(ModelInstance, TriggerBot.DeadCheckMode, TriggerBot.CustomDeadCheckValue) then
			return
		end

		if TriggerBot.TeamCheck and not IsEnemy(Player) then
			return
		end

		if isrbxactive() then
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
	end
end)

local function CacheLocalPlayer()
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
end

local ControlTurn = nil
if Games.IsCounterBloxReImagined then
	task.spawn(function()
		ControlTurn = ReplicatedStorage:WaitForChild("Events"):WaitForChild("ControlTurn")
	end)
end

local CFrameAA = nil
if Games.IsCounterBloxReImagined then
	CFrameAA = function()
		local AntiAimMode = AntiAim.CFrameMode

		if AntiAimMode == "None" then
			return
		end

		if AntiAimMode == "Randomizer" then
			local RNG = math.random(1, 3)
			if RNG == 1 then
				ControlTurn:FireServer(-3, false)
			elseif RNG == 2 then
				ControlTurn:FireServer(-10, false)
			else
				ControlTurn:FireServer(-1, false)
			end
		elseif AntiAimMode == "Backwards" then
			ControlTurn:FireServer(-3, false)
		elseif AntiAimMode == "Heavenly" then
			ControlTurn:FireServer(-10, false)
		elseif AntiAimMode == "Underground" then
			ControlTurn:FireServer(-1, false)
		end
	end
else
	CFrameAA = function()
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
end

local function VelocityAA()
	local AntiAimMode = AntiAim.VelocityMode

	if AntiAimMode == "None" then
		return
	end

	local ModeBehaviour = AntiAim.VelocityModeBehaviours[AntiAimMode]
	local RealVelocity = LocalRoot.AssemblyLinearVelocity
	local FakeVelocity = Vector3.zero

	local Success, Output = pcall(ModeBehaviour, LocalRoot)
	if Success and typeof(Output) == "Vector3" then
		FakeVelocity = Output
	end

	LocalRoot.AssemblyLinearVelocity = FakeVelocity
	RunService.RenderStepped:Wait()
	LocalRoot.AssemblyLinearVelocity = RealVelocity
end

if Games.IsCounterBloxReImagined then
	InsertToConnections(RunService.Heartbeat:Connect(function()
		CacheLocalPlayer()
		if LocalRoot and AntiAim.Enabled then
			VelocityAA()
		end
	end))

	task.spawn(function()
		while true do
			if not Running then
				break
			end

			if LocalRoot and AntiAim.Enabled then
				CFrameAA()
			end

			task.wait()
		end
	end)
else
	InsertToConnections(RunService.Heartbeat:Connect(function()
		CacheLocalPlayer()
		if LocalRoot and AntiAim.Enabled then
			VelocityAA()
			CFrameAA()
		end
	end))
end
Watermark:SetVisible(true)

local Window = nil
local WindowTabs = {
	WindowAimingTab = nil,
 	WindowTriggerBotTab = nil,
 	WindowPlayersTab = nil,
	WindowFFlagsTab = nil,
 	WindowVisualsTab = nil,
	WindowSettingsTab = nil
}
local UISuccess, UIOutput = pcall(function()
	if tostring(game.GameId) == "6765805766" then
		Window = Library:CreateWindow({
			Title = "combat.cc",
			Footer = "Version: v" .. ScriptVersion,
			Icon = "",
			Size = UDim2.fromOffset(1000, 520),
		})
		WindowTabs.WindowAimingTab = Window:AddTab("Target Aimbot", "")
		WindowTabs.WindowTriggerBotTab = Window:AddTab("TriggerBot", "")
		WindowTabs.WindowPlayersTab = Window:AddTab("LocalPlayer", "")
		WindowTabs.WindowVisualsTab = Window:AddTab("Visuals", "")
		WindowTabs.WindowFFlagsTab = Window:AddTab("FFlags", "")
		WindowTabs.WindowSettingsTab = Window:AddTab("Settings", "")
	else
		Window = Library:CreateWindow({
			Title = "combat.cc",
			Footer = "Version: v" .. ScriptVersion,
			Icon = "130975824766445",
			Size = UDim2.fromOffset(1000, 520),
		})
		WindowTabs.WindowAimingTab = Window:AddTab("Target Aimbot", "crosshair")
		WindowTabs.WindowTriggerBotTab = Window:AddTab("TriggerBot", "bot")
		WindowTabs.WindowPlayersTab = Window:AddTab("LocalPlayer", "users")
		WindowTabs.WindowVisualsTab = Window:AddTab("Visuals", "eye")
		WindowTabs.WindowFFlagsTab = Window:AddTab("FFlags", "globe")
		WindowTabs.WindowSettingsTab = Window:AddTab("Settings", "settings")
	end
end)
if not UISuccess then
	return LocalPlayer:Kick("Failed to set up UI, rejoin and try again.\n" .. tostring(UIOutput))
end
Library:Toggle(false)
local TabBoxes = {
	LocalPlayerTabBox = WindowTabs.WindowPlayersTab:AddLeftTabbox("LocalPlayerTabBox"),
	PlayersGroupBox = WindowTabs.WindowPlayersTab:AddRightGroupbox("Fun"),
	VisualsTabbox = WindowTabs.WindowVisualsTab:AddLeftTabbox("VisualsLeftTabbox"),
}
local Tabs = {
	Aimbot = WindowTabs.WindowAimingTab:AddLeftGroupbox("Aimbot | Camera & Mouse"),
	Target = WindowTabs.WindowAimingTab:AddRightGroupbox("Target View"),
	HitConfiguration = WindowTabs.WindowAimingTab:AddRightGroupbox("Hit Configuration"),
	TriggerBot = WindowTabs.WindowTriggerBotTab:AddLeftTabbox("TriggerBotTabBox"):AddTab("TriggerBot"),
}
local MovementTab = TabBoxes.LocalPlayerTabBox:AddTab("Movement")
local AntiAimTab = TabBoxes.LocalPlayerTabBox:AddTab("Anti Aim")
local VisualsESPTab = TabBoxes.VisualsTabbox:AddTab("ESP")
local VisualsWorldTab = TabBoxes.VisualsTabbox:AddTab("World")
local VisualsTabCrosshair = WindowTabs.WindowVisualsTab:AddRightGroupbox("Crosshair Overlay")
local FFlagsTab = WindowTabs.WindowFFlagsTab:AddLeftGroupbox("FFlags")
local SettingsTab = WindowTabs.WindowSettingsTab:AddLeftGroupbox("Settings")

if Games.IsRivals then
	Tabs.Aimbot:AddLabel("If you are using Camera Aimbot then it is recommended to Spam-Click and not Hold-Click.", true)
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

		GetClosestPlayer()

		Connections.Aimbot = RunService.RenderStepped:Connect(function()
			if not Aimbot.StickyAim then
				GetClosestPlayer()
			end

			local TargetView = Aimbot.TargetView
			local Target = Aimbot.Target
			local Health, Distance = TargetAimbot(Target)
			if Target then
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
		end)
	end
})
if not Games.IsAimblox and not Games.IsStrucid then
	if UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
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
	Default = Aimbot.ForceField,
	Callback = function(State)
		Aimbot.ForceField = State
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
	Default = Aimbot.CustomDeadCheckValue,
	Disabled = true,
	Min = 0,
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
	Default = (not Games.IsAimblox and not Games.IsStrucid) and Aimbot.SmoothnessOffset or 1,
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
		Connections.AimbotViewAtTarget = RunService.RenderStepped:Connect(function()
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
		end)
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
		Connections.AimbotLookAtTarget = RunService.RenderStepped:Connect(function()
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
		end)
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
local HitSoundsDropdown = Tabs.HitConfiguration:AddDropdown("AimbotHitSounds", {
	Text = "Sound",
	Values = HitSounds.Options,
	Default = 1,
	Callback = function(Sound)
		HitConfiguration.Sound.Selected = Sound
		PlayHitSound(Sound, HitConfiguration.Sound.Volume)
	end
})

if FileFunctions.listfiles and FileFunctions.isfolder and FileFunctions.makefolder and FileFunctions.isfile and getcustomassetFunction then
	task.spawn(function()
		local DefaultSounds = HitSounds.Options
		while true do
			local TableOfHitSounds = table.clone(DefaultSounds)

			for _,File in ipairs(FileFunctions.listfiles("combat.cc/Sounds")) do
				if FileFunctions.isfile(File) and File:sub(-4):lower() == ".mp3" then
					local Path = File:gsub("\\", "/"):gsub("^combat%.cc/Sounds/", "")
					table.insert(TableOfHitSounds, Path)
				end
			end

			HitSoundsDropdown:SetValues(TableOfHitSounds)

			task.wait(0.5)
		end
	end)
end

local TriggerBotLabel = Tabs.TriggerBot:AddLabel("TriggerBot: Disabled")
Tabs.TriggerBot:AddToggle("TriggerBotEnabled", {
	Text = "Toggle TriggerBot",
	Default = TriggerBot.Toggled,
	Callback = function(State)
		TriggerBotLabel:SetText("TriggerBot: Disabled")
		TriggerBot.Toggled = State
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
			Connections.TriggerBot = RunService.RenderStepped:Connect(Trigger)
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
Tabs.TriggerBot:AddToggle("TBTeamCheck", {
	Text = "Team Check",
	Default = TriggerBot.TeamCheck,
	Callback = function(value)
		TriggerBot.TeamCheck = value
	end
})
Tabs.TriggerBot:AddToggle("TBDeadCheck", {
	Text = "Dead Check",
	Default = TriggerBot.DeadCheck,
	Callback = function(value)
		TriggerBot.DeadCheck = value
	end
})
Tabs.TriggerBot:AddDropdown("TBDeadCheckMode", {
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
Tabs.TriggerBot:AddSlider("TBTriggerDelay", {
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

MovementTab:AddToggle("Fly", {
	Text = "Toggle Fly [UNSAFE]",
	Default = Movement.Fly.Toggled,
	Risky = true,
	Callback = function(State)
		Movement.Fly.Toggled = State
		if not State and Movement.Fly.Enabled then
			Movement.Fly.Enabled = false
			if Connections.Fly then
				Connections.Fly:Disconnect()
				Connections.Fly = nil
			end
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
		Connections.Fly = RunService.Heartbeat:Connect(function()
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
		end)
	end
})
MovementTab:AddSlider("FlySpeed", {
	Text = "Fly Speed",
	Default = Movement.Fly.SpeedValue,
	Min = 0,
	Max = 150,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		Movement.Fly.SpeedValue = Value
	end
})
MovementTab:AddToggle("Speed", {
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

		Connections.Speed = RunService.Heartbeat:Connect(function()
			if LocalHumanoid and LocalRoot then
				local MoveDirection = LocalHumanoid.MoveDirection
				if MoveDirection.Magnitude > 0 then
					LocalRoot.CFrame += MoveDirection * Movement.Speed.SpeedValue
				end
			end
		end)
	end
})
MovementTab:AddSlider("SpeedAmount", {
	Text = "Speed Amount",
	Default = 50,
	Min = 0,
	Max = 500,
	Rounding = 0,
	Compact = false,
	Callback = function(Amount)
		Movement.Speed.SpeedValue = Amount * 0.01
	end
})
MovementTab:AddLabel("SpinBot doesn't always work in First Person View.", true)
MovementTab:AddToggle("SpinBot", {
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
MovementTab:AddSlider("SpinBotAmount", {
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
MovementTab:AddToggle("ForceThirdPerson", {
	Text = "Force Third Person",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.ForceThirdPerson then
				Connections.ForceThirdPerson:Disconnect()
				Connections.ForceThirdPerson = nil
			end
			LocalPlayer.CameraMaxZoomDistance = OldCameraMaxZoomDistance
			return
		end
		OldCameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
		Connections.ForceThirdPerson = RunService.RenderStepped:Connect(function()
			LocalPlayer.CameraMode = CameraModeClassic
			LocalPlayer.CameraMaxZoomDistance = 9999
		end)
	end
})
MovementTab:AddButton({
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
MovementTab:AddToggle("InfiniteJump", {
	Text = "Infinite Jump [UNSAFE]",
	Default = false,
	Risky = true,
	Callback = function(State)
		if not State then
			if Connections.InfiniteJump then
				Connections.InfiniteJump:Disconnect()
				Connections.InfiniteJump = nil
			end
			return
		end
		Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
			if LocalHumanoid then
				LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end)
	end
})
MovementTab:AddToggle("NoJumpCooldown", {
	Text = "No Jump Cooldown [UNSAFE]",
	Default = false,
	Risky = true,
	Callback = function(State)
		if not State then
			if Connections.NoJumpDelay then
				Connections.NoJumpDelay:Disconnect()
				Connections.NoJumpDelay = nil
			end
			return
		end
		Connections.NoJumpDelay = UserInputService.JumpRequest:Connect(function()
			if LocalHumanoid then
				if LocalHumanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					LocalHumanoid.Jump = true
				end
			end
		end)
	end
})
MovementTab:AddToggle("Auto Jump", {
	Text = "Auto Jump [Hold Space]",
	Default = false,
	Risky = true,
	Callback = function(State)
		if State then
			if Connections.AutoJump then
				Connections.AutoJump:Disconnect()
				Connections.AutoJump = nil
			end
			return
		end
		Connections.AutoJump = RunService.Heartbeat:Connect(function()
			if not LocalHumanoid or UserInputService:GetFocusedTextBox() then
				return
			end

			if UserInputService:IsKeyDown(KeyCodeSpace) then
				if LocalHumanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					LocalHumanoid.Jump = true
				end
			end
		end)
	end
})

local AntiAimStatusLabel = AntiAimTab:AddLabel("Status: Disabled")
AntiAimTab:AddToggle("AntiAimToggle", {
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
AntiAimTab:AddLabel("CFrame doesn't always work in First Person View.", true)
AntiAimTab:AddDropdown("CFrameMode", {
	Text = "CFrame Mode",
	Values = Games.IsCounterBloxReImagined and {
		"None", "Randomizer", "Backwards", "Heavenly", "Underground"
	} or {"None", "Randomizer", "Backwards", "Left", "Right", "Jitter", "Reverse Jitter"},
	Default = 1,
	Callback = function(Mode)
		AntiAim.CFrameMode = Mode
	end
})
AntiAimTab:AddDropdown("VelocityMode", {
	Text = "Velocity Mode",
	Values = {"None", "Randomizer", "Heavenly", "Underground", "Look Vector", "Prediction Multiplier", "Prediction Changer", "Prediction Disabler"},
	Default = 1,
	Callback = function(Mode)
		AntiAim.VelocityMode = Mode
	end
})

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

        Connections.ChinaHat = RunService.Heartbeat:Connect(function()
            local LocalPart = LocalHead or LocalRoot

            if not LocalPart then
				return
			end

            local CurrentHat = ChinaHat.ChinaHatTrail

            if not CurrentHat or not CurrentHat.Parent then
                CurrentHat = Create("Part", {
					Name = "ChinaHat",
					Material = Enum.Material.Neon,
					CanCollide = false,
					CanQuery = false,
					CanTouch = false,
					Transparency = 0.3,
					Parent = Camera
				})


                local ChinaHatMesh = Create("SpecialMesh", {
					MeshType = Enum.MeshType.FileMesh,
					MeshId = "http://www.roblox.com/asset/?id=1778999",
					Parent = CurrentHat
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
        end)
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
		Connections.AnimationFreezer = RunService.Heartbeat:Connect(function()
			local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
			if AnimateInstance then
				AnimateInstance.Enabled = false
			end
		end)
	end
})

VisualsESPTab:AddToggle("ESPMasterSwitch", {
	Text = "Master Switch",
	Default = HitConfiguration.Toggled,
	Callback = function(State)
		ESPToggled = State
	end
})
VisualsESPTab:AddButton({
	Text = "Reset ESP Cache",
	Tooltip = "Click this if the ESP is frozen on your screen.",
	Func = function()
		for _,DrawingObject in next, ESPObjects do
			if typeof(DrawingObject) == "Instance" then
				DrawingObject:Destroy()
			else
				DrawingObject:Nil()
			end
		end

		if cleardrawcache then
			pcall(cleardrawcache)
		end

		for _,Player in ipairs(Players:GetPlayers()) do
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
	end
})
VisualsESPTab:AddLabel("Outline Color"):AddColorPicker("ChamOutlineColor", {
	Default = ChamESP.OutlineColor,
	Transparency = 0,
	Callback = function(Color)
		ChamESP.OutlineColor = Color
		ChamESP.OutlineTransparency = Options["ChamOutlineColor"].Transparency
	end
})

VisualsESPTab:AddDivider("Profile ESP")
VisualsESPTab:AddToggle("ProfileESP", {
	Text = "Enabled",
	Default = ProfileESP.Enabled,
	Callback = function(State)
		ProfileESP.Enabled = State
	end
}):AddColorPicker("ProfileColor", {
	Default = ProfileESP.Color,
	Transparency = 0,
	Callback = function(Color)
		ProfileESP.Color = Color
		ProfileESP.Transparency = Options["ProfileColor"].Transparency
	end
})
VisualsESPTab:AddToggle("ProfileUseBackground", {
	Text = "Show Background",
	Default = ProfileESP.ShowBackground,
	Callback = function(State)
		ProfileESP.ShowBackground = State
	end
}):AddColorPicker("ProfileBackgroundColor", {
	Default = ProfileESP.BackgroundColor,
	Transparency = 0,
	Callback = function(Color)
		ProfileESP.BackgroundColor = Color
		ProfileESP.BackgroundTransparency = Options["ProfileBackgroundColor"].Transparency
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
	end
})
VisualsESPTab:AddToggle("HeadDotFilled", {
	Text = "Filled",
	Default = HeadDotESP.Filled,
	Callback = function(State)
		HeadDotESP.Filled = State
	end
})

VisualsESPTab:AddDivider("HeadTag ESP")
local VisualsHeadTagESP = VisualsESPTab:AddToggle("HeadTagESP", {
	Text = "Enabled",
	Default = HeadTagESP.Enabled,
	Callback = function(State)
		HeadTagESP.Enabled = State
	end
})
VisualsHeadTagESP:AddColorPicker("HeadTagColor", {
	Default = HeadTagESP.Color,
	Transparency = 0,
	Callback = function(Color)
		HeadTagESP.Color = Color
		HeadTagESP.Transparency = 1 - Options["HeadTagColor"].Transparency
	end
})
HeadTagESP.Dropdown = VisualsESPTab:AddDropdown("HeadTagOptions", {
	Text = "Tag Options",
	Values = {"Name", "DisplayName", "EquippedTool", "Health", "Distance", "RigType"},
	Multi = true,
	Default = 1,
	Callback = function(...)
		return (...)
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
	Callback = function(Value)
		ArrowESP.Filled = Value
	end
})

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
	end
})
VisualsESPTab:AddToggle("2DBoxFilled", {
	Text = "Filled",
	Default = BoxESP.Box2D.Filled,
	Callback = function(State)
		BoxESP.Box2D.Filled = State
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
	end
})

VisualsESPTab:AddDivider("Checks")
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

VisualsWorldTab:AddDivider("Local Character")
VisualsWorldTab:AddToggle("CharacterHighlight", {
	Text = "Highlight",
	Default = false,
	Callback = function(State)
		if not State then
			if Connections.CharacterHighlight then
				Connections.CharacterHighlight:Disconnect()
				Connections.CharacterHighlight = nil
			end

			if LocalCharacter then
				local Highlight = LocalCharacter:FindFirstChild("ns__CharacterHighlight")
				if Highlight then
					Highlight:Destroy()
				end
			end
			return
		end
		local Configuration = World.Highlight
		Connections.CharacterHighlight = RunService.Heartbeat:Connect(function()
			if not LocalCharacter then
				return
			end

			local Highlight = LocalCharacter:FindFirstChild("ns__CharacterHighlight") or Create("Highlight", {
				Name = "ns__CharacterHighlight",
				Adornee = LocalCharacter,
				Parent = LocalCharacter
			})
			Highlight.FillColor = Configuration.Color
			Highlight.OutlineColor = Configuration.Color
			Highlight.FillTransparency = Configuration.Transparency
			Highlight.OutlineTransparency = Configuration.Transparency
		end)
	end
}):AddColorPicker("HighlightColor", {
	Default = World.Highlight.Color,
	Transparency = World.Highlight.Transparency,
	Callback = function(Color)
		World.Highlight.Color = Color
		World.Highlight.Transparency = Options["HighlightColor"].Transparency
	end
})

VisualsWorldTab:AddSlider("CharacterTransparency", {
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
VisualsWorldTab:AddButton({
	Text = "Apply Transparency",
	Func = function()
		if LocalCharacter then
			for _,Object in ipairs(LocalCharacter:GetDescendants()) do
				if Object:IsA("BasePart") and Object.Name ~= "HumanoidRootPart" then
					Object.Transparency = World.CharacterTransparency
				end
			end
			World.HasAppliedCharacterTransparency = true
		end
	end
})
VisualsWorldTab:AddButton({
	Text = "Restore Original Transparency",
	Func = function()
		if LocalCharacter then
			for _,Object in ipairs(LocalCharacter:GetDescendants()) do
				if Object:IsA("BasePart") then
					Object.Transparency = (Object.Name == "HumanoidRootPart") and 1 or 0
				end
			end
		end
		World.HasAppliedCharacterTransparency = false
	end
})

VisualsWorldTab:AddDivider("Lighting")
VisualsWorldTab:AddToggle("WorldShadowDisabler", {
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
VisualsWorldTab:AddButton({
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

VisualsWorldTab:AddToggle("WorldForceNight", {
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
VisualsWorldTab:AddToggle("WorldForceDay", {
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

VisualsWorldTab:AddToggle("WorldDarkMode", {
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

VisualsWorldTab:AddSlider("ExposureCompensationSlider", {
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

VisualsWorldTab:AddButton({
	Text = "Restore Original Exposure Compensation",
	Func = function()
		Lighting.ExposureCompensation = World.OldExposureCompensation
		Options["ExposureCompensationSlider"]:SetValue(World.OldExposureCompensation)
	end
})

VisualsWorldTab:AddLabel("Change Ambient"):AddColorPicker("AmbientColor", {
	Default = World.OldAmbient,
	Transparency = nil,
	Callback = function(Color)
		Lighting.Ambient = Color
	end
})
VisualsWorldTab:AddButton({
	Text = "Save Current Ambient as Original",
	Func = function()
		World.OldAmbient = Lighting.Ambient
	end
})
VisualsWorldTab:AddButton({
	Text = "Restore Original Ambient",
	Func = function()
		Lighting.Ambient = World.OldAmbient
		Options["AmbientColor"]:SetValue(World.OldAmbient)
	end
})
--[[
if gethiddenpropertyFunction and sethiddenpropertyFunction then
	VisualsWorldTab:AddDropdown("LightingTechnologyDropdown", {
		Text = "Lighting Technology",
		Values = {"Legacy", "Deprecated", "Voxel", "Compatibility", "ShadowMap", "Future", "Unified"},
		Default = World.OldLightingTechnology,
		Callback = function(Option)
			World.LightingTechnology = Option
		end
	})

	VisualsWorldTab:AddButton({
		Text = "Apply Lighting Technology",
		Func = function()
			nssethiddenproperty(Lighting, "Technology", World.LightingTechnology)
		end
	})

	VisualsWorldTab:AddButton({
		Text = "Save Lighting Technology",
		Func = function()
			World.OldLightingTechnology = World.LightingTechnology
		end
	})

	VisualsWorldTab:AddButton({
		Text = "Restore Lighting Technology",
		Func = function()
			nssethiddenproperty(Lighting, "Technology", World.OldLightingTechnology)
		end
	})
end
]]
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

local ResetFFLagModifications = function(...)
	return (...)
end

if setfflagFunction then
	ResetFFLagModifications = function()
		nssetfflag("RaycastMaxDistance", "15000")
		nssetfflag("DebugDynamicRenderKiloPixels", "-1")
		nssetfflag("DebugTextBoxServiceShowOverlay", "False")
		nssetfflag("SimAdaptiveHumanoidPDControllerSubstepMultiplier", "1")
		nssetfflag("DebugLightGridShowChunks", "False")
	end

	FFlagsTab:AddLabel("Only Advanced users can understand this.", true)

	local IsResetting = false
	local RaycastMaxDistanceInput = FFlagsTab:AddInput("RaycastMaxDistanceInput", {
		Default = "15000",
		Numeric = false,
		Finished = false,
		ClearTextOnFocus = false,
		Text = "RaycastMaxDistance",
		Tooltip = "Break legs collision from 2 to -inf, noclip camera on 3, kinda break camera on values over 3",
		Placeholder = "15000",
		Callback = function(Value)
			local ConvertedValue = tostring(Value)
			local Success,_ = nssetfflag("RaycastMaxDistance", ConvertedValue)
			if Success then
				if not IsResetting then
					Library:Notify({Title = "FFlags", Description = "Set RaycastMaxDistance to " .. ConvertedValue, Time = 0.5})
					IsResetting = false
				end
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while setting RaycastMaxDistance", Time = 1})
			end
		end,
	})
	FFlagsTab:AddButton({
		Text = "Reset RaycastMaxDistance",
		Tooltip = "Resets RaycastMaxDistance back to it's default value of 15000",
		Func = function()
			IsResetting = true
			local Success,_ = nssetfflag("RaycastMaxDistance", "15000")
			if Success then
				RaycastMaxDistanceInput:SetValue("15000")
				IsResetting = false
				Library:Notify({Title = "FFlags", Description = "Reset RaycastMaxDistance to 15000", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while resetting RaycastMaxDistance", Time = 2})
			end
		end
	})

	local DebugDynamicRenderKiloPixelsIsResetting = false
	local DebugDynamicRenderKiloPixelsInput = FFlagsTab:AddInput("DebugDynamicRenderKiloPixelsInput", {
		Default = "-1",
		Numeric = false,
		Finished = false,
		ClearTextOnFocus = false,
		Text = "DebugDynamicRenderKiloPixels",
		Tooltip = "Pro graphics",
		Placeholder = "-1",
		Callback = function(Value)
			local ConvertedValue = tostring(Value)
			local Success,_ = nssetfflag("DebugDynamicRenderKiloPixels", ConvertedValue)
			if Success then
				if not DebugDynamicRenderKiloPixelsIsResetting then
					Library:Notify({Title = "FFlags", Description = "Set DebugDynamicRenderKiloPixels to " .. ConvertedValue, Time = 0.5})
					DebugDynamicRenderKiloPixelsIsResetting = false
				end
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while setting DebugDynamicRenderKiloPixels", Time = 1})
			end
		end,
	})
	FFlagsTab:AddButton({
		Text = "Reset DebugDynamicRenderKiloPixelsInput",
		Tooltip = "Resets DebugDynamicRenderKiloPixelsInput back to it's default value of -1",
		Func = function()
			DebugDynamicRenderKiloPixelsIsResetting = true
			local Success,_ = nssetfflag("DebugDynamicRenderKiloPixels", "-1")
			if Success then
				DebugDynamicRenderKiloPixelsInput:SetValue("-1")
				DebugDynamicRenderKiloPixelsIsResetting = false
				Library:Notify({Title = "FFlags", Description = "Reset DebugDynamicRenderKiloPixels to -1", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while resetting DebugDynamicRenderKiloPixels", Time = 2})
			end
		end
	})

	FFlagsTab:AddButton({
		Text = "Enable DebugTextBoxServiceShowOverlay",
		Func = function()
			local Success,_ = nssetfflag("DebugTextBoxServiceShowOverlay", "True")
			if Success then
				Library:Notify({Title = "FFlags", Description = "Enabled DebugTextBoxServiceShowOverlay", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while enabling DebugTextBoxServiceShowOverlay", Time = 2})
			end
		end
	})
	FFlagsTab:AddButton({
		Text = "Disable DebugTextBoxServiceShowOverlay",
		Func = function()
			local Success,_ = nssetfflag("DebugTextBoxServiceShowOverlay", "False")
			if Success then
				Library:Notify({Title = "FFlags", Description = "Disabled DebugTextBoxServiceShowOverlay", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while disabling DebugTextBoxServiceShowOverlay", Time = 2})
			end
		end
	})

	FFlagsTab:AddButton({
		Text = "Enable SAPDSMultiplier",
		Func = function()
			local Success,_ = nssetfflag("SimAdaptiveHumanoidPDControllerSubstepMultiplier", "-999999")
			if Success then
				Library:Notify({Title = "FFlags", Description = "Enabled SimAdaptiveHumanoidPDControllerSubstepMultiplier", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while enabling SimAdaptiveHumanoidPDControllerSubstepMultiplier", Time = 2})
			end
		end
	})
	FFlagsTab:AddButton({
		Text = "Disable SAPDSMultiplier",
		Func = function()
			local Success,_ = nssetfflag("SimAdaptiveHumanoidPDControllerSubstepMultiplier", "1")
			if Success then
				Library:Notify({Title = "FFlags", Description = "Disabled SimAdaptiveHumanoidPDControllerSubstepMultiplier", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while disabling SimAdaptiveHumanoidPDControllerSubstepMultiplier", Time = 2})
			end
		end
	})

	FFlagsTab:AddButton({
		Text = "Enable DebugLightGridShowChunks",
		Func = function()
			local Success,_ = nssetfflag("DebugLightGridShowChunks", "True")
			if Success then
				Library:Notify({Title = "FFlags", Description = "Enabled DebugLightGridShowChunks", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while enabling DebugLightGridShowChunks", Time = 2})
			end
		end
	})
	FFlagsTab:AddButton({
		Text = "Disable DebugLightGridShowChunks",
		Func = function()
			local Success_,_ = nssetfflag("DebugLightGridShowChunks", "False")
			if Success_ then
				Library:Notify({Title = "FFlags", Description = "Disabled DebugLightGridShowChunks", Time = 2})
			else
				Library:Notify({Title = "FFlags", Description = "Unknown error occured while disabling DebugLightGridShowChunks", Time = 2})
			end
		end
	})
else
	FFlagsTab:AddLabel("FFlags Modification is not supported. Missing required function 'setfflag'", true)
end

SettingsTab:AddToggle("ns__Watermark", {
	Text = "Library Watermark",
	Default = true,
	Callback = function(State)
		Watermark:SetVisible(State)
	end
})

SettingsTab:AddLabel("Toggle menu keybind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind"
})
Library.ToggleKeybind = Options.MenuKeybind
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
	for Key, Value in next, Table do
		if typeof(Value) == "RBXScriptConnection" then
			Value:Disconnect()
			Table[Key] = nil
		end
		if typeof(Value) == "table" then
			ClearConnections(Value)
			Table[Key] = nil
		end
	end
end

local function Unload(Message)
	Library.Unload()
	Running = false

	task.wait(0.1)

	ResetFFLagModifications()
	local AnimateInstance = LocalCharacter and LocalCharacter:FindFirstChild("Animate")
	if AnimateInstance then
		AnimateInstance.Disabled = false
	end

	Lighting.ExposureCompensation = World.OldExposureCompensation
	Lighting.Ambient = World.OldAmbient

	if LocalCharacter then
		if World.HasAppliedCharacterTransparency then
			for _,Object in ipairs(LocalCharacter:GetDescendants()) do
				if Object:IsA("BasePart") then
					Object.Transparency = (Object.Name == "HumanoidRootPart") and 1 or 0
				end
			end
		end

		if LocalCharacter:FindFirstChild("ns__CharacterHighlight") then
			LocalCharacter:FindFirstChild("ns__CharacterHighlight"):Destroy()
		end
	end

	ClearConnections(Connections)
	if CurrentFPS.Value ~= "Unknown" then
		CurrentFPS:Disconnect()
	end

	if HitSounds.Folder and HitSounds.Folder.Parent then
		HitSounds.Folder:Destroy()
	end

	if ChinaHat.ChinaHatTrail then
		ChinaHat.ChinaHatTrail:Destroy()
		ChinaHat.ChinaHatTrail = nil
	end

	for _,FOVCircle in next, AimbotFOVCircles do
		FOVCircle:Nil()
	end

	for _,DrawingObject in next, ESPObjects do
		if typeof(DrawingObject) == "Instance" then
			DrawingObject:Destroy()
		else
			DrawingObject:Nil()
		end
	end

	if cleardrawcache then
		pcall(cleardrawcache)
	end

	local ClearFunction = Drawing and Drawing.clear
	if ClearFunction then
		pcall(ClearFunction)
	end

	for _,Player in ipairs(Players:GetPlayers()) do
		ClearCache(Player)
	end

	print(Message)
end

SettingsTab:AddButton({
	Text = "Reload Script",
	Func = function()
		Unload([[ // Reloading combat.cc || Made by nikoleto scripts - github.com/nikoladhima \\ --]])
		nsloadstring("https://raw.githubusercontent.com/nikoladhima/combat.cc/main/combat.cc.lua")
	end
})
SettingsTab:AddButton({
	Text = "Unload Script",
	Func = function()
		Unload([[ // Unloaded combat.cc || Made by nikoleto scripts - github.com/nikoladhima \\ --]])
	end
})

task.spawn(function()
	if Games.IsCounterBlox then
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
					CounterBlox.AutomaticWeapon:Disconnect()
					CounterBlox.AutomaticWeapon = nil
					for v, OldValue in next, Saved.AutomaticValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end
				CounterBlox.AutomaticWeapon = RunService.Heartbeat:Connect(function()
					for _,v in ipairs(AutomaticValues) do
						if v.Value ~= true then
							v.Value = true
						end
					end
				end)
			end
		})
		WeaponModificationTab:AddToggle("RapidFire", {
			Text = "Rapid Fire",
			Default = false,
			Callback = function(State)
				if not State then
					CounterBlox.RapidFire:Disconnect()
					CounterBlox.RapidFire = nil
					for v, OldValue in next, Saved.FireRateValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end
				CounterBlox.RapidFire = RunService.Heartbeat:Connect(function()
					for _,v in ipairs(FireRateValues) do
						if v.Value ~= FireRate then
							v.Value = FireRate
						end
					end
				end)
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
					CounterBlox.InfiniteAmmo:Disconnect()
					CounterBlox.InfiniteAmmo = nil
					for v, OldValue in next, Saved.AmmoValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end
				CounterBlox.InfiniteAmmo = RunService.Heartbeat:Connect(function()
					for _,v in ipairs(AmmoValues) do
						if v.Value ~= 6e9 then
							v.Value = 6e9
						end
					end
				end)
			end
		})
		WeaponModificationTab:AddToggle("NoRecoil", {
			Text = "No Recoil",
			Default = false,
			Callback = function(State)
				if not State then
					CounterBlox.NoRecoil:Disconnect()
					CounterBlox.NoRecoil = nil
					for v, OldValue in next, Saved.RecoilValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end
				CounterBlox.NoRecoil = RunService.Heartbeat:Connect(function()
					for _,v in ipairs(RecoilValues) do
						if v.Value ~= 0 then
							v.Value = 0
						end
					end
				end)
			end
		})
		WeaponModificationTab:AddToggle("NoSpread", {
			Text = "No Spread",
			Default = false,
			Callback = function(State)
				if State then
					for _,v in ipairs(SpreadValues) do
						if v.Value ~= 0 then
							v.Value = 0
						end
					end
					while true do
						if not State then
							CounterBlox.NoSpread:Disconnect()
							CounterBlox.NoSpread = nil
							for v, OldValue in next, Saved.SpreadValues do
								if v and v.Parent then
									v.Value = OldValue
								end
							end
							break
						end

						for _,v in ipairs(SpreadValues) do
							if v.Value ~= 0 then
								v.Value = 0
							end
						end

						task.wait(2)
					end
				end
			end
		})
		WeaponModificationTab:AddToggle("InstantReload", {
			Text = "Instant Reload",
			Default = false,
			Callback = function(State)
				if not State then
					CounterBlox.InstantReload:Disconnect()
					CounterBlox.InstantReload = nil
					for v, OldValue in next, Saved.ReloadTimeValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end
				CounterBlox.InstantReload = RunService.Heartbeat:Connect(function()
					for _,v in ipairs(ReloadTimeValues) do
						if v.Value ~= 0.01 then
							v.Value = 0.01
						end
					end
				end)
			end
		})
		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(CounterBlox)
			for _,SavedValues in ipairs(Saved) do
				for v, OldValue in next, (SavedValues) do
					if v and v.Parent then
						v.Value = OldValue
					end
				end
			end
		end)
	elseif Games.IsArsenal or Games.IsArsenal2020Revival or Games.IsArsenalRefreshed then
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
		task.spawn(function()
			while true do
				if not Running then
					break
				end

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

				task.wait(0.1)
			end
		end)
		local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
		local SilentAimbotToggle = SilentAimbotTab:AddToggle("SilentAimbot", {
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
		})
		SilentAimbotToggle:AddKeyPicker("SilentAimbotKey", {
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
					Arsenal.AutomaticWeapon:Disconnect()
					Arsenal.AutomaticWeapon = nil
					for v, OldValue in next, Saved.AutomaticValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(AutomaticValues) do
					if v.Value ~= true then
						v.Value = true
					end
				end
			end
		})
		WeaponModificationTab:AddToggle("RapidFire", {
			Text = "Rapid Fire",
			Default = false,
			Callback = function(State)
				if not State then
					Arsenal.RapidFire:Disconnect()
					Arsenal.RapidFire = nil
					for v, OldValue in next, Saved.FireRateValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(FireRateValues) do
					if v.Value ~= FireRate then
						v.Value = FireRate
					end
				end
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
					Arsenal.IncreaseAmmo:Disconnect()
					Arsenal.IncreaseAmmo = nil
					for v, OldValue in next, Saved.AmmoValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(AmmoValues) do
					if v.Value < 100 then
						v.Value = 100
					end
				end
			end
		})
		WeaponModificationTab:AddToggle("NoRecoil", {
			Text = "No Recoil",
			Default = false,
			Callback = function(State)
				if not State then
					Arsenal.NoRecoil:Disconnect()
					Arsenal.NoRecoil = nil
					for v, OldValue in next, Saved.RecoilValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(RecoilValues) do
					if v.Value ~= 0 then
						v.Value = 0
					end
				end
			end
		})
		WeaponModificationTab:AddToggle("NoSpread", {
			Text = "No Spread",
			Default = false,
			Callback = function(State)
				if not State then
					Arsenal.NoSpread:Disconnect()
					Arsenal.NoSpread = nil
					for v, OldValue in next, Saved.SpreadValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(SpreadValues) do
					if v.Value ~= 0 then
						v.Value = 0
					end
				end
			end
		})
		WeaponModificationTab:AddToggle("InstantReload", {
			Text = "Instant Reload",
			Default = false,
			Callback = function(State)
				if not State then
					Arsenal.InstantReload:Disconnect()
					Arsenal.InstantReload = nil
					for v, OldValue in next, Saved.ReloadTimeValues do
						if v and v.Parent then
							v.Value = OldValue
						end
					end
					return
				end

				for _,v in ipairs(ReloadTimeValues) do
					if v.Value ~= 0 then
						v.Value = 0
					end
				end
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
				for v, OldValue in next, SavedValues do
					if v and v.Parent then
						v.Value = OldValue
					end
				end
			end
		end)
	elseif Games.IsDefuseDivision then
		local Import = ReplicatedStorage:WaitForChild("Import")
		local Guns = Import:WaitForChild("Guns")
		local Viewmodels = Guns:WaitForChild("Viewmodels")

		local Assets = Import:WaitForChild("Assets")
		local Skins = Assets:WaitForChild("Skins")

		local DefuseDivision = {
			InfiniteAmmo = nil
		}

		local KnifeConfiguration = {
			Bayonet = {
				Viewmodel = "v_Bayonet",
				Skinfolder = "bayonet",
				Targets = {"m9"}
			},
			Bowie = {
				Viewmodel = "v_bowie",
				Skinfolder = nil,
			},
			ButterflyKnife = {
				Viewmodel = "v_ButterflyKnife",
				Skinfolder = "butterflyknife",
				Targets = {"blade", "latch", "body_legacy"}
			},
			Canis = {
				Viewmodel = "v_canis",
				Skinfolder = "canis",
				Targets = {"survival"}
			},
			Gut = {
				Viewmodel = "v_gut",
				Skinfolder = "gut",
				Targets = {"gut"}
			},
			Karambit = {
				Viewmodel = "v_Karambit",
				Skinfolder = "karambit",
				Targets = {"knife_karambit"}
			},
			Push = {
				Viewmodel = "v_push",
				Skinfolder = "push",
				Targets = {"push"}
			},
			Skeleton = {
				Viewmodel = "v_skeleton",
				Skinfolder = "skeleton",
				Targets = {"skeleton"}
			},
			Stiletto = {
				Viewmodel = "v_stiletto",
				Skinfolder = "stiletto",
				Targets = {"blade", "handle"}
			},
			Tactical = {
				Viewmodel = "v_tactical",
				Skinfolder = "tactical",
				Targets = {"man"}
			},
			Talon = {
				Viewmodel = "v_talon",
				Skinfolder = "talon",
				Targets = {"knife_talon"}
			},
			Ursus = {
				Viewmodel = "v_ursus",
				Skinfolder = "ursus",
				Targets = {"knife_ursus"}
			}
		}

		local SelectedKnifeModel = "Bayonet"
		local SelectedKnifeSkin = "Default"

		local function RemoveViewModel(Name)
			local ViewModel = Viewmodels:FindFirstChild(Name)
			if ViewModel then
				ViewModel:Destroy()
			end
		end

		local Game = Window:AddTab("Defuse Division", "gamepad-2")
		local SilentTabBox = Game:AddLeftTabbox("SilentAimbotTabBox")
		local WeaponModificationTabbox = Game:AddLeftTabbox("WeaponModificationTabBox")
		local SkinChangerTabbox = Game:AddRightTabbox("SkinChangerTabBox")
		local SilentAimbotTab = SilentTabBox:AddTab("Silent Aimbot")
		local WeaponModificationTab = WeaponModificationTabbox:AddTab("Weapon Modification")
		local KnifeSkinChangerTab = SkinChangerTabbox:AddTab("Knife")

		SilentAimbotTab:AddLabel("Silent Aimbot is temporarily disabled.", true)

		WeaponModificationTab:AddToggle("InfiniteAmmo", {
			Text = "Infinite Ammo [Stays at 2]",
			Default = false,
			Callback = function(State)
				if not State then
					DefuseDivision.InfiniteAmmo:Disconnect()
					DefuseDivision.InfiniteAmmo = nil
					return
				end
				DefuseDivision.InfiniteAmmo = RunService.Heartbeat:Connect(function()
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
				end)
			end
		})

		KnifeSkinChangerTab:AddLabel("Re-equip your Knife after applying Skin.", false)
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
				RemoveViewModel("v_TKnife")
				RemoveViewModel("v_CTKnife")

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

				local ViewModel = Viewmodels:FindFirstChild(Configuration.Viewmodel)
				if not ViewModel then
					return
				end

				local Skin = "Default"
				local SkinFolder = Configuration.Skinfolder
				if SkinFolder and SelectedKnifeSkin ~= "Default" then
					Skin = Skins:WaitForChild(SkinFolder):WaitForChild(SelectedKnifeSkin)
				end

				for _,Name in ipairs({"v_TKnife", "v_CTKnife"}) do
					local Clone = ViewModel:Clone()
					Clone.Name = Name
					ApplyTexture(Clone, Skin, Configuration.Targets)
					Clone.Parent = Viewmodels
				end
			end,
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(DefuseDivision)
		end)
	elseif Games.IsGunGroundsFFA or Games.IsFlick then
		local Flick = {
			HitboxExtender = nil,
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
					Flick.HitboxExtender:Disconnect()
					Flick.HitboxExtender = nil
					for _,Cache in next, CachedPlayers do
						local Character = Cache.Character
						local Part = Character and Character:FindFirstChild("Crit")
						if Part then
							Part.Size = Vector3CritSize
						end
					end
					return
				end
				Flick.HitboxExtender = RunService.Heartbeat:Connect(function()
					for _,Cache in next, CachedPlayers do
						local Character = Cache.Character

						if not Character then
							return
						end

						local Part = Character:FindFirstChild("Crit")
						if Part then
							SetTransparency(Part, ShowHitbox and 0.5 or 1)
							SetSize(Part, Vector3.one * HitboxSize)
						end
					end
				end)
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

			for _,Cache in next, CachedPlayers do
				local Character = Cache.Character
				local Part = Character and Character:FindFirstChild("Crit")
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

		local function ResetHitbox(Root)
			if Root then
				Root.Size = Vector3.new(2, 2, 1)
				Root.Transparency = 1
			end
		end

		task.spawn(function()
			while true do
				if not Running then
					break
				end

				if HitboxExtender then
					for Player, Cache in next, CachedPlayers do
						if IsEnemy(Player) then
							local Root = Cache.Root
							if Root then
								SetSize(Root, Vector3.one * HitboxSize)
								SetTransparency(Root, ShowHitbox and 0.5 or 1)
								if Root.CanCollide ~= false then
									Root.CanCollide = false
								end
							end
						else
							ResetHitbox(Cache.Root)
						end
					end
				end

				task.wait(0.1)
			end
		end)

		HitboxExtenderTab:AddToggle("HitboxExtender", {
			Text = "Hitbox Extender",
			Default = false,
			Callback = function(State)
				if not State then
					for _,Cache in next, CachedPlayers do
						ResetHitbox(Cache.Root)
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

				QuickShot.LobbyWeapons = RunService.RenderStepped:Connect(function()
					LocalPlayer:SetAttribute("InRound", true)
				end)
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
			for _,Cache in next, CachedPlayers do
				ResetHitbox(Cache.Root)
			end
		end)
	elseif Games.IsWarTycoon then
		local WarTycoon = {
			HitboxExtender = nil,
		}

		local HitboxSize = Vector3.new(26, 26, 26)

		local Game = Window:AddTab("War Tycoon", "gamepad-2")
		local SilentAimbotTab = Game:AddLeftGroupbox("Silent Aimbot [Hitbox Expander]")
		local VisualRemovalsTab = Game:AddRightGroupbox("Removals")

		local GasBlur = false
		local Landmines = false

		local function ResetHitbox(Root)
			if Root then
				Root.Size = Vector3.new(2, 2, 1)
			end
		end

		task.spawn(function()
			while true do
				if not Running then
					break
				end

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

				task.wait(0.1)
			end
		end)

		local SilentAimbotLabel = SilentAimbotTab:AddLabel("Silent Aimbot: Disabled")
		local SilentAimbotToggle = SilentAimbotTab:AddToggle("SilentAimbot", {
			Text = "Toggle Aimbot",
			Default = SilentAimbot.Toggled,
			Callback = function(Value)
				SilentAimbot.Toggled = Value
				if not Value and SilentAimbot.Enabled then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for _,Cache in next, CachedPlayers do
						ResetHitbox(Cache.Root)
					end
				end
			end
		})
		SilentAimbotToggle:AddKeyPicker("SilentAimbotKey", {
			Mode = "Toggle",
			Text = "Silent Aimbot",
			Callback = function(State)
				if not SilentAimbot.Toggled then
					return
				end
				SilentAimbot.Enabled = State
				if not State then
					SilentAimbotLabel:SetText("Silent Aimbot: Disabled")
					for _,Cache in next, CachedPlayers do
						ResetHitbox(Cache.Root)
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

		table.insert(WarTycoon, Camera.ChildAdded:Connect(function(Child)
			if GasBlur then
				if Child.Name == "TearGasBlur" then
					Child:Destroy()
				end
			end
		end))

		VisualRemovalsTab:AddToggle("GasBlurRemoval", {
			Text = "Gas Blur",
			Default = GasBlur,
			Callback = function(Value)
				GasBlur = Value
				if Value and Camera then
					for _,Child in next, Camera:GetChildren() do
						if Child.Name == "TearGasBlur" then
							Child:Destroy()
						end
					end
				end
			end
		})

		table.insert(WarTycoon, workspace.DescendantAdded:Connect(function(Child)
			if Landmines then
				if Child.Name == "Land Mine" then
					local TouchPart = Child:FindFirstChild("TouchPart")
					if TouchPart then
						Child:Destroy()
					end
				end
			end
		end))

		VisualRemovalsTab:AddToggle("Landmines", {
			Text = "Landmines",
			Default = false,
			Callback = function(Value)
				Landmines = Value
				if Value then
					for _,Child in ipairs(workspace:GetDescendants()) do
						if Child.Name == "Land Mine" then
							local TouchPart = Child:FindFirstChild("TouchPart")
							if TouchPart then
								Child:Destroy()
							end
						end
					end
				end
			end
		})

		task.spawn(function()
			repeat task.wait() until Running == false
			ClearConnections(WarTycoon)
			for _,Cache in next, CachedPlayers do
				ResetHitbox(Cache.Root)
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

	elseif Games.IsDaHood then
		local Game = Window:AddTab("Da Hood", "gamepad-2")
		local SilentTabBox = Game:AddLeftTabbox("SilentAimbotTabBox")
		local SilentAimbotTab = SilentTabBox:AddTab("Silent Aimbot")

		if hookmetamethod then
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
	FileFunctions.writefile("combat.cc/Nikoleto.iy", tostring(game:HttpGet(UtilsRepo .. "Nikoleto.iy")))
	if FileFunctions.isfile("IY_FE.iy") then
		local Data = HttpService:JSONDecode(FileFunctions.readfile("IY_FE.iy"))
		if Data and type(Data) == "table" then
			local PluginsTable = Data.PluginsTable
			if table.find(PluginsTable, "combat.cc/Nikoleto.iy") then
				return
			end
			table.insert(PluginsTable, "combat.cc/Nikoleto.iy")
			FileFunctions.writefile("IY_FE.iy", HttpService:JSONEncode(Data))
		end
	else
		local currentShade1 = Color3.fromRGB(36, 36, 37)
		local currentShade2 = Color3.fromRGB(46, 46, 47)
		local currentShade3 = Color3.fromRGB(78, 78, 79)
		local currentText1 = Color3.new(1, 1, 1)
		local currentText2 = Color3.new(0, 0, 0)
		local currentScroll = Color3.fromRGB(78,78,79)
		FileFunctions.writefile("IY_FE.iy", HttpService:JSONEncode({
			prefix = ';';
			StayOpen = false;
			espTransparency = 0.3;
			keepIY = true;
			logsEnabled = false;
			jLogsEnabled = false;
			aliases = {};
			binds = {};
			WayPoints = {};
			PluginsTable = {"combat.cc/Nikoleto.iy"};
			currentShade1 = {currentShade1.R, currentShade1.G, currentShade1.B};
			currentShade2 = {currentShade2.R, currentShade2.G, currentShade2.B};
			currentShade3 = {currentShade3.R, currentShade3.G, currentShade3.B};
			currentText1 = {currentText1.R, currentText1.G, currentText1.B};
			currentText2 = {currentText2.R, currentText2.G, currentText2.B};
			currentScroll = {currentScroll.R, currentScroll.G, currentScroll.B};
			eventBinds = {OnExecute = "",OnSpawn = "",OnDied = "",OnDamage = "",OnKilled = "",OnJoin = "",OnLeave = "",OnChatted = ""}
		}))
	end
end)

Library:Notify({
	Title = "[[ combat.cc ]]",
	Description = "Loaded combat.cc " .. ((UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse) and "(Default Keybind: Right Shift)" or "successfully") .. " || Made by nikoleto scripts - github.com/nikoladhima",
	Time = 3.5
})

Library:Toggle(true)

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("combat.cc/Themes")
ThemeManager:ApplyToTab(WindowTabs.WindowSettingsTab)

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind", "ChamColor"})
SaveManager:SetFolder("combat.cc/Configs")
SaveManager:BuildConfigSection(WindowTabs.WindowSettingsTab)
SaveManager:LoadAutoloadConfig()

print("[nikoletoscripts/combat.cc]: Loaded script successfully in " .. tostring(tick() - StartTick) .. "s.")

if not IsDeveloperBuild then
	task.spawn(function()
		while true do
			if not Running then
				break
			end

			local LatestVersion = nsloadstring(UtilsRepo .. "LatestVersion.lua")
			if LatestVersion and type(LatestVersion) == "string" then
				if ScriptVersion:gsub(LatestVersion, "IsLatestVersion") ~= "IsLatestVersion" then
					Library:Notify({
						Title = "[[ combat.cc ]]",
						Description = "Script v." .. ScriptVersion .. " is Out-Of-Date, please re-execute to get the latest update v." .. LatestVersion,
						Time = 3.5
					})
				end
			end

			task.wait(10)
		end
	end)
end

--[[
task.spawn(function()
	local WhitelistedPlayers = {3242807045}

	local SendMessage = function(...)
		return (...)
	end

	local function HandleMessage(Player, RealMessage, SayMessageRequest)
		if not Player or not RealMessage then
			return
		end

		if not table.find(WhitelistedPlayers, Player.UserId) then
			return
		end

		local CorrectedMessage = RealMessage:lower()

		local Fifth = string.sub(CorrectedMessage, 1, 5)
		local Sixth = string.sub(CorrectedMessage, 1, 6)

		if Fifth == ".ping" then
			SendMessage("Pong! (" .. CurrentPing .. "ms)")
		elseif string.sub(CorrectedMessage, 1, 4) == ".say" then
			SendMessage(string.sub(RealMessage, 5))
		elseif Fifth == ".kick" then
			LocalPlayer:Kick(string.sub(RealMessage, 7))
		elseif Sixth == ".crash" then
			while true do
				task.spawn(function()
					return "get noob :cool_face:"
				end)
			end
		elseif Sixth == ".while" then
			while true do
				task.spawn(function()
					return "get while true do end :cool_face:"
				end)
			end
		elseif Sixth == ".bring" then
			if LocalRoot then
				local Character = Player.Character
				if Character then
					local Root = Character:FindFirstChild("HumanoidRootPart")
					if Root then
						LocalRoot.CFrame = Root.CFrame * CFrame.new(0, 5, 0)
					end
				end
			end
		elseif Fifth == ".jump" or Fifth == ".jumpscare" then
			local ScreenGui = Create("ScreenGui", {
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				Parent = CoreGui
			})

			Create("ImageLabel", {
				Image = "rbxassetid://1308665109",
				Size = UDim2.new(1, 0, 1, 0),
				Parent = ScreenGui
			})

			Create("Sound", {
				SoundId = "rbxassetid://3537873683",
				Volume = 10,
				PlayOnRemove = true,
				Parent = CoreGui
			}):Destroy()

			task.wait(3.5)

			ScreenGui:Destroy()
		end
	end

	local TextChatService = GetService("TextChatService")

	if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
		local Channel = TextChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
		SendMessage = function(Message)
			Channel:SendAsync(Message)
		end

		TextChatService.OnIncomingMessage = function(Message)
			local Source = Message.TextSource
			if Source then
				local Player = Players:GetPlayerByUserId(Source.UserId)
				if Player then
					HandleMessage(Player, Message.Text)
				end
			end
			return Message
		end

		return
	else
		local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
		if DefaultChatSystemChatEvents then
			local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering")

			if OnMessageDoneFiltering then
				local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest")
				SendMessage = function(Message)
					SayMessageRequest:FireServer(Message, "All")
				end

				OnMessageDoneFiltering.OnClientEvent:Connect(function(Message)
					local Player = Players:FindFirstChild(Message.FromSpeaker)
					if Player then
						HandleMessage(Player, Message.Message)
					end
				end)

				return
			end
		end
	end
end)
]]

if type((...)) == "string" and (...) == "RemoveLogging" then
	warn("[Service Info] RemoveLogging is enabled, this means that ZERO information will be logged.")
	return
end
nsloadstring(UtilsRepo .. "NikoletoService.lua")
