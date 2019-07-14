require("Vector2")

Collision = {

}

Collision.__index = Collision

function Collision:init()
    local o = setmetatable({}, self)

    return o 
end

function Collision:circleToPolygon(circle, polygon)

    local collide = false
    local penetration_vector = Vector2:init(0, 0)
    local penetration_distance = 0

    for i=1,table.getn(polygon.vertex) do

        local k = i + 1
        
        if i == table.getn(polygon.vertex) then
            k = 1
        end

        local a = Vector2:add(polygon.vertex[i], polygon.pos)
        local b = Vector2:add(polygon.vertex[k], polygon.pos)
        local o = circle.center

        local ab = Vector2:getVector(a, b)
        local ba = Vector2:getVector(b, a)
        local ao = Vector2:getVector(a, o)
        local bo = Vector2:getVector(b, o)

        local d_ab = ab:distance()
        local ah = ab:dot(ao) / d_ab
        local bh = ba:dot(bo) / d_ab
        local d_ah = math.abs(ah)
        local d_bh = math.abs(bh)
        local v = ab:getNormalize()
        
        local oh = math.sqrt(ao:distance() * ao:distance() - d_ah * d_ah)

        if d_ah < d_ab + circle.radius and d_bh < d_ab + circle.radius then

            if oh < circle.radius then
                penetration_distance = circle.radius - oh
                local h = Vector2:init(
                    a.x + (ah) * v.x, 
                    a.y + (ah) * v.y
                )
                penetration_vector = Vector2:getVector(h, o)
                penetration_vector = penetration_vector:getNormalize()
                return true, penetration_vector, penetration_distance
            end

        end

    end

    return false, Vector2:init(0, 0), 0
end

function Collision:polygonToPolygon(polygon1, polygon2)

end