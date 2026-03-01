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

print("[nikoletoscripts/combat.cc]: Loading script..")

local function nsloadstring(UseUtilsRepository: boolean, Url: string, Argument: any): any
	local Success, Result = pcall(function()
		return loadstring(game:HttpGet(
            UseUtilsRepository and "https://raw.githubusercontent.com/nikoladhima/combat.cc/main/utils/" .. Url or Url
        ))(Argument)
	end)

	return Success and Result or {nsFailed = true, Value = "Unknown", tostring(Result)}
end

local Module = nsloadstring(false, "https://raw.githubusercontent.com/nikoladhima/combat.cc/main/core/Module.luau", nsloadstring)
if not Module or (type(Module) == "table" and Module.nsFailed) then
	warn("Failed to load Module: " .. Module[3])
	return
else
	print("[nikoletoscripts/combat.cc/core]: Loaded Module.")
end

local Library = Module:Get("Library")
local ThreadManager = Module:Get("ThreadManager")
local DrawingManager = Module:Get("DrawingManager")

if Library and ThreadManager and DrawingManager then
	print("[nikoletoscripts/combat.cc/utils]: Loaded utils.")
else
	warn("[nikoletoscripts/combat.cc/utils]: Failed to load utils.")
	return "skill issue fr"
end

local ScriptVersion = "2.9.0"

local FileFunctions = {
    listfiles = listfiles or list_files or function(...): {string}
        return {}
    end,
    makefolder = makefolder or make_folder or createfolder or create_folder or function(...): boolean
        return true
    end,
    isfolder = isfolder or is_folder or function(...): boolean
        return false
    end,
    isfile = isfile or is_file or function(...): boolean
        return false
    end,
    readfile = readfile or read_file or readfileasync or readfile_async or read_file_async or function(...): string
        return "{}"
    end,
    writefile = writefile or write_file or writefileasync or writefile_async or write_file_async or function(...): boolean
        return true
    end,
    delfile = delfile or del_file or deletefile or delete_file or function(...): boolean
        return true
    end
}

if not FileFunctions.isfolder("combat.cc") then
	FileFunctions.makefolder("combat.cc")
end

if not FileFunctions.isfolder("combat.cc/Sounds") then
	FileFunctions.makefolder("combat.cc/Sounds")
end

local Options = Library.Options
local Toggles = Library.Toggles
local Watermark = Library:AddDraggableLabel("[nikoletoscripts/combat.cc] | Unknown | 0 | 0")

local identifyexecutor = identifyexecutor or identify_executor or getexecutorname or get_executorname or get_executor_name or function(): string
	return "Unknown"
end

local isrbxactive = isrbxactive or is_rbxactive or is_rbx_active or function()
	return true
end

local mouse1press = mouse1press or mouse1_press or mouse_1_press
local mouse1release = mouse1release or mouse1_release or mouse_1_release
local mousemoverel = mousemoverel or mouse_moverel or mousemove_rel or mouse_move_rel or MouseMoveRel or setmousepos or set_mouse_pos

local newcclosure = newcclosure or new_cclosure or newc_closure or new_c_closure or function(Function: (any) -> any): (any) -> any
	return Function
end

if identifyexecutor():lower():find("solara") then
	hookmetamethod = nil -- fuck you solara for faking a global function
end

local hookmetamethod = hookmetamethod or hook_metamethod or hook_metamethod or hook_meta_method
local getnamecallmethod = getnamecallmethod or getnamecall_method or get_namecallmethod or get_namecall_method

local setfflagFunction = setfflag or set_fflag or set_fastflag or set_fast_flag
local function nssetfflag(FastFlag: string, Value: string): (boolean, string?)
	if not setfflagFunction then
		return false, "function missing"
	end
	return pcall(setfflagFunction, FastFlag, Value)
end

local clonefunctionFunction = clonefunction or clone_function or copyfunction or copy_function
local nsclonefunction = function(Function: (any) -> any): (any) -> any
	if not clonefunctionFunction then
		return Function
	end

	local Success, Result = pcall(clonefunctionFunction, Function)
	return Success and Result or Function
end

local clonerefFunction = cloneref or clone_ref or clonereference or clone_reference
local nscloneref = function< T >(Object: T): T
	if not clonerefFunction then
		return Object
	end

	local Success, Result = pcall(clonerefFunction, Object)
	return Success and Result or Object
end

local getcustomassetFunction = getcustomasset or get_customasset or get_custom_asset
local function nsgetcustomasset(File: string): string
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
local function Create(Type: string, Properties: {[string]: any}?): Instance
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

local GetServiceFunction = nsclonefunction(game.GetService)
local function GetService(ServiceName: string): ServiceProvider
	return nscloneref(GetServiceFunction(game, ServiceName))
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
local FixedBottomCenter = Vector2.new(0, 0, 0)

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

	ForceFieldCheck = false,
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
	InfiniteJump = false,
	NoJumpCooldown = false,
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
	Dropdown = "Name",
	Transparency = 1
}, table.create(6)

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
	Color = Color3.new(255, 255, 255),
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
	["Knife Ability Test"] = "8250618750",
	IsKatX = "8250618750",
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

local function InsertToConnections(Connection: RBXScriptConnection)
	table.insert(Connections, Connection)
end

local function RenderStepped(Function: (number) -> ())
	return RunService.RenderStepped:Connect(Function)
end

local function Heartbeat(Function: (number) -> ())
	return RunService.Heartbeat:Connect(Function)
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

MouseLocation = UserInputService:GetMouseLocation()
InsertToConnections(Mouse.Move:Connect(function()
	MouseLocation = UserInputService:GetMouseLocation()
end))

local function GetSettingsShield(): Instance?
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

AimbotFOVCircles.FOVCircle = DrawingManager.new("Circle", {
	Color = Aimbot.FOVCircle.Color,
	Filled = Aimbot.FOVCircle.Filled,
	Thickness = Aimbot.FOVCircle.Thickness,
	Radius = Aimbot.FOVCircle.Radius,
	Visible = false
})

AimbotFOVCircles.S_FOVCircle = DrawingManager.new("Circle", {
	Color = SilentAimbot.FOVCircle.Color,
	Filled = SilentAimbot.FOVCircle.Filled,
	Thickness = SilentAimbot.FOVCircle.Thickness,
	Radius = SilentAimbot.FOVCircle.Radius,
	Visible = false
})

