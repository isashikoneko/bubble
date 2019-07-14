require("Circle")
require("Vector2")

Player = {
    body = nil
}

Player.__index = Player

RADIUS = 10
MASS = 2

function Player:init(pos_x, pos_y)
    local o = setmetatable({}, self)

    o.body = Circle:init(Vector2:init(pos_x, pos_y), RADIUS, MASS)

    return o 
end

function Player:update(dt)

end

function Player:draw()

    self.body:draw()

end