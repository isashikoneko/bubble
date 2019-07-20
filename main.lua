
require("engine_config")
require(PHYSICS_ENGINE_PATH .. "World")
require(PHYSICS_ENGINE_PATH .. "Polygon")
require("Player")
require(PHYSICS_ENGINE_PATH .. "Vector2")


local touched = false

local world 
local player


WINDOWS_WIDTH = 640
WINDOWS_HEIGHT = 480

INIT_PLAYER_X = WINDOWS_WIDTH / 2
INIT_PLAYER_Y = WINDOWS_HEIGHT / 2

PLAYER_HORIZONTAL_FORCE = 200
PLAYER_VERTICAL_FORCE = 200

local move_right = false
local move_left = false
local move_up = false

local time = 0

function love.load()

    --Windows setting

    love.window.setTitle("Bubble")
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    love.window.setMode(WINDOWS_WIDTH, WINDOWS_HEIGHT, {
        vsync = false,
        centered = true
    })

    time = 1 / FPS

    -- init world
    world = World:init(0, GRAVITY_SPEED)

    -- init game object
    player = Player:init(INIT_PLAYER_X, INIT_PLAYER_Y)
    world:addObject("player", player.body, 0)
    world:addObject('ground', Polygon:init(0, 300, {{0, 0}, {WINDOWS_WIDTH * 3, 0}, {WINDOWS_WIDTH * 3, 500}, {0, 500}}, 0), 1)
    world:addObject('block1', Polygon:init(300, 200, {{0, 0}, {50, 0}, {50, 20}, {0, 20}}, 0), 1)
    world:addObject('block2', Polygon:init(500, 250, {{0, 0}, {50, -10}, {100, 0}, {100, 10}, {0, 10}}, 0), 1)
    world:addObject('block3', Polygon:init(400, 200, {{0, 0}, {50, 0}, {50, 100}, {0, 100}}, 0), 1)

end

function love.update(dt)

    local player_appliedForce = Vector2:init(0, 0)

    if love.keyboard.isDown("i") then
        if not move_up then
            player_appliedForce.y = -VERTICAL_SPEED_MAX
        end
    end

    if love.keyboard.isDown("l") then 
        if world.gameObject["player"]["body"].appliedForce.x < HORIZONTAL_SPEED_MAX then
            player_appliedForce.x = PLAYER_HORIZONTAL_FORCE
        else
            world.gameObject["player"]["body"].appliedForce.x = HORIZONTAL_SPEED_MAX
        end
        move_right = true
    else
        move_right = false
    end

    if love.keyboard.isDown("j") then
        if world.gameObject["player"]["body"].appliedForce.x > -HORIZONTAL_SPEED_MAX then
            player_appliedForce.x = -PLAYER_HORIZONTAL_FORCE
        else
            world.gameObject["player"]["body"].appliedForce.x = -HORIZONTAL_SPEED_MAX
        end
        move_left = true
    else
        move_left = false
    end

    world.gameObject["player"]["body"]:applyForce(player_appliedForce)

    if not move_left and not move_right then
        world.gameObject["player"]["body"].appliedForce.x = 0
    end

    world:applyForce()

    world.gameObject["player"]["body"]:update(time)

    world:update(time)

    move_up = true

    if world.gameObject["player"]["body"].velocity.x == 0 and world.gameObject["player"]["body"].velocity.y == 0 then
        world.gameObject["player"]["body"].appliedForce.y = 0
        move_up = false
    end

    player.body = world.gameObject["player"]["body"]

end

function love.draw()

    world:draw()
    player:draw()

end

function love.keypressed(key)

    if key == "escape" then

        love.event.quit()

    end

end

