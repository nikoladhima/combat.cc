local ESPUtils = {}
ESPUtils.__index = ESPUtils

function ESPUtils.new(DrawingObject)
    local Proxy = {}
    Proxy.DrawingObject = DrawingObject
    return setmetatable(Proxy, {
        __index = function(self, key)
            if ESPUtils[key] then
                return ESPUtils[key]
            end
            return self.DrawingObject[key]
        end,
        __newindex = function(self, key, value)
            self.DrawingObject[key] = value
        end
    })
end

function ESPUtils:Set(Property, Value)
    if self.DrawingObject[Property] ~= Value then
        self.DrawingObject[Property] = Value
    end
    return self
end

function ESPUtils:Visible(State)
    return self:Set("Visible", State)
end

function ESPUtils:VisibleNilCheck(State)
    if self then
        return self:Set("Visible", State)
    end
end

function ESPUtils:Enabled(State)
    return self:Set("Enabled", State)
end

function ESPUtils:Size(Size)
    return self:Set("Size", Size)
end

function ESPUtils:Color(Color)
    return self:Set("Color", Color)
end

function ESPUtils:Filled(Filled)
    return self:Set("Filled", Filled)
end

function ESPUtils:Thickness(Thickness)
    return self:Set("Thickness", Thickness)
end

function ESPUtils:Transparency(Alpha)
    return self:Set("Transparency", Alpha)
end

function ESPUtils:Radius(Radius)
    return self:Set("Radius", Radius)
end

function ESPUtils:Nil()
    return pcall(function()
        self:Remove()
    end)
end

function ESPUtils.HideAll(ESP)
	local Chams = ESP.Chams
	if Chams then
		if Chams.Highlight then
			Chams.Highlight:Enabled(false)
		end
		if Chams.Wireframes then
			for _,Box in next, Chams.Wireframes do
				Box:Visible(false)
			end
		end
	end

	ESP.HeadDot:VisibleNilCheck(false)
	ESP.HeadTag:VisibleNilCheck(false)
	ESP.Tracer:VisibleNilCheck(false)
	ESP.Arrow:VisibleNilCheck(false)
	ESP.Box2D:VisibleNilCheck(false)
	ESP.HealthBarOutline:VisibleNilCheck(false)
	ESP.HealthBarFill:VisibleNilCheck(false)

	local Box3DLines = ESP.Box3D
	if Box3DLines then
		for _,Line in next, Box3DLines do
			Line:Visible(false)
		end
	end

	local SkeletonLines = ESP.Skeleton
	if SkeletonLines then
		for _,Line in next, SkeletonLines do
			Line:Visible(false)
		end
	end
end

function ESPUtils.GetDistanceSquared(Point1, Point2)
    local DeltaX = Point1.X - Point2.X
    local DeltaY = Point1.Y - Point2.Y
    local DeltaZ = Point1.Z - Point2.Z
    return DeltaX * DeltaX + DeltaY * DeltaY + DeltaZ * DeltaZ
end

return ESPUtils
