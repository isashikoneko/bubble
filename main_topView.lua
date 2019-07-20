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
local move_down = false

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
    world = World:init(0, 0)

    -- init game object
    player = Player:init(INIT_PLAYER_X, INIT_PLAYER_Y)
    world:addObject("player", player.body, 0)
    world:addObject('block1', Polygon:init(400, 200, {{0, 0}, {50, 0}, {50, 100}, {0, 100}}, 0), 1)

end

function love.update(dt)

    local player_appliedForce = Vector2:init(0, 0)

    if love.keyboard.isDown("i") then
        if world.gameObject["player"]["body"].appliedForce.y < -VERTICAL_SPEED_MAX then
            player_appliedForce.y = -PLAYER_VERTICAL_FORCE
        else
            world.gameObject["player"]["body"].appliedForce.y = -VERTICAL_SPEED_MAX
        end
        move_up = true
    else
        move_up = false
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

    if love.keyboard.isDown("k") then
        if world.gameObject["player"]["body"].appliedForce.y < VERTICAL_SPEED_MAX then
            player_appliedForce.y = PLAYER_VERTICAL_FORCE
        else
            world.gameObject["player"]["body"].appliedForce.y = VERTICAL_SPEED_MAX
        end
        move_down = true
    else
        move_down = false
    end

    world.gameObject["player"]["body"]:applyForce(player_appliedForce)

    if not move_left and not move_right then
        world.gameObject["player"]["body"].appliedForce.x = 0
    end

    if not move_up and not move_down then
        world.gameObject["player"]["body"].appliedForce.y = 0
    end

    world:applyForce()

    world.gameObject["player"]["body"]:update(time)

    world:update(time)

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
