require("engine_config")
require(PHYSICS_ENGINE_PATH .. "Collision")

EventZone = {
    body = nil,
    collision = nil
}

EventZone.__index = EventZone

function EventZone:init(body)
    local o = setmetatable({}, self)

    o.body = body
    o.collision = Collision:init()

    return o
end

function EventZone:enterEvent(body)
    local collide = false
    if body.radius == nil then 
        collide = self.collision:PolygonToPolygon(body, self.body)
    else
        collide = self.collision:circleToPolygon(body, self.body)
    end
    return collide
end

function EventZone:draw()
    love.graphics.setColor(0, 255, 0, 255)

    self.body:draw()

    love.graphics.setColor(255, 255, 255, 255)
end