local IsEnemy: (Player) -> boolean = nil
if Games.IsAimblox then
	IsEnemy = function(Player: Player): boolean
		if not Player then
			return false
		end

		if Player:GetAttribute("Team") ~= LocalPlayer:GetAttribute("Team") then
			return true
		end

		return false
	end
elseif Games.IsDefuseDivision then
	IsEnemy = function(Player: Player): boolean
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
	IsEnemy = function(Player: Player): boolean
		return true
	end
elseif Games.IsDeadEye then
	IsEnemy = function(Player: Player): boolean
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
	IsEnemy = function(Player: Player): boolean
		if not Player then
			return false
		end

		if LocalPlayer.Neutral or Player.Team ~= LocalPlayer.Team then
			return true
		end

		return false
	end
elseif Games.IsKatX then
	IsEnemy = function(Player: Player): boolean
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
elseif Games.IsDefusal then
	IsEnemy = function(Player: Player): boolean
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
	IsEnemy = function(Player: Player): boolean
		if not Player then
			return false
		end

		if Player:GetAttribute("TeamID") ~= LocalPlayer:GetAttribute("TeamID") then
			return true
		end

		return false
	end
else
	IsEnemy = function(Player: Player): boolean
		if not Player then
			return false
		end

		if #Teams:GetTeams() <= 1 or Player.Team ~= LocalPlayer.Team then
			return true
		end

		return false
	end
end

local function GetArsenalHealthInstance(Cache: table): NumberValue?
	local NRPBS = Cache.NRPBS
	return NRPBS and NRPBS:FindFirstChild("Health") or nil
end

local IsDead: (Instance, string, number) -> (boolean, number) = nil
if IsArsenalBaseGame then
	IsDead = function(Character: Instance?, Mode: string, CustomValue: number): (boolean, number)
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
	IsDead = function(Character: Instance?, Mode: string, CustomValue: number): (boolean, number)
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
	IsDead = function(Character: Instance?, ...): boolean
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
elseif Games.IsAladiaPvP then
	IsDead = function(Character: Instance?, Mode: string, CustomValue: number): boolean
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

		if Humanoid.Health <= ((Mode == "Custom") and CustomValue or 1) then
			return true
		end

		return false
	end
else
	IsDead = function(Character: Instance?, Mode: string, CustomValue: number): boolean
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

local function IsProtected(Character: Instance?): boolean
	if Character:FindFirstChildOfClass("ForceField") then
		return true
	end

	return false
end

local PerformJump: () -> () = nil
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

local function IsBehindWall(Origin: Vector3, TargetPosition: Vector3, Character: Instance?): boolean
	if not Character then
		return false
	end

    local Result = workspace:Raycast(Origin, TargetPosition - Origin, CachedRaycastParams)

	if not Result then
        return false
    end

    return not Result.Instance:IsDescendantOf(Character)
end

local function CreateESP(): table
	local ESP = {}

	ESP.HeadDot = DrawingManager.new("Circle", {
		Color = HeadDotESP.Color,
		Radius = 4,
		Filled = true,
		Visible = false
	})

	ESP.HeadTag = DrawingManager.new("Text", {
		Text = "",
		Color = HeadTagESP.Color,
		Size = 16,
		Center = true,
		Outline = true,
		Visible = false
	})

	ESP.Tracer = DrawingManager.new("Line", {
		Color = TracerESP.Color,
		Thickness = 2,
		Visible = false
	})

	ESP.Arrow = DrawingManager.new("Triangle", {
		Color = ArrowESP.Color,
        Thickness = 2,
		Visible = false
	})

	ESP.Box2D = DrawingManager.new("Square", {
		Thickness = 2,
		Size = Vector2.one * 50,
		Color = BoxESP.Box2D.Color,
		Visible = false
	})

	ESP.Box3D = table.create(12)
	for Index = 1, 12 do
		ESP.Box3D[Index] = DrawingManager.new("Line", {
			Color = BoxESP.Box3D.Color,
			Thickness = 2,
			Visible = false
		})
	end

    ESP.HealthBarOutline = DrawingManager.new("Square", {
        Filled = true,
        Color = HealthBarESP.Color,
        Transparency = 1,
        Visible = false
    })

    ESP.HealthBarFill = DrawingManager.new("Line", {
        Color = Color3.new(0, 1, 0),
        Transparency = 1,
        Visible = false
    })

    ESP.Skeleton = table.create(16)
    for Index = 1, 16 do
        ESP.Skeleton[Index] = DrawingManager.new("Line", {
            Thickness = 1,
            Color = SkeletonESP.Color,
            Transparency = 1,
            Visible = false
        })
    end

	return ESP
end

local function WorldToViewportPoint(Position: Vector3): (Vector2, boolean)
	if not Camera then
		return Vector2.zero, false
	end

	local Screen, OnScreen = Camera:WorldToViewportPoint(Position)
	return Vector2.new(Screen.X, Screen.Y), OnScreen
end

local function WorldToScreenPoint(Position: Vector3, IncludeZ: boolean): ((Vector3 | Vector2), boolean)
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

local function ClearCache(Player: Player)
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
					DrawingObject:Nil()
				end
				continue
			end

			Object:Nil()
		end
	end

	CachedPlayers[Player] = nil
end

local function CachePlayer(Player: Player): Instance?
	local Character = Player.Character

	if not Character then
		ClearCache(Player)
		return nil
	end

	local Cache = CachedPlayers[Player] or {}

	local Name = Player.Name
	Cache.Name = Name
	Cache.DisplayName = Player.DisplayName

	if IsArsenalBaseGame then
		local NRPBS = Player:FindFirstChild("NRPBS")
		Cache.NRPBS = NRPBS
		Cache.EquippedTool = NRPBS:FindFirstChild("EquippedTool")
	end

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
	return Character
end

local function SetEnabled(Object: Instance, State: boolean)
	if Object.Enabled ~= State then
		Object.Enabled = State
	end
end

