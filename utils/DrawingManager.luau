local DrawingNew = (...)

if not DrawingNew or type(DrawingNew) ~= "function" then
    return "Failed to get Drawing function."
end

local DrawingManager = {}
DrawingManager.__index = DrawingManager

function DrawingManager.new(Type, Properties)
    local DrawingObject = DrawingNew(Type)

	if Properties then
		for Property, Value in next, Properties do
			local Success, Error = pcall(function()
				if DrawingObject[Property] then
					DrawingObject[Property] = Value
				end
			end)

			if not Success then
				print("[DEBUG] Error setting", Property, "on", Type .. ":", Error)
			end
		end
	end

    return setmetatable({
        DrawingObject = DrawingObject
    }, DrawingManager)
end

DrawingManager.__index = function(self, Key)
    return DrawingManager[Key] or self.DrawingObject[Key]
end

DrawingManager.__newindex = function(self, Key, Value)
    self.DrawingObject[Key] = Value
end

for _,Property in ipairs({
    "Visible", "Center", "Size", "Color",
    "Filled", "Thickness", "Transparency",
    "Radius", "Text"
}) do
    DrawingManager[Property] = function(self, Value)
        if self.DrawingObject[Property] ~= Value then
            self.DrawingObject[Property] = Value
        end
        return self
    end
end

for _,Property in ipairs({
    "Position", "From", "To",
    "PointA", "PointB", "PointC"
}) do
    DrawingManager[Property] = function(self, Value)
        self.DrawingObject[Property] = Value
        return self
    end
end

function DrawingManager:Nil()
    return pcall(function()
        self.DrawingObject:Remove()
    end)
end

return DrawingManager
