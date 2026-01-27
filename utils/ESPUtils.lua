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

function ESPUtils:SetInstant(Property, Value)
    self.DrawingObject[Property] = Value
    return self
end

function ESPUtils:Enabled(State)
    return self:Set("Enabled", State)
end

function ESPUtils:Visible(State)
    return self:Set("Visible", State)
end

function ESPUtils:Center(State)
    return self:Set("Center", State)
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

function ESPUtils:Text(Text)
    return self:Set("Text", Text)
end

function ESPUtils:Position(Position)
    return self:SetInstant("Position", Position)
end

function ESPUtils:From(From)
    return self:SetInstant("From", From)
end

function ESPUtils:To(To)
    return self:SetInstant("To", To)
end

function ESPUtils:PointA(PointA)
    return self:SetInstant("PointA", PointA)
end

function ESPUtils:PointB(PointB)
    return self:SetInstant("PointB", PointB)
end

function ESPUtils:PointC(PointC)
    return self:SetInstant("PointC", PointC)
end

function ESPUtils:Nil()
    return pcall(function()
        self:Remove()
    end)
end

function ESPUtils.HideAll(ESP)
	local Cham = ESP.Cham
	if Cham then
        if Cham.Enabled ~= false then
            Cham.Enabled = false
        end
	end

    if ESP.HeadDot then
        ESP.HeadDot:Visible(false)
    end

    if ESP.HeadTag then
        ESP.HeadTag:Visible(false)
    end

    if ESP.Tracer then
	    ESP.Tracer:Visible(false)
    end

    if ESP.Arrow then
        ESP.Arrow:Visible(false)
    end

    if ESP.Box2D then
        ESP.Box2D:Visible(false)
    end

    if ESP.HealthBarOutline then
        ESP.HealthBarOutline:Visible(false)
    end

    if ESP.HealthBarFill then
        ESP.HealthBarFill:Visible(false)
    end

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