local function AddCache(Player: Player)
	local Character = CachePlayer(Player)

	if Character then
		for _,Child in ipairs(Character:GetChildren()) do
			if Child:IsA("Highlight") and Child.Name ~= "Cham_" .. Player.Name then
				SetEnabled(Child, false)
			end
		end
	end

	InsertToConnections(Player.CharacterAdded:Connect(function()
		InsertToConnections(CachePlayer(Player).ChildAdded:Connect(function(Child)
			if Child:IsA("Highlight") and Child.Name ~= "Cham_" .. Player.Name then
				SetEnabled(Child, false)
			end
		end))
	end))

	InsertToConnections(Player.CharacterRemoving:Connect(function()
		ClearCache(Player)
	end))
end

ThreadManager:Start("CachedPlayers", function()
	CachedRaycastParams.FilterDescendantsInstances = {LocalCharacter, Camera}

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
end, 1.5)

InsertToConnections(Players.PlayerAdded:Connect(function(Player: Player)
	AddCache(Player)
	if PlayerJoinLogs then
		Library:Notify({
			Title = "[[ combat.cc ]]",
			Description = Player.DisplayName .. " (@" .. Player.Name .. ") has Joined the server.",
			Time = 3.5
		})
	end
end))
InsertToConnections(Players.PlayerRemoving:Connect(function(Player: Player)
	ClearCache(Player)
	if PlayerLeaveLogs then
		Library:Notify({
			Title = "[[ combat.cc ]]",
			Description = Player.DisplayName .. " (@" .. Player.Name .. ") has Left the server.",
			Time = 3.5
		})
	end
end))

local function PlayHitSound(Option: string, Volume: number)
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

local CurrentFPS = nsloadstring(true, "FPS.luau", {RunService, GetService("Stats")})
local CurrentPing = 0

task.spawn(function()
	local DataPing = CurrentFPS.Stats:WaitForChild("Network"):WaitForChild("ServerStatsItem"):WaitForChild("Data Ping")
	InsertToConnections(RenderStepped(function()
		CurrentPing = DataPing:GetValue()
		Watermark:SetText("[nikoletoscripts/combat.cc] | " .. CurrentGameName .. " | FPS: " .. CurrentFPS.Value .. " | Ping: " .. math.floor(CurrentPing))
	end))
end)

local function SetSize(DrawingObject: table?, Size: Vector2)
	if DrawingObject.Size ~= Size then
		DrawingObject.Size = Size
	end
end

local function SetTransparency(DrawingObject: table?, Transparency: number)
	if DrawingObject.Transparency ~= Transparency then
		DrawingObject.Transparency = Transparency
	end
end

local function UpdateFOVCircle(FOVCircle: table?, FOVCircleTable: table, AimbotTable: table)
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

local function HideESP(ESP: table?)
    if not ESP then
        return
    end

    for Index, Object in next, ESP do
        if Index == "Cham" then
            if Object.Enabled ~= false then
                Object.Enabled = false
            end
            continue
        end

        if Index == "Box3D" or Index == "Skeleton" then
            for _, Line in next, Object do
                Line:Visible(false)
            end
            continue
        end

        Object:Visible(false)
    end
end

local function GetDistanceSquared(Point1: Vector3, Point2: Vector3): number
    local DeltaX = Point1.X - Point2.X
    local DeltaY = Point1.Y - Point2.Y
    local DeltaZ = Point1.Z - Point2.Z
    return DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ
end

local function CanRenderVisually(CanBeOptimized: boolean, Player: Player, Character: Instance?, Head: Instance?, Root: Instance?): (boolean, number, Vector3, Vector3?)
	if not Character or not Head or not Root then
		return false, 0, Vector3.zero, Vector3.zero
	end

	if ESPTeamCheck and not IsEnemy(Player) then
		return false, 0, Vector3.zero, Vector3.zero
	end

	local DeadState, CustomGameHealth = IsDead(Character, "Universal", 0)
	if DeadState then
		return false, CustomGameHealth, Vector3.zero, Vector3.zero
	end

	if ESPForceFieldCheck and IsProtected(Character) then
		return false, CustomGameHealth, Vector3.zero, Vector3.zero
	end

	local RootPosition = Root.Position
	local LocalRootPosition
	if LocalRoot then
		LocalRootPosition = LocalRoot.Position

		if GetDistanceSquared(LocalRootPosition, RootPosition) > ESPDistanceCheck then
			return false, CustomGameHealth, RootPosition, LocalRootPosition
		end

		if ESPWallCheck and not CanBeOptimized and IsBehindWall(LocalRootPosition, RootPosition, Character) then
			return false, CustomGameHealth, RootPosition, LocalRootPosition
		end
	end

	return true, CustomGameHealth, RootPosition, LocalRootPosition
end

