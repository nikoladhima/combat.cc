return function(Center, Point, Angle)
    local Rad = math.rad(Angle)
    local Cos = math.cos(Rad)
    local Sin = math.sin(Rad)

	local CenterX = Center.X
	local CenterY = Center.Y

    local DX = Point.X - CenterX
    local DY = Point.Y - CenterY

    return Vector2.new(CenterX + (DX * Cos - DY * Sin), CenterY + (DX * Sin + DY * Cos))
end
