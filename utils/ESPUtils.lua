local ESPUtils = {}
ESPUtils.__index = ESPUtils

function ESPUtils.new(DrawingObject)
    return setmetatable({
        DrawingObject = DrawingObject
    }, ESPUtils)
end

ESPUtils.__index = function(self, Key)
    return ESPUtils[Key] or self.DrawingObject[Key]
end

ESPUtils.__newindex = function(self, Key, Value)
    self.DrawingObject[Key] = Value
end

for _,Property in ipairs({"Visible", "Center", "Size", "Color", "Filled", "Thickness", "Transparency", "Radius", "Text"}) do
    ESPUtils[Property] = function(self, Value)
        if self.DrawingObject[Property] ~= Value then
            self.DrawingObject[Property] = Value
        end
        return self
    end
end

for _,Property in ipairs({"Position", "From", "To", "PointA", "PointB", "PointC"}) do
    ESPUtils[Property] = function(self, Value)
        self.DrawingObject[Property] = Value
        return self
    end
end

function ESPUtils:Nil()
    local Success = pcall(function()
        self.DrawingObject:Remove()
    end)
    return Success
end

function ESPUtils.HideAll(ESP)
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
            continue
        end

        Object:Visible(false)
    end
end

function ESPUtils.GetDistanceSquared(Point1, Point2)
    local DeltaX = Point1.X - Point2.X
    local DeltaY = Point1.Y - Point2.Y
    local DeltaZ = Point1.Z - Point2.Z
    return DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ
end

return ESPUtils