InsertToConnections(RenderStepped(function(DeltaTime: number)
	UpdateFOVCircle(AimbotFOVCircles.FOVCircle, Aimbot.FOVCircle, Aimbot)
	UpdateFOVCircle(AimbotFOVCircles.S_FOVCircle, SilentAimbot.FOVCircle, SilentAimbot)

	if ESPPerformanceMode then -- Interval = 1 / 60
		ESPAccumulator += DeltaTime

		if ESPAccumulator < 0.01666666666 then
			return
		end

		ESPAccumulator -= 0.01666666666
	elseif not ESPDynamicRefreshRate then
		local Interval = 1 / ESPRefreshRate

		ESPAccumulator += DeltaTime

		if ESPAccumulator < Interval then
			return
		end

		ESPAccumulator -= Interval
	end

	if not ESPToggled or not Camera or ESPDistanceCheck <= 0 then
		for _,Cache in next, CachedPlayers do
			HideESP(Cache.ESP)
		end
		return
	end

    local ChamEnabled = ChamESP.Enabled
	local ChamFillColor, ChamOutlineColor, ChamFillTransparency, ChamOutlineTransparency

	if ChamEnabled then
		ChamFillColor = ChamESP.FillColor
		ChamOutlineColor = ChamESP.OutlineColor
		ChamFillTransparency = ChamESP.FillTransparency
		ChamOutlineTransparency = ChamESP.OutlineTransparency
	end

	local HeadDotEnabled = HeadDotESP.Enabled
	local HeadDotColor, HeadDotTransparency

	if HeadDotEnabled then
		HeadDotColor = HeadDotESP.Color
		HeadDotTransparency = HeadDotESP.Transparency
	end

	local HeadTagEnabled = HeadTagESP.Enabled
	local HeadTagColor, HeadTagTransparency, HeadTagDropdown

	if HeadTagEnabled then
		HeadTagColor = HeadTagESP.Color
		HeadTagTransparency = HeadTagESP.Transparency
		HeadTagDropdown = HeadTagESP.Dropdown
	end

	local TracerEnabled = TracerESP.Enabled
	local TracerColor, TracerTransparency
	local TracerTypeIsLocked, TracerPartIsHead

	if TracerEnabled then
		TracerColor = TracerESP.Color
		TracerTransparency = TracerESP.Transparency
		TracerTypeIsLocked = TracerESP.Type == "Locked"
		TracerPartIsHead = TracerESP.Part == "Head"
	end

	local ArrowEnabled = ArrowESP.Enabled
	local ArrowColor, ArrowFilled, ArrowRadius, ArrowTransparency

	if ArrowEnabled then
		ArrowColor = ArrowESP.Color
		ArrowFilled = ArrowESP.Filled
		ArrowRadius = ArrowESP.Radius
		ArrowTransparency = ArrowESP.Transparency
	end

	local Box2D = BoxESP.Box2D
	local Box2DEnabled = Box2D.Enabled
	local Box2DColor, Box2DTransparency

	if Box2DEnabled then
		Box2DColor = Box2D.Color
		Box2DTransparency = Box2D.Transparency
	end

	local Box3D = BoxESP.Box3D
	local Box3DEnabled = Box3D.Enabled
	local Box3DColor, Box3DTransparency

	if Box3DEnabled then
		Box3DColor = Box3D.Color
		Box3DTransparency = Box3D.Transparency
	end

	local HealthBarEnabled = HealthBarESP.Enabled
	local HealthBarColor, HealthBarThickness, HealthBarTransparency

	if HealthBarEnabled then
		HealthBarColor = HealthBarESP.Color
		HealthBarThickness = HealthBarESP.Thickness
		HealthBarTransparency = HealthBarESP.Transparency
	end

	local SkeletonEnabled = SkeletonESP.Enabled
	local SkeletonColor, SkeletonThickness, SkeletonTransparency

	if SkeletonEnabled then
		SkeletonColor = SkeletonESP.Color
		SkeletonThickness = SkeletonESP.Thickness
		SkeletonTransparency = SkeletonESP.Transparency
	end

	local ShouldContinue = ChamEnabled or HeadDotEnabled or HeadTagEnabled
	or TracerEnabled or ArrowEnabled or Box2DEnabled
	or Box3DEnabled or HealthBarEnabled or SkeletonEnabled

	if not ShouldContinue then
		for _,Cache in next, CachedPlayers do
			HideESP(Cache.ESP)
		end
		return
	end

	local IsDefuseDivision = Games.IsDefuseDivision
	local IsSniperArena = Games.IsSniperArena
	local IsAimblox = Games.IsAimblox
	local IsDefusal = Games.IsDefusal

	for Player, Cache in next, CachedPlayers do
		local ESP = Cache.ESP
		if not ESP then
			continue
		end

		local Character = Cache.Character
		local Head = Cache.Head
		local Root = Cache.Torso or Cache.Root

		local CanRenderState, CustomGameHealth, RootPosition, LocalRootPosition = CanRenderVisually(
			ChamEnabled
			and not HeadDotEnabled and not HeadTagEnabled
			and not TracerEnabled and not ArrowEnabled
			and not Box2DEnabled and not Box3DEnabled
			and not HealthBarEnabled and not SkeletonEnabled,
			Player, Character, Head, Root
		)

		if not CanRenderState then
			HideESP(ESP)
			continue
		end

		local HeadPosition = Head.Position
		local HeadScreen, HeadOnScreen = WorldToViewportPoint(HeadPosition)

		if not HeadOnScreen then
			HideESP(ESP)
			continue
		end

		local RootScreen, RootOnScreen = WorldToViewportPoint(RootPosition)

		if not RootOnScreen then
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
		if ChamEnabled and ChamObject then
			ChamObject.FillColor = ChamFillColor
			ChamObject.OutlineColor = ChamOutlineColor
			ChamObject.FillTransparency = ChamFillTransparency
			ChamObject.OutlineTransparency = ChamOutlineTransparency

			if ESPWallCheck then
				if ChamObject.DepthMode ~= HighlightDepthModeOccluded then
					ChamObject.DepthMode = HighlightDepthModeOccluded
				end
			else
				if ChamObject.DepthMode ~= HighlightDepthModeAlwaysOnTop then
					ChamObject.DepthMode = HighlightDepthModeAlwaysOnTop
				end
			end

			SetEnabled(ChamObject, true)
		elseif ChamObject then
			SetEnabled(ChamObject, false)
		end

		local HeadDotObject = ESP.HeadDot
		if HeadDotEnabled and HeadDotObject then
			HeadDotObject:Color(HeadDotColor):Transparency(HeadDotTransparency):Position(HeadScreen):Visible(true)
		elseif HeadDotObject then
			HeadDotObject:Visible(false)
		end

		local Humanoid = Cache.Humanoid
		local RigTypeIsR15: boolean = false
		if (HeadTagEnabled or SkeletonEnabled) and Humanoid.RigType == RigTypeR15 then
			RigTypeIsR15 = true
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
								OptionText =  math.floor(LocalRootPosition and (LocalRootPosition - RootPosition).Magnitude or 0) .. " Studs Away"
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

		local Box2DObject = ESP.Box2D
		if Box2DEnabled or HealthBarEnabled then
			FootScreen, FootOnScreen = WorldToViewportPoint(RootPosition - Vector3.new(0, Humanoid.HipHeight + 2, 0))
			FootScreenY = FootScreen.Y
		end

		local TracerObject = ESP.Tracer
		if TracerEnabled and TracerObject and RootOnScreen then
			TracerObject:Color(TracerColor):Transparency(TracerTransparency):From(
				TracerTypeIsLocked and FixedBottomCenter or MouseLocation
			):To(TracerPartIsHead and HeadScreen or RootScreen):Visible(true)
		elseif TracerObject then
			TracerObject:Visible(false)
		end

		local ArrowObject = ESP.Arrow
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

		local HBOutline = ESP.HealthBarOutline
		local HBFill = ESP.HealthBarFill

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

		local Box3DLines = ESP.Box3D
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

			if IsArsenalBaseGame then
				HealthPercentage = math.clamp(CustomGameHealth / Humanoid.MaxHealth, 0, 1)
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

		local SkeletonLines = ESP.Skeleton
		if SkeletonEnabled and RootOnScreen then
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
							Line:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(Position1):To(Position2):Visible(true)
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

					local NeckPosition, NeckVisible = WorldToViewportPoint(TorsoCFrame:PointToWorldSpace(TorsoSize * R6Neck))
					local WaistPosition, WaistVisible = WorldToViewportPoint(TorsoCFrame:PointToWorldSpace(TorsoSize * R6Waist))

					local SpineLine = SkeletonLines[1]
					if NeckVisible and WaistVisible then
						SpineLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
							SkeletonTransparency
						):From(NeckPosition):To(WaistPosition):Visible(true)
					else
						SpineLine:Visible(false)
					end

					local NeckLine = SkeletonLines[2]
					if NeckVisible and HeadOnScreen then
						NeckLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
							SkeletonTransparency
						):From(NeckPosition):To(HeadScreen):Visible(true)
					else
						NeckLine:Visible(false)
					end

					local LeftArm = Cache["Left Arm"]
					local LeftShoulderLine, LeftArmLine = SkeletonLines[3], SkeletonLines[4]
					if LeftArm then
						local LeftArmCFrame = LeftArm.CFrame
						local LeftArmSize = LeftArm.Size
						local Position1, Visible1 = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(LeftArmCFrame:PointToWorldSpace(LeftArmSize * R6Bottom))

						if NeckVisible and Visible1 then
							LeftShoulderLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(NeckPosition):To(Position1):Visible(true)
						else
							LeftShoulderLine:Visible(false)
						end

						if Visible1 and Visible2 then
							LeftArmLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(Position1):To(Position2):Visible(true)
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
						local Position1, Visible1 = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(RightArmCFrame:PointToWorldSpace(RightArmSize * R6Bottom))

						if NeckVisible and Visible1 then
							RightShoulderLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(NeckPosition):To(Position1):Visible(true)
						else
							RightShoulderLine:Visible(false)
						end

						if Visible1 and Visible2 then
							RightArmLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(SkeletonTransparency):From(Position1):To(Position2):Visible(true)
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
						local Position1, Visible1 = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(LeftLegCFrame:PointToWorldSpace(LeftLegSize * R6Bottom))

						if WaistVisible and Visible1 then
							LeftHipLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(WaistPosition):To(Position1):Visible(true)
						else
							LeftHipLine:Visible(false)
						end

						if Visible1 and Visible2 then
							LeftLegLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(Position1):To(Position2):Visible(true)
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
						local Position1, Visible1 = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Top))
						local Position2, Visible2 = WorldToViewportPoint(RightLegCFrame:PointToWorldSpace(RightLegSize * R6Bottom))

						if WaistVisible and Visible1 then
							RightHipLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(WaistPosition):To(Position1):Visible(true)
						else
							RightHipLine:Visible(false)
						end

						if Visible1 and Visible2 then
							RightLegLine:Color(SkeletonColor):Thickness(SkeletonThickness):Transparency(
								SkeletonTransparency
							):From(Position1):To(Position2):Visible(true)
						else
							RightLegLine:Visible(false)
						end
					else
						RightHipLine:Visible(false); RightLegLine:Visible(false)
					end
				else
					for Index = 1, 10 do
						SkeletonLines[Index]:Visible(false)
					end
				end
			end
		else
			for Index = 1, #SkeletonLines do
				SkeletonLines[Index]:Visible(false)
			end
		end
	end
