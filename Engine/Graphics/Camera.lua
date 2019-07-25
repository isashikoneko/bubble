require("engine_config")
require(PHYSICS_ENGINE_PATH .. "Vector2")

Camera = {
    offset = nil,
    limit = nil,
    position = nil,
    zoom = nil,
    rotation = 0
}

Camera.__index = Camera

function Camera:init(offsetx, offsety, positionx, positiony, limitx, limity)
    local o = setmetatable({}, self)

    o.zoom = Vector2:init(1, 1)
    o.limit = Vector2:init(limitx, limity)
    o.offset = Vector2:init(offsetx, offsety)
    o.position = Vector2:init(positionx, positiony)
    o.rotation = 0

    return o 
end

function Camera:move(x, y)
    self.position.x = self.position.x + x 
    self.position.y = self.position.y + y
end

function Camera:scale(x, y)

    if x ~= 0 and y ~= 0 then 
        self.zoom.x = self.zoom.x * x 
        self.zoom.y = self.zoom.y * y
    end

end

function Camera:rotate(r)
    self.rotation = self.rotation + r
end

function Camera:set()
    love.graphics.push()

    love.graphics.rotate(self.rotation)
    love.graphics.scale(self.zoom.x, self.zoom.y)
    love.graphics.translate(-self.position.x, -self.position.y)
    
end

function Camera:unset()
    love.graphics.pop()
end
