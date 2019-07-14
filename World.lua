require("Circle")
require("Vector2")
require("Polygon")
require("Collision")

World = {
    constant_force = nil,
    collision = nil,
    gameObject = {}
}

World.__index = World

DYNAMIC_BODY = 0
STATIC_BODY = 1

function World:init(fx, fy)
    local o = setmetatable({}, self)

    o.collision = Collision:init()
    o.constant_force = Vector2:init(fx, fy)

    return o
end

function World:addObject(name, body, type)
    self.gameObject[name] = {}
    self.gameObject[name]['body'] = body
    self.gameObject[name]['type'] = type
end

function World:updateObject(name, body, type)
    self.gameObject[name] = {}
    self.gameObject[name]['body'] = body
    self.gameObject[name]['type'] = type
end

function World:applyForce()

    -- Apply constant force on dynamic object

    for k,v in pairs(self.gameObject) do
        if v['type'] == DYNAMIC_BODY then
            self.gameObject[k]['body']:applyForce(self.constant_force)
        end
    end

end

function World:update()

    --collision management

    for k,v in pairs(self.gameObject) do

        if v['type'] == DYNAMIC_BODY then

            for j,val in pairs(self.gameObject) do
                if k ~= j then

                    if v['body'].radius == nil then

                    else

                        local collide, p_vector, p_distance = self.collision:circleToPolygon(v['object'], val['object'])

                        if collide then

                            --print("(" .. p_vector.x .. ", " .. p_vector.y .. ") soit " .. p_vector:distance() .. " and distance = " .. p_distance)
                    
                            self.gameObject[k]['body']:translate(p_vector.x * p_distance, p_vector.y * p_distance)
                    
                        end

                    end

                end
            end

        end
        
    end

end

function World:draw()

    for k,v in pairs(self.gameObject) do
        v['body']:draw()
    end

end