end))

local function RotatePoint(Point: Vector2, Angle: number): Vector2
    local Rad = math.rad(Angle)
    local Cos = math.cos(Rad)
    local Sin = math.sin(Rad)

	local MouseLocationX = MouseLocation.X
	local MouseLocationY = MouseLocation.Y

    local DX = Point.X - MouseLocationX
    local DY = Point.Y - MouseLocationY

    return Vector2.new(MouseLocationX + (DX * Cos - DY * Sin), MouseLocationY + (DX * Sin + DY * Cos))
end

InsertToConnections(RenderStepped(function(DeltaTime: number)
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
            table.insert(DrawingLines, DrawingManager.new("Line", {
                Visible = false,
                Thickness = 1,
                Color = CrosshairOverlay.Color,
                Transparency = CrosshairOverlay.Transparency
            }))
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
        Drawings.Dot = DrawingManager.new(DotStyle, {
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
				RotatePoint(MouseLocation + (Direction * CrosshairOverlayGap), CurrentRotation
			)):To(
				RotatePoint(MouseLocation + (Direction * (CrosshairOverlayGap + CrosshairOverlayLength)), CurrentRotation)
			):Visible(true)
        end
    else
        for _,Line in next, DrawingLines do
            Line:Visible(false)
        end
    end
end))

local function GetPredictedPosition(AimbotType: string, Position: Vector3, AssemblyLinearVelocity: Vector3): Vector3
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

local function Color3ToHex(Color: Color3)
	return string.format(
		"#%02X%02X%02X",
		Color.R * 255,
		Color.G * 255,
		Color.B * 255
	)
end

local function TriggerHitFunctions(PreviousHealth: number, Health: number, WorldPosition: Vector3?)
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
			Dot = DrawingManager.new("Circle", {
				NumSides = 24,
				Filled = true,
				Thickness = 2,
				Color = Color,
				Transparency = 1,
				Visible = false
			}):Radius(2 * Scale)
		end

		if IsClassicX or IsBrokenX or IsPlus then
			for _ = 1, 4 do
				Lines[#Lines + 1] = DrawingManager.new("Line", {
					Thickness = 2,
					Color = Color,
					Transparency = 1,
					Visible = false
				})
			end
		elseif IsCircle then
			Circle = DrawingManager.new("Circle", {
				NumSides = 24,
				Filled = false,
				Thickness = 2,
				Color = Color,
				Transparency = 1,
				Visible = false
			}):Radius(Size)
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
			if not Running then
				for _,Line in next, Lines do
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

			for _,Line in next, Lines do
				Line:Transparency(Alpha):Visible(false)
			end

			if Circle then
				Circle:Transparency(Alpha):Visible(false)
			end

			if Dot then
				Dot:Transparency(Alpha):Visible(false)
			end

			if not OnScreen then
				for _,Line in next, Lines do
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
					if IsProtected(Character) then
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

		TargetAimbot = function(Target: Player, ...): (number, number)
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
					if IsProtected(Character) then
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

		TargetAimbot = function(Target: Player, DeltaTime: number): (number, number)
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

			return HealthToBeReturned, (LocalAimPartPosition - AimPartPosition).Magnitude
		end
	}
}

