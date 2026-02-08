local DrawingNew = (...)

if not DrawingNew then
    return "Failed to get Drawing function."
end

local DrawingUtils = {}
DrawingUtils.__index = DrawingUtils

function DrawingUtils.new(Type, Properties)
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
    }, DrawingUtils)
end

DrawingUtils.__index = function(self, Key)
    return DrawingUtils[Key] or self.DrawingObject[Key]
end

DrawingUtils.__newindex = function(self, Key, Value)
    self.DrawingObject[Key] = Value
end

for _,Property in ipairs({
    "Visible", "Center", "Size", "Color",
    "Filled", "Thickness", "Transparency",
    "Radius", "Text"
}) do
    DrawingUtils[Property] = function(self, Value)
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
    DrawingUtils[Property] = function(self, Value)
        self.DrawingObject[Property] = Value
        return self
    end
end

function DrawingUtils:Nil()
    local Success = pcall(function()
        self.DrawingObject:Remove()
    end)
    return Success
end

function DrawingUtils.HideAll(ESP)
    if not ESP then
        return
    end

    for Index, Object in next, ESP do
        if Index == "Cham" or Index == "Profile" then
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

function DrawingUtils.GetDistanceSquared(Point1, Point2)
    local DeltaX = Point1.X - Point2.X
    local DeltaY = Point1.Y - Point2.Y
    local DeltaZ = Point1.Z - Point2.Z
    return DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ
end

return DrawingUtils
