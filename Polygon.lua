require("Vector2")

Polygon = {
    pos = nil,
    vertex = {},
    points = {},
    mass = 0,
    velocity = nil,
    acceleration = nil,
    appliedForce = nil
}

Polygon.__index = Polygon

function Polygon:init(x, y, vertex, mass)
    local o = setmetatable({}, self)

    o.pos = Vector2:init(x, y)
    o.vertex = {}
    o.points = {}

    o.mass = mass

    o.velocity = Vector2:init(0, 0)
    o.acceleration = Vector2:init(0, 0)
    o.appliedForce = Vector2:init(0, 0)

    for i,v in ipairs(vertex) do
        table.insert(o.points, v[1] + x)
        table.insert(o.points, v[2] + y)
        table.insert(o.vertex, Vector2:init(v[1], v[2]))
    end

    return o
end

function Polygon:update(dt)

    self.acceleration = self.appliedForce:scalar(1 / self.mass)

    self.velocity.x = self.acceleration.x * dt
    self.velocity.y = self.acceleration.y * dt

    self:translate((1 / 2) * (self.acceleration.x * dt * dt), (1 / 2) * (self.acceleration.y * dt * dt))

end

function Polygon:translate(vx, vy)
    self.points = {}
    self.pos:translate(Vector2:init(vx, vy))
    for i=1,table.getn(self.vertex) do
        table.insert(self.points, self.vertex[i].x + self.pos.x)
        table.insert(self.points, self.vertex[i].y + self.pos.y)
    end
end

function Polygon:applyForce(f)

    self.appliedForce = self.appliedForce:add(f)

end

function Polygon:draw()
    love.graphics.polygon("line", self.points)
end