if not Games.Aimblox and not Games.IsStrucid and not Games.IsFantasmaPVP then
	local Functions = AimbotFunctions.Camera
	GetClosestPlayer = Functions.GetClosestPlayer
	TargetAimbot = Functions.TargetAimbot
else
	local Functions = AimbotFunctions.Mouse
	GetClosestPlayer = Functions.GetClosestPlayer
	TargetAimbot = Functions.TargetAimbot
end

local Trigger: () -> () = nil
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

			if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
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

			if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
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

			if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
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

			if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
				return
			end

			if TriggerBot.TeamCheck and not IsEnemy(Player) then
				return
			end
		else
			if not ModelInstance:FindFirstChild("NPCAnimate") then
				return
			end

			if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
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

		if TriggerBot.ForceFieldCheck and IsProtected(ModelInstance) then
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
		GetPartData = function(): Instance?
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
			GetPartData = function(): Instance?
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
			GetPartData = function(): Instance?
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

InsertToConnections(Heartbeat(function()
	if LocalRoot and AntiAim.Enabled then
		CFrameAA()
		VelocityAA()
	end
end))

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
	WindowFFlagsTab = nil,
 	WindowVisualsTab = nil,
	WindowWorldTab = nil,
	WindowSettingsTab = nil
}
local UISuccess, UIOutput = pcall(function()
	if GameId == "6765805766" then
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
		WindowTabs.WindowWorldTab = Window:AddTab("World", "globe")
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
		WindowTabs.WindowWorldTab = Window:AddTab("World", "globe")
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
local FFlagsTab = WindowTabs.WindowFFlagsTab:AddLeftGroupbox("FFlags")
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

		GetClosestPlayer()

		Connections.Aimbot = RenderStepped(function(DeltaTime: number)
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
		end)
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
Tabs.HitConfiguration:AddDropdown("AimbotHitSounds", {
	Text = "Sound",
	Values = HitSounds.Options,
	Default = 1,
	Callback = function(Sound)
		HitConfiguration.Sound.Selected = Sound
		PlayHitSound(Sound, HitConfiguration.Sound.Volume)
	end
})

if FileFunctions.listfiles and FileFunctions.isfolder and FileFunctions.makefolder and FileFunctions.isfile and getcustomassetFunction then
	local DefaultSounds = HitSounds.Options
	local HitSoundsDropdown = Options["AimbotHitSounds"]

	ThreadManager:Start("HitSoundmp3Checker", function()
		local TableOfHitSounds = table.clone(DefaultSounds)

		for _,File in ipairs(FileFunctions.listfiles("combat.cc/Sounds")) do
			if FileFunctions.isfile(File) and File:sub(-4):lower() == ".mp3" then
				local Path = File:gsub("\\", "/"):gsub("^combat%.cc/Sounds/", "")
				table.insert(TableOfHitSounds, Path)
			end
		end

		HitSoundsDropdown:SetValues(TableOfHitSounds)
	end, 0.1)
end

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
			Connections.TriggerBot = RenderStepped(Trigger)
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
		end)
	end
})
Tabs.Movement:AddSlider("FlySpeed", {
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
		end)
	end
})
Tabs.Movement:AddSlider("SpeedAmount", {
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
			LocalPlayer.CameraMaxZoomDistance = OldCameraMaxZoomDistance
			return
		end

		OldCameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
		Connections.ForceThirdPerson = RenderStepped(function()
			LocalPlayer.CameraMode = CameraModeClassic
			LocalPlayer.CameraMaxZoomDistance = 9999
		end)
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
		end)
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
                CurrentHat = Create("Part", {
					Name = "ChinaHat",
					Material = Enum.Material.Neon,
					CanCollide = false,
					CanQuery = false,
					CanTouch = false,
					Transparency = 0.3,
					Parent = Camera
				})


                Create("SpecialMesh", {
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

		Connections.AnimationFreezer = Heartbeat(function()
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
	Text = "Reset ESP Cache",
	Tooltip = "Click this if ESP is freezing/glitching.",
	Func = function()
		if cleardrawcache then
			pcall(cleardrawcache)
		end

		local ClearFunction = Drawing and Drawing.clear
		if ClearFunction then
			pcall(ClearFunction)
		end

		for _,DrawingObject in next, ESPObjects do
			if typeof(DrawingObject) == "Instance" then
				DrawingObject:Destroy()
			else
				DrawingObject:Nil()
			end
		end

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
VisualsESPTab:AddSlider("ESPConfigurationDistanceCheck", {
	Text = "Max Distance",
	Default = 4000,
	Min = 0,
	Max = 10000,
	Rounding = 1,
	Compact = false,
	Callback = function(Value)
		ESPDistanceCheck = Value * Value
	end
})
VisualsESPTab:AddToggle("ESPConfigurati onForceField", {
	Text = "ForceField Check",
	Default = ESPForceFieldCheck,
	Callback = function(State)
		ESPForceFieldCheck = State
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

				local Highlight = CoreGui:FindFirstChild("ns__LocalHighlight") or Create("Highlight", {Name = "ns__LocalHighlight", Parent = CoreGui})
				if Configuration.Enabled then
					Highlight.FillColor = Configuration.Color
					Highlight.OutlineColor = Configuration.Color
					Highlight.FillTransparency = Configuration.Transparency
					Highlight.OutlineTransparency = Configuration.Transparency
					if Highlight.Adornee ~= LocalCharacter then
						Highlight.Adornee = LocalCharacter
					end
				end
			end)
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
			for _,Object in ipairs(LocalCharacter:GetDescendants()) do
				if Object:IsA("BasePart") and Object.Name ~= "HumanoidRootPart" then
					Object.Transparency = World.CharacterTransparency
				end
			end
			World.HasAppliedCharacterTransparency = true
		end
	end
})
WorldLocalCharacterTab:AddButton({
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

local function ClearConnections(Table: table)
	for _,Value in next, Table do
		Value:Disconnect()
	end

	table.clear(Table)
end

local function Unload(Message: string)
	Library.Unload()
	task.wait()
	Running = false
	task.wait()
	ClearConnections(Connections)
	task.wait()
	ThreadManager:StopAll()
	task.wait()
	ResetFFLagModifications()

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
		for _,Object in ipairs(LocalCharacter:GetDescendants()) do
			if Object:IsA("BasePart") then
				Object.Transparency = (Object.Name == "HumanoidRootPart") and 1 or 0
			end
		end
	end

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

	if cleardrawcache then
		pcall(cleardrawcache)
	end

	local ClearFunction = Drawing and Drawing.clear
	if ClearFunction then
		pcall(ClearFunction)
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

	for _,Player in ipairs(Players:GetPlayers()) do
		ClearCache(Player)
	end

	print(Message)
end

SettingsTab:AddButton({
	Text = "Reload Script",
	Func = function()
		Unload([[ // Reloading combat.cc || Made by nikoleto scripts - github.com/nikoladhima \\ --]])
		nsloadstring(false, "https://raw.githubusercontent.com/nikoladhima/combat.cc/main/combat.cc.lua")
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
				end)
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
				end)
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
				end)
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
				end)
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
				end)
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
		local function ResetArsenalSilentAimbot(Player: Player)
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
				end)
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
				end)
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
				end)
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
				end)
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
				end)
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
				end)
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

					for _,Cache in next, CachedPlayers do
						local Character = Cache.Character
						local Part = Character and Character:FindFirstChild("Crit")
						if Part then
							Part.Size = Vector3CritSize
						end
					end

					return
				end

				Flick.HitboxExtender = Heartbeat(function()
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

		local DefaultRootSize = Vector3.new(2, 2, 1)
		local function ResetHitbox(Root: Instance?)
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
		end, 0.1)

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

				QuickShot.LobbyWeapons = RenderStepped(function()
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
		local ModificationsTab = Game:AddRightGroupbox("Modifications")

		local GasBlur = false
		local Landmines = false

		local DefaultRootSize = Vector3.new(2, 2, 1)
		local function ResetHitbox(Root: Instance?)
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
					for _,Cache in next, CachedPlayers do
						ResetHitbox(Cache.Root)
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

		local Events = ReplicatedStorage:WaitForChild("ACS_Engine", 10):WaitForChild("Events", 10)
		local ACS_Guns = ReplicatedStorage:WaitForChild("Configurations"):WaitForChild("ACS_Guns")

		local BulletFireSystem = ReplicatedStorage:WaitForChild("BulletFireSystem")
		local FireGun = BulletFireSystem:WaitForChild("FireGun")
		local BulletHit = BulletFireSystem:WaitForChild("BulletHit")

		local RocketSystemEvents = ReplicatedStorage:WaitForChild("RocketSystem"):WaitForChild("Events")
		local RocketHit = RocketSystemEvents:WaitForChild("RocketHit")
		local RocketReloadedFX = RocketSystemEvents:WaitForChild("RocketReloadedFX")

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

		local SelectedTarget = nil

		ModificationsTab:AddDropdown("WarTycoonPlayerList", {
			SpecialType = "Player",
			Text = "Select Target",
			Tooltip = "Select a player to target.",
			Callback = function(Player)
				SelectedTarget = Player
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

					WarTycoon.LoopKillTargetConnection = RunService.Heartbeat:Connect(function()
						if not SelectedTarget or SelectedTarget == LocalPlayer or not LocalCharacter or not LocalRoot then
							return
						end

						local Gun = LocalCharacter:FindFirstChildOfClass("Tool")

						if not Gun then
							return
						end

						local Cache = CachedPlayers[SelectedTarget]
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
					if WarTycoon.LoopKillTargetConnection then
						WarTycoon.LoopKillTargetConnection:Disconnect()
						WarTycoon.LoopKillTargetConnection = nil
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
					if WarTycoon.KillTargetConnection then
						WarTycoon.KillTargetConnection:Disconnect()
						WarTycoon.KillTargetConnection = nil
					end
					return
				end

				if not SelectedTarget or not LocalCharacter or not LocalRoot then
					return
				end

				if SelectedTarget == LocalPlayer then
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

				local Cache = CachedPlayers[SelectedTarget]
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
				elseif Character:FindFirstChild("BaseShieldForceField") or Character:FindFirstChild("StarterShield_ForceField") then
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
						if WarTycoon.KillTargetConnection then
							WarTycoon.KillTargetConnection:Disconnect()
							WarTycoon.KillTargetConnection = nil
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

					if Character:FindFirstChild("BaseShieldForceField") or Character:FindFirstChild("StarterShield_ForceField") then
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
				WarTycoon.KillTargetConnection = Connection
			end
		})

		local LoopRPGSpamTarget = false

		ModificationsTab:AddToggle("LoopRPGSpamTarget", {
			Text = "Loop RPG Spam Target [Equip RPG]",
			Default = false,
			Callback = function(Value)
				LoopRPGSpamTarget = Value

				if Value then
					WarTycoon.LoopRPGSpamTargetConnection = RunService.Heartbeat:Connect(function()
						if not SelectedTarget or SelectedTarget == LocalPlayer or not LocalCharacter or not LocalRoot then
							return
						end

						local Gun = LocalCharacter:FindFirstChild("RPG")

						if not Gun then
							return
						end

						local Cache = CachedPlayers[SelectedTarget]
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

						if Humanoid.Sit then
							RocketHit:FireServer({
								Normal = vector.create(0.9848124980926514, 0, 0.17362114787101746),
								Player = LocalPlayer,
								Label = LocalPlayer.Name .. "Rocket3",
								HitPart = nil,
								Vehicle = Gun,
								Position = Root.Position,
								Weapon = Gun
							})
						else
							local RootPosition = Root.Position
							local RocketHitArguments = {
								Normal = vector.create(0.9848124980926514, 0, 0.17362114787101746),
								Player = LocalPlayer,
								Label = LocalPlayer.Name .. "Rocket3",
								HitPart = nil,
								Vehicle = Gun,
								Position = RootPosition,
								Weapon = Gun
							}

							RocketHit:FireServer(RocketHitArguments)
							RocketHitArguments.Position = RootPosition + Vector3.new(math.random(10, 40), 0, 0)
							RocketHit:FireServer(RocketHitArguments)
						end
					end)
				else
					if WarTycoon.LoopRPGSpamTargetConnection then
						WarTycoon.LoopRPGSpamTargetConnection:Disconnect()
						WarTycoon.LoopRPGSpamTargetConnection = nil
					end
				end
			end
		})

		ModificationsTab:AddButton({
			Text = "RPG Spam Target [Equip RPG]",
			Func = function()
				if LoopRPGSpamTarget then
					if WarTycoon.RPGSpamTargetConnection then
						WarTycoon.RPGSpamTargetConnection:Disconnect()
						WarTycoon.RPGSpamTargetConnection = nil
					end
					return
				end

				if not SelectedTarget or not LocalCharacter or not LocalRoot then
					return
				end

				if SelectedTarget == LocalPlayer then
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

				local Cache = CachedPlayers[SelectedTarget]
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
				elseif Character:FindFirstChild("BaseShieldForceField") or Character:FindFirstChild("StarterShield_ForceField") then
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
						if WarTycoon.RPGSpamTargetConnection then
							WarTycoon.RPGSpamTargetConnection:Disconnect()
							WarTycoon.RPGSpamTargetConnection = nil
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

					if Character:FindFirstChild("BaseShieldForceField") or Character:FindFirstChild("StarterShield_ForceField") then
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

					if Humanoid.Sit then
						RocketHit:FireServer({
							Normal = vector.create(0.9848124980926514, 0, 0.17362114787101746),
							Player = LocalPlayer,
							Label = LocalPlayer.Name .. "Rocket3",
							HitPart = nil,
							Vehicle = Gun,
							Position = Root.Position,
							Weapon = Gun
						})
					else
						local RootPosition = Root.Position
						local RocketHitArguments = {
							Normal = vector.create(0.9848124980926514, 0, 0.17362114787101746),
							Player = LocalPlayer,
							Label = LocalPlayer.Name .. "Rocket3",
							HitPart = nil,
							Vehicle = Gun,
							Position = RootPosition,
							Weapon = Gun
						}

						RocketHit:FireServer(RocketHitArguments)
						RocketHitArguments.Position = RootPosition + Vector3.new(math.random(10, 40), 0, 0)
						RocketHit:FireServer(RocketHitArguments)
					end
				end)
				WarTycoon.RPGSpamTargetConnection = Connection
			end
		})

		table.insert(WarTycoon, Camera.ChildAdded:Connect(function(Child)
			if GasBlur and Child.Name:lower():find("blur") then
				Child:Destroy()
			end
		end))

		ModificationsTab:AddToggle("GasBlurRemoval", {
			Text = "Gas Blur Removal",
			Default = GasBlur,
			Callback = function(Value)
				GasBlur = Value
				if Value and Camera then
					for _,Child in next, Camera:GetChildren() do
						if Child.Name:lower():find("blur") then
							Child:Destroy()
						end
					end
				end
			end
		})

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

		local getgc = getgc or get_gc or getgarbagecollector or get_garbagecollector or get_garbage_collector
		if getgc then
			local OriginalGCAttributes = {}

			local function UpdateItemAttribute(Name: string, NewValue: any)
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

			local function RestoreItemAttribute(Name: string)
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
	FileFunctions.writefile("combat.cc/Nikoleto.iy", tostring(game:HttpGet(
		"https://raw.githubusercontent.com/nikoladhima/combat.cc/refs/heads/main/utils/NikoletoService.luau"
	)))
	if FileFunctions.isfile("IY_FE.iy") then
		local Data = HttpService:JSONDecode(FileFunctions.readfile("IY_FE.iy"))
		if Data and type(Data) == "table" then
			if table.find(Data.PluginsTable, "combat.cc/Nikoleto.iy") then
				return
			end

			table.insert(Data.PluginsTable, "combat.cc/Nikoleto.iy")
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
	Description = "Loaded combat.cc " .. (IsMouseAndKeyboardPreferredInput and "(Default Keybind: Right Shift)" or "successfully") .. " || Made by nikoleto scripts - github.com/nikoladhima",
	Time = 3.5
})

