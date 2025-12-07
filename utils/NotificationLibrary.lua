local cloneref = cloneref or clone_ref or clonereference or clone_reference or function(...)
	return (...)
end

local CoreGui = cloneref(game:GetService("CoreGui"))

local function Create(Type : string)
	return cloneref(Instance.new(Type))
end

local NotificationGUI = CoreGui:FindFirstChild("STX_Nofitication")
if not NotificationGUI then
    NotificationGUI = Create("ScreenGui")
    NotificationGUI.Name = "NikoletoScripts_Nofitication"
    NotificationGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotificationGUI.ResetOnSpawn = false
    NotificationGUI.Parent = CoreGui

    local NofiticationUIListLayout = Create("UIListLayout")
    NofiticationUIListLayout.Name = "NikoletoScripts_NofiticationUIListLayout"
    NofiticationUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    NofiticationUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NofiticationUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NofiticationUIListLayout.Parent = NotificationGUI
end

local Nofitication = {}
function Nofitication:Notify(Table1, Table2, Table3)
    local SelectedType = Table2.Type
    local AmbientShadow = Create("ImageLabel")
    local Window = Create("Frame")
    local Outline_A = Create("Frame")
    local WindowTitle = Create("TextLabel")
    local WindowDescription = Create("TextLabel")

    AmbientShadow.Name = "AmbientShadow"
    AmbientShadow.Parent = NotificationGUI
    AmbientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    AmbientShadow.BackgroundTransparency = 1.000
    AmbientShadow.BorderSizePixel = 0
    AmbientShadow.Position = UDim2.new(0.91525954, 0, 0.936809778, 0)
    AmbientShadow.Size = UDim2.new(0, 0, 0, 0)
    AmbientShadow.Image = "rbxassetid://1316045217"
    AmbientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    AmbientShadow.ImageTransparency = 0.400
    AmbientShadow.ScaleType = Enum.ScaleType.Slice
    AmbientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

    Window.Name = "Window"
    Window.Parent = AmbientShadow
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0, 5, 0, 5)
    Window.Size = UDim2.new(0, 230, 0, 80)
    Window.ZIndex = 2

    Outline_A.Name = "Outline_A"
    Outline_A.Parent = Window
    Outline_A.BackgroundColor3 = Table2.OutlineColor
    Outline_A.BorderSizePixel = 0
    Outline_A.Position = UDim2.new(0, 0, 0, 25)
    Outline_A.Size = UDim2.new(0, 230, 0, 2)
    Outline_A.ZIndex = 5

    WindowTitle.Name = "WindowTitle"
    WindowTitle.Parent = Window
    WindowTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowTitle.BackgroundTransparency = 1.000
    WindowTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
    WindowTitle.BorderSizePixel = 0
    WindowTitle.Position = UDim2.new(0, 8, 0, 2)
    WindowTitle.Size = UDim2.new(0, 222, 0, 22)
    WindowTitle.ZIndex = 4
    WindowTitle.Font = Enum.Font.GothamSemibold
    WindowTitle.Text = Table1.Title
    WindowTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
    WindowTitle.TextSize = 12.000
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

    WindowDescription.Name = "WindowDescription"
    WindowDescription.Parent = Window
    WindowDescription.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    WindowDescription.BackgroundTransparency = 1.000
    WindowDescription.BorderColor3 = Color3.fromRGB(27, 42, 53)
    WindowDescription.BorderSizePixel = 0
    WindowDescription.Position = UDim2.new(0, 8, 0, 34)
    WindowDescription.Size = UDim2.new(0, 216, 0, 40)
    WindowDescription.ZIndex = 4
    WindowDescription.Font = Enum.Font.GothamSemibold
    WindowDescription.Text = Table1.Description
    WindowDescription.TextColor3 = Color3.fromRGB(180, 180, 180)
    WindowDescription.TextSize = 12.000
    WindowDescription.TextWrapped = true
    WindowDescription.TextXAlignment = Enum.TextXAlignment.Left
    WindowDescription.TextYAlignment = Enum.TextYAlignment.Top

    if SelectedType == "Default" then
        AmbientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
        Window.Size = UDim2.new(0, 230, 0, 80)
        Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", Table2.Time)
        task.wait(Table2.Time)
        AmbientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
        task.wait(0.2)
        AmbientShadow:Destroy()
    elseif SelectedType == "Image" then
        AmbientShadow:TweenSize(UDim2.new(0, 240, 0, 90), "Out", "Linear", 0.2)
        Window.Size = UDim2.new(0, 230, 0, 80)
        WindowTitle.Position = UDim2.new(0, 24, 0, 2)
        local ImageButton = Create("ImageButton")
        ImageButton.Parent = Window
        ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageButton.BackgroundTransparency = 1.000
        ImageButton.BorderSizePixel = 0
        ImageButton.Position = UDim2.new(0, 4, 0, 4)
        ImageButton.Size = UDim2.new(0, 18, 0, 18)
        ImageButton.ZIndex = 5
        ImageButton.AutoButtonColor = false
        ImageButton.Image = Table3.Image
        ImageButton.ImageColor3 = Table3.ImageColor
        Outline_A:TweenSize(UDim2.new(0, 0, 0, 2), "Out", "Linear", Table2.Time)
        task.wait(Table2.Time)
        AmbientShadow:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Linear", 0.2)
        task.wait(0.2)
        AmbientShadow:Destroy()
    else
        print("NotificationLibrary Error: Invalid Notification Type '" .. tostring(Table2.Type) .. "'")
    end
end
return Nofitication
