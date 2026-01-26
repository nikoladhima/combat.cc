local ESPUtils = {}
ESPUtils.__index = ESPUtils

function ESPUtils.new(DrawingObject)
    local self = setmetatable({}, ESPUtils)
    self.DrawingObject = DrawingObject
    return self
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

return ESPUtils