Library:Toggle(true)

local ThemeManager = Module:Get("ThemeManager")
if ThemeManager then
	ThemeManager:SetLibrary(Library)
	ThemeManager:SetFolder("combat.cc/Themes")
	ThemeManager:ApplyToTab(WindowTabs.WindowSettingsTab)
end

local SaveManager = Module:Get("SaveManager")
if SaveManager then
	SaveManager:SetLibrary(Library)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({"MenuKeybind"})
	SaveManager:SetFolder("combat.cc/Configs")
	SaveManager:BuildConfigSection(WindowTabs.WindowSettingsTab)
	SaveManager:LoadAutoloadConfig()
end

ThreadManager:Start("VersionChecker", function()
	local LatestVersion = nsloadstring("https://raw.githubusercontent.com/nikoladhima/combat.cc/main/core/LatestVersion.lua")
	if LatestVersion and type(LatestVersion) == "string" then
		if ScriptVersion:gsub(LatestVersion, "IsLatestVersion") ~= "IsLatestVersion" then
			Library:Notify({
				Title = "[[ combat.cc ]]",
				Description = "Script v." .. ScriptVersion .. " is Out-Of-Date, please re-execute to get the latest update v." .. LatestVersion,
				Time = 3.5
			})
		end
	end
end, 10)

task.spawn(function()
	local httprequest = httprequest or http_request or request or HttpPost or (http and http.request) or (syn and syn.request) or function(...)
		return (...)
	end

	local function Invite(InviteCode: string)
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

print("[nikoletoscripts/combat.cc]: Loaded script successfully in " .. tostring(tick() - StartTick) .. "s.")

if type((...)) == "string" and (...) == "RemoveLogging" then
	warn("[Service Info] RemoveLogging is enabled, this means that ZERO information will be logged.")
	return
end

Module:Log()
