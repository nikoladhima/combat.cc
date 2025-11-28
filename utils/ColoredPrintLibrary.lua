local cloneref = cloneref or clone_ref or clonereference or clone_reference or function(...)
	return (...)
end

local CoreGui = cloneref(game:GetService("CoreGui"))
local HttpService = cloneref(game:GetService("HttpService"))
local LogService = cloneref(game:GetService("LogService"))

local sub = string.sub
local find = string.find
local format = string.format
local round = math.round

local fWaitForChild = game.WaitForChild

local function ColoredPrintWaitPath(Instance1, Instance2, Instance3, Instance4)
	local Path = CoreGui
	for _,InstanceName in next, {Instance1, Instance2, Instance3, Instance4} do
		Path = fWaitForChild(Path, InstanceName, 1000)
	end
	return Path
end

local function ColoredPrintSetIcon(ImageInstance, IconData, DefaultColor)
	if not IconData or not IconData[1] then
		return
	end

	local IconName, Tinted = IconData[1], IconData[2]
	local Color = Tinted and DefaultColor or Color3.new(255, 255, 255)

	if type(IconName) == "number" then
		ImageInstance.Image = "rbxassetid://" .. tostring(IconName)
		ImageInstance.ImageColor3 = Color
		return
	end

	IconName = IconName:lower()

	local Icons = {
		information = {"rbxasset://textures/DevConsole/Info.png", "rbxassetid://98895588220731"},
		info = {"rbxasset://textures/DevConsole/Info.png", "rbxassetid://98895588220731"},
		success = {"rbxassetid://75097763556603", "rbxassetid://87889653826033"},
		check = {"rbxassetid://75097763556603", "rbxassetid://87889653826033"},
		tick = {"rbxassetid://75097763556603", "rbxassetid://87889653826033"},
	}

	local IconSet = Icons[IconName]
	if IconSet then
		ImageInstance.Image = IconSet[Tinted and 2 or 1]
		ImageInstance.ImageColor3 = Color
	end
end

local function ColoredPrintUpdate(_Instance, TextFinder, Text, Color, Icon)
	for _,Child in next, _Instance:GetDescendants() do
		if Child:IsA("TextLabel") and find(Child.Text, TextFinder, 1, true) then
			Child:SetAttribute("hasbefore", true)
			Child.RichText = true

			local OriginalTime = sub(Child.Text, 1, 11)

			Child.Text = format(
				"<font color='rgb(%s,%s,%s)' size='15'>%s %s </font>",
				round(Color.R * 255), round(Color.G * 255), round(Color.B * 255),
				OriginalTime, Text
			)

			local ImageInstance = Child.Parent:FindFirstChild("image")
			if ImageInstance then
				ColoredPrintSetIcon(ImageInstance, Icon, Color)
				ImageInstance:GetPropertyChangedSignal("Image"):Once(function()
					ImageInstance.ImageColor3 = Color3.new(255, 255, 255)
				end)
			end
			break
		end
	end
end

local ColoredPrintLibrary = {ColoredPrint = nil, Connections = {}}
local Connections = ColoredPrintLibrary.Connections
ColoredPrintLibrary.ColoredPrint = function(Text, Color, Icon)
    task.spawn(function()
        local TextFinder = "‎" .. Text .. sub(HttpService:GenerateGUID(false), 1, 10)
        print(TextFinder)

        ColoredPrintWaitPath("DevConsoleMaster", "DevConsoleWindow", "DevConsoleUI", "MainView")
        task.wait(0.009)
        ColoredPrintUpdate(ColoredPrintWaitPath("DevConsoleMaster", "DevConsoleWindow", "DevConsoleUI", "MainView"), TextFinder, Text, Color, Icon)

        task.spawn(function()
            local Done = 0
            local MainView = ColoredPrintWaitPath("DevConsoleMaster", "DevConsoleWindow", "DevConsoleUI", "MainView")
            local ClientLog = fWaitForChild(MainView, "ClientLog", 5)

            if ClientLog and ClientLog.CanvasSize.Y.Offset >= 8500 then
                table.insert(Connections, LogService.MessageOut:Connect(function()
                    if Done < 22 then
                        task.wait(0.01)
                        Done += 1
                        ColoredPrintUpdate(MainView, TextFinder, Text, Color, Icon)
                    end
                end))
            end
        end)

        local MainUI = CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI

        table.insert(Connections, fWaitForChild(MainUI.MainView, "ClientLog", 5).ChildAdded:Connect(function(Child)
            ColoredPrintUpdate(Child, TextFinder, Text, Color, Icon)
        end))

        table.insert(Connections, MainUI.ChildAdded:Connect(function(Child)
            if Child.Name == "MainView" then
                task.wait()
                ColoredPrintUpdate(Child, TextFinder, Text, Color, Icon)
                table.insert(ColoredPrintLibrary.Connections, fWaitForChild(Child, "ClientLog", 5).ChildAdded:Connect(function(Child2)
                    ColoredPrintUpdate(Child2, TextFinder, Text, Color, Icon)
                end))
            end
        end))
    end)
end
return ColoredPrintLibrary
