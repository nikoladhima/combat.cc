local ESPObject = {}
ESPObject.__index = ESPObject

function ESPObject.new(Cache)
    return setmetatable({
        Cache = Cache,
        ESP = Cache.ESP,
    }, ESPObject)
end

function ESPObject:HideAll()
    local ESP = self.ESP
    if not ESP then
		return
	end

    SetVisible(ESP.HeadDot, false)
    SetVisible(ESP.HeadTag, false)
    SetVisible(ESP.Tracer, false)
    SetVisible(ESP.Arrow, false)
    SetVisible(ESP.Box2D, false)
    SetVisible(ESP.HealthBarOutline, false)
    SetVisible(ESP.HealthBarFill, false)

    if ESP.Box3D then
        for _,Line in next, ESP.Box3D do
            SetVisible2(Line, false)
        end
    end

    if ESP.Skeleton then
        for _,Line in next, ESP.Skeleton do
            SetVisible2(Line, false)
        end
    end
end

return ESPObject
